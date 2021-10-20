import 'package:bukata/Auth/otp.dart';
import 'package:bukata/Screens/landing.dart';
import 'package:bukata/Widgets/shakeWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignIn = false;
  bool _isLoading = false;
  bool _hasError = false;
  String _countryCode = "234";

  String _networkError = "";
  Country _selectedCountry;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  authenticate() {
    if (_phoneController.text.isEmpty || _usernameController.text.isEmpty) {
      setState(() {
        _hasError = true;

        _networkError = "All fields are required";
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });

    if (_isSignIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    } else {
      signUp();
    }
  }

  signUp() async {
    await auth.verifyPhoneNumber(
      phoneNumber:
          '+' + _countryCode + int.parse(_phoneController.text).toString(),
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
      _isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
          username: _usernameController.text,
          phoneNumber:
              '+' + _countryCode + int.parse(_phoneController.text).toString(),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      var userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredentials);
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

  @override
  void initState() {
    _selectedCountry = Country.NG;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isSignIn = false;
                                _hasError = false;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: _isSignIn ? 14 : 20,
                                      color: _isSignIn
                                          ? Colors.black26
                                          : Colors.black),
                                ),
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _isSignIn ? 17 : 20,
                                      color: _isSignIn
                                          ? Colors.black26
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isSignIn = true;
                                _hasError = false;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: _isSignIn ? 20 : 14,
                                      color: _isSignIn
                                          ? Colors.black
                                          : Colors.black26),
                                ),
                                Text(
                                  "To Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: _isSignIn ? 20 : 17,
                                      color: _isSignIn
                                          ? Colors.black
                                          : Colors.black26),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: _isSignIn
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.orange, width: 150, height: 5),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      !_isSignIn
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                TextField(
                                  controller: _usernameController,
                                  onChanged: (value) {
                                    setState(() {
                                      _hasError = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "John Doe",
                                      prefixIcon: Icon(Icons.person_outline)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : Container(),
                      Text(
                        "Phone Number",
                        style: TextStyle(color: Colors.orange),
                      ),
                      Row(
                        children: [
                          CountryPicker(
                            showDialingCode: true,
                            showFlag: true,
                            showName: false,
                            dialingCodeTextStyle:
                                TextStyle(color: Colors.black, fontSize: 18),
                            onChanged: (Country country) {
                              setState(() {
                                _selectedCountry = country;
                                _countryCode = country.dialingCode;
                              });
                            },
                            selectedCountry: _selectedCountry,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              onChanged: (value) {
                                setState(() {
                                  _hasError = false;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                              ),
                            ),
                          ),
                        ],
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
                                      height: 5,
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
                      SizedBox(height: 10),
                      InkWell(
                        onTap: _isLoading
                            ? null
                            : () {
                                authenticate();
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
                            child: Text(_isSignIn ? "Sign In" : "Sign Up",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(child: Text("or")),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  signInWithGoogle();
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: (screenWidth * 0.5) - 50,
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.15),
                                            offset: Offset(0, 15),
                                            blurRadius: 10,
                                            spreadRadius: 1)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/google.png",
                                        width: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Google",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: (screenWidth * 0.5) - 50,
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(60, 83, 154, 1),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                60, 83, 154, 0.2),
                                            offset: Offset(0, 15),
                                            blurRadius: 8,
                                            spreadRadius: 1)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/facebook.png",
                                        width: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Facebook",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
