import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/routing/app_route_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.goNamed(MyAppRouteConstants.loginRouteName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: const Color(0xffDCDCD7),
        child: Center(
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(colors: [
              Color(0xff061618),
              Color(0xff07171B),
              Color(0xff3B4A32),
              Color(0xff976F37),
              Color(0xffDCDCD7)
            ]).createShader(bounds),
            child: const Text(
              'B L O G A P P',
              style: TextStyle(
                  fontFamily: 'chiro',
                  color: Colors.white,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                  fontSize: 60),
            ),
          ),
          // child: Text(
          //   'B L O G A P P',
          //   style: TextStyle(
          //       fontFamily: 'roboto',
          //       color: Color(0xffE50914),
          //       letterSpacing: 8,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 22),
          // ),
        ),
      ),
    );
  }
}
