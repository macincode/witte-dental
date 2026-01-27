import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/hive_service.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingController extends GetxController
    with GetTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController fadeController;
  late AnimationController slideController;

  final RxInt currentPage = 0.obs;
  final RxBool isLastPage = false.obs;

  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    _initControllers();
  }

  void _initControllers() {
    pageController = PageController();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeInOut,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: slideController,
        curve: Curves.easeOutCubic,
      ),
    );

    _startAnimations();
  }

  void _startAnimations() {
    fadeController.forward();
    slideController.forward();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    isLastPage.value = page == OnboardingData.pages.length - 1;

    // Reset and restart animations for new page
    fadeController.reset();
    slideController.reset();
    _startAnimations();
  }

  void nextPage() {
    if (isLastPage.value) {
      completeOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await HiveService.saveSetting('onboarding_completed', true);
    Get.offAllNamed(AppConstants.loginRoute);
  }

  @override
  void onClose() {
    pageController.dispose();
    fadeController.dispose();
    slideController.dispose();
    super.onClose();
  }
}
