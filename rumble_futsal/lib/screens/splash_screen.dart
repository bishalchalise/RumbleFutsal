import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rumble_futsal/main.dart';
import 'package:rumble_futsal/utils/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any additional initialization code or data loading here
    // You can navigate to the desired screen after the splash duration
    Future.delayed(const Duration(seconds:4 ), () {
      MyApp.navigatorKey.currentState!.pushNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Lottie.asset('assets/splash.json',),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Rumble Futsal',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, color: Config.primaryColor,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
