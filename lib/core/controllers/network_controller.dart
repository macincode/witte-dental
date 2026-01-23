import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class NetworkController extends GetxController {
  final RxBool _isConnected = true.obs;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  bool get isConnected => _isConnected.value;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _listenToConnectivityChanges();
  }

  void _checkInitialConnection() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _isConnected.value = result != ConnectivityResult.none;
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}