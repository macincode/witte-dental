import 'package:flutter/material.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingPageWidget extends StatelessWidget {

  const OnboardingPageWidget({
    required this.page, required this.fadeAnimation, required this.slideAnimation, required this.slideController, super.key,
  });
  final OnboardingPage page;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController slideController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: page.gradientColors,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Illustration Area
              FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: Container(
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: _buildIcon(),
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Title
              FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: slideController,
                    curve: const Interval(0.2, 1, curve: Curves.easeOutCubic),
                  ),),
                  child: Text(
                    page.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Description
              FadeTransition(
                opacity: fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.7),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: slideController,
                    curve: const Interval(0.4, 1, curve: Curves.easeOutCubic),
                  ),),
                  child: Text(
                    page.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    
    switch (page.iconData) {
      case 'shield_health':
        iconData = Icons.security;
        break;
      case 'analytics_health':
        iconData = Icons.analytics;
        break;
      case 'doctor_connect':
        iconData = Icons.medical_services;
        break;
      case 'health_journey':
        iconData = Icons.favorite;
        break;
      default:
        iconData = Icons.health_and_safety;
    }

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.15),
      ),
      child: Icon(
        iconData,
        size: 60,
        color: Colors.white,
      ),
    );
  }
}