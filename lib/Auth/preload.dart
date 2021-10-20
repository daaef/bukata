import 'package:bukata/Auth/signIn.dart';
import 'package:bukata/Screens/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class PreloadScreen extends StatefulWidget {
  @override
  _PreloadScreenState createState() => _PreloadScreenState();
}

class _PreloadScreenState extends State<PreloadScreen> {
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      checkUser();
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print("something is wrong");
    }
  }

  checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      } else {
        print('User is signed in!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LandingScreen(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/shape1.png",
                  width: screenWidth * 0.4,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/shape2.png",
                  width: screenWidth * 0.35,
                ),
              ),
              Positioned(
                top: 30,
                right: 30,
                child: Image.asset(
                  "assets/logo.png",
                  width: screenWidth * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                right: -120,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    "assets/man.png",
                    width: screenWidth * 0.7,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                right: 0,
                left: 0,
                child: Container(
                  height: screenHeight - 200,
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: SpinKitChasingDots(
                      color: Colors.orange[800],
                      size: 50.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
