import 'package:flutter/material.dart';

class OnboardingPage {

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.iconData,
    required this.gradientColors,
  });
  final String title;
  final String description;
  final String iconData;
  final List<Color> gradientColors;
}

class OnboardingData {
  static final List<OnboardingPage> pages = [
    const OnboardingPage(
      title: 'Secure Health Records',
      description: 'Your medical data is encrypted and stored securely with bank-level protection.',
      iconData: 'shield_health',
      gradientColors: [Color(0xFF667eea), Color(0xFF764ba2)],
    ),
    const OnboardingPage(
      title: 'Smart Health Insights',
      description: 'AI-powered analytics help you understand your health patterns and trends.',
      iconData: 'analytics_health',
      gradientColors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
    ),
    const OnboardingPage(
      title: 'Connect with Doctors',
      description: 'Book appointments and consult with certified healthcare professionals.',
      iconData: 'doctor_connect',
      gradientColors: [Color(0xFF11998e), Color(0xFF38ef7d)],
    ),
    const OnboardingPage(
      title: 'Your Health Journey',
      description: 'Take control of your wellness with personalized care plans and reminders.',
      iconData: 'health_journey',
      gradientColors: [Color(0xFF8360c3), Color(0xFF2ebf91)],
    ),
  ];
}