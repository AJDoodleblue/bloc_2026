import 'package:bloc_2026/core/constants/asset_path.dart';
import 'package:bloc_2026/core/constants/constant.dart';
import 'package:bloc_2026/core/constants/routes.dart';
import 'package:bloc_2026/core/database/hive_storage_service.dart';
import 'package:bloc_2026/core/network/network_service.dart';
import 'package:bloc_2026/shared/theme/app_colors.dart';
import 'package:bloc_2026/shared/theme/text_styles.dart';
import 'package:bloc_2026/shared/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _checkAuthAndNavigate();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final hiveService = GetIt.instance<HiveService>();
    final token = await hiveService.get(userToken);

    if (token != null && token.toString().isNotEmpty) {
      final networkService = GetIt.instance<NetworkService>();
      networkService.updateHeader({
        'Authorization': 'Bearer $token',
      });

      if (mounted) {
        context.go(RoutesName.homePage);
      }
    } else {
      if (mounted) {
        context.go(RoutesName.loginPath);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.colorPrimary,
              AppColors.colorPrimaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.colorWhite.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: getSvg(
                              AssetPath.splashIcon,
                              width: 80,
                              height: 80,
                              color: AppColors.colorWhite,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "BLOC 2026",
                          style: AppTextStyles.openSansBold32.copyWith(
                            color: AppColors.colorWhite,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Learn Clean Architecture",
                          style: AppTextStyles.openSansRegular14.copyWith(
                            color: AppColors.colorWhite.withValues(alpha: 0.8),
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.colorWhite.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
