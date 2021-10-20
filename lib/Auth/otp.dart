import 'dart:async';

import 'package:bukata/Screens/landing.dart';
import 'package:bukata/Widgets/shakeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String username;

  const OTPScreen(
      {Key key, this.verificationId, this.phoneNumber, this.username})
      : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String _otpValue = "";
  String _verificationId = "";
  String _networkError = "";

  int _time = 59;
  bool _canResend = true;
  bool _isLoading = false;
  bool _hasError = false;
  Timer _myTimer;

  verifyOTP() async {
    setState(() {
      _isLoading = true;
    });
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _otpValue);

    try {
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(phoneAuthCredential);
      addUser();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      setState(() {
        _hasError = true;

        _networkError = e.code.replaceAll(new RegExp(r'-'), ' ');
        _isLoading = false;
      });
    }
  }

  addUser() {
    FirebaseFirestore.instance.collection('users').doc(widget.phoneNumber).set({
      'user_name': widget.username, // John Doe
      'phone': widget.phoneNumber // +234998989898,
    }).then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    }).catchError((error) => print("Failed to add user: $error"));
  }

  startResendCountDown() {
    setState(() {
      _canResend = false;
    });
    signUp();
    _myTimer = Timer.periodic(Duration(seconds: 1), (time) {
      if (_time == 0) {
        _myTimer.cancel();
        setState(() {
          _canResend = true;
          _time = 59;
        });
        return;
      }
      setState(() {
        _time = _time - 1;
      });
    });
  }

  signUp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: verificationComplete,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      timeout: Duration(seconds: 0),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verificationComplete(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print(userCredential);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      setState(() {
        _hasError = true;

        _networkError = e.code.replaceAll(new RegExp(r'-'), ' ');
        _isLoading = false;
      });
    }
  }

  verificationFailed(FirebaseAuthException e) {
    print(e.code);
    print(e.message);
    setState(() {
      _hasError = true;

      _networkError = e.code.replaceAll(new RegExp(r'-'), ' ');
      _isLoading = false;
    });
  }

  codeSent(String verificationId, int resendToken) {
    setState(() {
      _verificationId = verificationId;
    });
    // Code has been sent
  }

  @override
  void initState() {
    _verificationId = widget.verificationId;
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
                top: 60,
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
                top: 230,
                right: 0,
                left: 0,
                child: Container(
                  height: screenHeight - 230,
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Input the One Time Password (OTP) that was sent to you",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PinCodeTextField(
                        autoFocus: true,
                        textInputType: TextInputType.number,
                        length: 6,
                        obsecureText: false,
                        animationType: AnimationType.fade,
                        textStyle: TextStyle(color: Colors.black, fontSize: 20),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 45,
                          fieldWidth: 45,
                          activeFillColor: Colors.white,
                          selectedColor: Colors.orange,
                          inactiveColor: Colors.yellow,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: false,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            _hasError = false;
                            _otpValue = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AbsorbPointer(
                        absorbing: !_canResend,
                        child: InkWell(
                          onTap: startResendCountDown,
                          child: Opacity(
                            opacity: _canResend ? 1 : 0.5,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Did not receive an OTP? ",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  Text(
                                    "Resend",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Opacity(
                        child: Text(
                          "Can Resend again in ${_time}s",
                          style: TextStyle(color: Colors.white),
                        ),
                        opacity: _canResend ? 0 : 1,
                      ),
                      Expanded(
                        child: Container(
                          child: _isLoading
                              ? Center(
                                  child: SpinKitChasingDots(
                                    color: Colors.orange[800],
                                    size: 50.0,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      _hasError
                          ? ShakeWidget(
                              duration: Duration(milliseconds: 1000),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Text("ERROR",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _networkError,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: _isLoading
                            ? null
                            : () {
                                verifyOTP();
                              },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.orange.withOpacity(0.2),
                                    offset: Offset(0, 15),
                                    blurRadius: 10,
                                    spreadRadius: 1)
                              ]),
                          child: Center(
                            child: Text("Confirm",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
