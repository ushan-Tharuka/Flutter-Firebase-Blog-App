import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:blog_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    //If null login and if not go to home screen
    Future.delayed(const Duration(seconds: 3)).then((onValue) {
      if (auth.currentUser == null) {
        //after 3seconds login screen open
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }else{
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 100,
        ),
      ),
    );
  }
}
