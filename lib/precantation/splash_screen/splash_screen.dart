import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../../api/services.dart';
import '../../core/colors.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const Home(),
      duration: 8500,
      imageSize: 200,
      imageSrc: 'lib/asset/plane.png',
      backgroundColor: kSplashColor,
    );
  }
}
