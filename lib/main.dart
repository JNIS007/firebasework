import 'package:flutter/material.dart';
import 'package:untitled/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/ui/splash_screen.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true// text/icon color
        ),
      ),

      home: const SplashScreen(),
    );
  }
}


