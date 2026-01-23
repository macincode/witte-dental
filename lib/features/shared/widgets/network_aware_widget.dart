import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/network_controller.dart';
import 'no_internet_screen.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget child;
  
  const NetworkAwareWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    
    return Obx(() {
      if (networkController.isConnected) {
        return child;
      } else {
        return const NoInternetScreen();
      }
    });
  }
}