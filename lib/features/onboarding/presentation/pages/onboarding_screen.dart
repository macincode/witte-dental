import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/network_aware_widget.dart';
import '../../data/models/onboarding_model.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_widget.dart';
import '../widgets/page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final size = MediaQuery.of(context).size;

    return NetworkAwareWidget(
      child: Scaffold(
        body: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: OnboardingData.pages.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: Listenable.merge([
                    controller.fadeAnimation,
                    controller.slideAnimation,
                  ]),
                  builder: (context, child) {
                    return OnboardingPageWidget(
                      page: OnboardingData.pages[index],
                      fadeAnimation: controller.fadeAnimation,
                      slideAnimation: controller.slideAnimation,
                      slideController: controller.slideController,
                    );
                  },
                );
              },
            ),

            // Skip Button
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 24,
              child: Obx(
                () => AnimatedOpacity(
                  opacity: controller.isLastPage.value ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: TextButton(
                    onPressed: controller.isLastPage.value
                        ? null
                        : controller.skipOnboarding,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Controls
            Positioned(
              bottom: size.height * 0.1,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Page Indicator
                    Obx(
                      () => PageIndicator(
                        currentPage: controller.currentPage.value,
                        totalPages: OnboardingData.pages.length,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Next/Get Started Button
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: controller.nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Text(
                            controller.isLastPage.value
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
