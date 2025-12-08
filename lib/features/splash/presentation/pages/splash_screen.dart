import 'dart:async' show Timer;

import 'package:bloc_2026/core/constants/asset_path.dart';
import 'package:bloc_2026/core/constants/routes.dart';
import 'package:bloc_2026/shared/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.go(RoutesName.loginPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getSvg(AssetPath.splashIcon),
            SizedBox(height: 20),
            Text(
              "Welcome to My App",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
