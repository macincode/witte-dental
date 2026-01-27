import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/hive_service.dart';
import 'dart:math' as math;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late AnimationController _ctaController;
  
  late Animation<double> _orbitAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _ctaAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startSequence();
  }

  void _initAnimations() {
    _orbitController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _ctaController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _orbitAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _orbitController,
      curve: Curves.linear,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    _ctaAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _ctaController,
      curve: Curves.elasticOut,
    ));
  }

  void _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
    
    await Future.delayed(const Duration(milliseconds: 600));
    _orbitController.repeat();
    _glowController.repeat(reverse: true);
    
    await Future.delayed(const Duration(milliseconds: 1000));
    _ctaController.forward();
    
    await Future.delayed(const Duration(seconds: 3));
    
    // Check if onboarding is completed
    final onboardingCompleted = HiveService.getSetting<bool>('onboarding_completed') ?? false;
    
    if (onboardingCompleted) {
      Get.offAllNamed(AppConstants.loginRoute);
    } else {
      Get.offAllNamed(AppConstants.onboardingRoute);
    }
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _scaleController.dispose();
    _glowController.dispose();
    _ctaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF0A0A0A),
                ],
              ),
            ),
          ),
          
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _orbitAnimation,
                _scaleAnimation,
                _glowAnimation,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: size.width * 0.8,
                    child: CustomPaint(
                      painter: OrbitPainter(
                        orbitProgress: _orbitAnimation.value,
                        glowIntensity: _glowAnimation.value,
                      ),
                      child: Center(
                        child: _buildCenterIcon(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          Positioned(
            bottom: size.height * 0.20,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _scaleAnimation.value.clamp(0.0, 1.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        AppConstants.appName,
                        style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28,
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dentalcare Management',
                        style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          // fontSize: 28,
                                          color: Colors.white.withOpacity(0.6),
                                          // letterSpacing: 1.5,
                                        ),
                        
                       
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Positioned(
          //   bottom: size.height * 0.1,
          //   left: 0,
          //   right: 0,
          //   child: AnimatedBuilder(
          //     animation: _ctaAnimation,
          //     builder: (context, child) {
          //       return Transform.scale(
          //         scale: _ctaAnimation.value,
          //         child: Center(
          //           child: Container(
          //             width: 60,
          //             height: 60,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               gradient: const LinearGradient(
          //                 colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
          //               ),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: const Color(0xFF00D4FF).withOpacity(0.3),
          //                   blurRadius: 20,
          //                   spreadRadius: 2,
          //                 ),
          //               ],
          //             ),
          //             child: const Icon(
          //               Icons.arrow_forward_ios,
          //               color: Colors.white,
          //               size: 24,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildCenterIcon() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
           
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withOpacity((_glowAnimation.value * 0.5).clamp(0.0, 1.0)),
                blurRadius: 30 * _glowAnimation.value.clamp(0.0, 1.0),
                spreadRadius: 5 * _glowAnimation.value.clamp(0.0, 1.0),
              ),
            ],
          ),
          child: Image.asset(
          'assets/images/appLogo.png',
          fit: BoxFit.cover, 
          ),
        );
      },
    );
  }
}

class OrbitPainter extends CustomPainter {
  final double orbitProgress;
  final double glowIntensity;
  
  OrbitPainter({
    required this.orbitProgress,
    required this.glowIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius1 = size.width * 0.25;
    final radius2 = size.width * 0.35;
    final radius3 = size.width * 0.45;
    
    _drawOrbitRing(canvas, center, radius1, orbitProgress, const Color(0xFF00D4FF), 0);
    _drawOrbitRing(canvas, center, radius2, orbitProgress * 0.7, const Color(0xFF0099CC), math.pi / 3);
    _drawOrbitRing(canvas, center, radius3, orbitProgress * 0.5, const Color(0xFF006699), math.pi / 2);
  }
  
  void _drawOrbitRing(
    Canvas canvas,
    Offset center,
    double radius,
    double progress,
    Color color,
    double offset,
  ) {
    final paint = Paint()
      ..color = color.withOpacity((0.3 + glowIntensity * 0.4).clamp(0.0, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawCircle(center, radius, paint);
    
    final particleAngle = progress + offset;
    final particleX = center.dx + radius * math.cos(particleAngle);
    final particleY = center.dy + radius * math.sin(particleAngle);
    
    final particlePaint = Paint()..color = color;
    
    canvas.drawCircle(Offset(particleX, particleY), 4, particlePaint);
  }

  @override
  bool shouldRepaint(covariant OrbitPainter oldDelegate) {
    return oldDelegate.orbitProgress != orbitProgress ||
           oldDelegate.glowIntensity != glowIntensity;
  }
}