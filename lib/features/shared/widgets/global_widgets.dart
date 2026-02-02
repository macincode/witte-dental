import 'package:flutter/foundation.dart';

void dPrint(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}

void dLog(String message) {
  if (kDebugMode) {
    // You can replace this with any logging mechanism you prefer
    debugPrint(message);
  }
}
