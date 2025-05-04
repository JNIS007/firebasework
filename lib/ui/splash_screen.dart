import 'package:flutter/material.dart';
import 'package:untitled/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

SplashServices _splashScreen = SplashServices();
  @override
  void initState(){


    super.initState();

    _splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Firebase'),
      ),
    );
  }
}
