import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:witte_dental_pms/core/constants/api_endpoints.dart';
import 'package:witte_dental_pms/core/handlers/error_handler.dart';
import 'package:witte_dental_pms/core/storage/hive_service.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

class ApiServices {
  ApiServices()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
            },
          ),
        ) {
    // Configure for localhost and HTTP with proper threading
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient()
        ..badCertificateCallback = (cert, host, port) => true;
      client.findProxy = (uri) => 'DIRECT';
      return client;
    };

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final hiveService = Get.find<HiveService>();
          final authResponse = hiveService.getAuthResponse();
          if (options.path.startsWith('http://localhost') ||
              options.path.startsWith('http://127.0.0.1')) {
            options.baseUrl = '';
          }

          if (!options.path.contains('/admin/login') &&
              !options.path.contains('/logout')) {
            if (authResponse?.token != null) {
              options.headers['Authorization'] =
                  'Bearer ${authResponse!.token}';
              dPrint('Added Authorization header with Bearer token');

              // Add X-Business-ID header for admin dashboard requests
              if (options.path.contains('/admin/dashboard')) {
                // First try to get from currentBusiness, then use default fallback
                String? businessId;
                if (authResponse.currentBusiness != null) {
                  businessId = authResponse.currentBusiness['id']?.toString();
                } else {
                  businessId = '1'; // Default fallback
                }

                options.headers['X-Business-ID'] = businessId;
                dPrint('Added X-Business-ID header: $businessId');
              }
            } else {
              dPrint(
                'WARNING: Token is empty or null, skipping Authorization header',
              );
            }

            dPrint('Request: ${options.method} ${options.path}');
            dPrint('Headers: ${options.headers}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          dPrint('Output Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
      ),
    );
  }
  final Dio _dio;

  // Helper to build endpoint with baseUrl if provided
  String _buildUrl(String endpoint, String? baseUrl) {
    if (baseUrl == null) return endpoint;
    // Ensure slashes are handled properly
    if (endpoint.startsWith('http')) return endpoint;
    if (baseUrl.endsWith('/') && endpoint.startsWith('/')) {
      return baseUrl + endpoint.substring(1);
    } else if (!baseUrl.endsWith('/') && !endpoint.startsWith('/')) {
      return '$baseUrl/$endpoint';
    } else {
      return '$baseUrl$endpoint';
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options ??
            Options(
              validateStatus: (status) => status != null && status <= 422,
              sendTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
              headers: headers,
            ),
      );
      return response;
    } on DioException catch (e) {
      dPrint('---GET Request Error---');
      _handleDioError(e);
      dPrint(e);
      dPrint('---GET Request Error---');
      rethrow;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              validateStatus: (status) => status != null && status <= 422,
              sendTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
            ),
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              validateStatus: (status) => status! < 500 || status >= 500,
            ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  Future<void> _handleDioError(DioException e) async {
    String errorMessage;

    if (e.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection timed out. Please check your internet.';
    } else if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown) {
      if (e.error is SocketException) {
        // Check connectivity before deciding
        final connectivity = await Connectivity().checkConnectivity();

        if (connectivity == ConnectivityResult.none) {
          errorMessage = 'No Internet Connection. Please check your network.';
        } else {
          final online = await hasInternet();
          if (!online) {
            errorMessage = 'No Internet Access. Please check your connection.';
          } else {
            errorMessage = 'Server unreachable. Please try again later.';
          }
        }
      } else {
        errorMessage = 'Network error occurred';
      }
    } else if (e.type == DioExceptionType.badResponse) {
      errorMessage =
          'Server returned error ${e.response?.statusCode ?? "Unknown"}: ${e.response?.statusMessage ?? "No message"}';
    } else {
      errorMessage = 'Unknown network error: ${e.message}';
    }
    // Navigate only if not already on error page
    if (Get.currentRoute != '/error') {
      dPrint('&**********');
      dPrint(errorMessage);
      dPrint('&**********');
      Get.to(
        () => ErrorPage(message: errorMessage),
      );
    }
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Additional methods for compatibility
  Future<Response> postFormDataRequest(
    String endpoint,
    FormData formData, [
    String? baseUrl,
  ]) async {
    try {
      final url = _buildUrl(endpoint, baseUrl);
      final response = await _dio.post(url, data: formData);
      return response;
    } catch (e) {
      throw Exception('Failed to post form data: $e');
    }
  }
}
