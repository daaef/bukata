import 'package:bukata/Auth/signIn.dart';
import 'package:bukata/Screens/driverIdentify.dart';
import 'package:bukata/Screens/selectRoute.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: SizedBox(
        width: screenWidth * 0.7,
        child: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    "Elvin Opara",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  accountEmail: Text(
                    "4everlvin@gmail.com",
                    style: TextStyle(color: Colors.white),
                  ),
                  decoration: BoxDecoration(color: Colors.orange[800]),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      "EO",
                      style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: -2,
                          color: Colors.orange[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    // widget.gotoPage(page: 7);
                  },
                  title:
                      Text("Dashboard", style: TextStyle(color: Colors.black)),
                  leading: Icon(Icons.dashboard, color: Colors.orange),
                ),
                ListTile(
                  onTap: () {
                    // widget.gotoPage(page: 6);
                  },
                  title: Text("Request History",
                      style: TextStyle(color: Colors.black)),
                  leading: Icon(Icons.history, color: Colors.orange),
                ),
                ListTile(
                  onTap: () {
                    // widget.gotoPage(page: 6);
                  },
                  title: Text("Offers", style: TextStyle(color: Colors.black)),
                  leading:
                      Icon(Icons.notifications_active, color: Colors.orange),
                ),
                Divider(color: Colors.black26),
                ListTile(
                  onTap: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => AuthLanding()));
                  },
                  title:
                      Text("Settings", style: TextStyle(color: Colors.black)),
                  leading: Icon(Icons.settings, color: Colors.orange),
                ),
                ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  },
                  title:
                      Text("Sign Out", style: TextStyle(color: Colors.black)),
                  leading: Icon(Icons.exit_to_app, color: Colors.orange),
                ),
              ],
            ),
          ),
        ),
      ),
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
                  opacity: 0.3,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: items,
                      options: CarouselOptions(
                        height: 170,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.orange),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "What do you",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: Colors.orange.withOpacity(1)),
                                  ),
                                  Text(
                                    "want to do",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        color:
                                            Colors.orange[800].withOpacity(1)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectRouteScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  width: (screenWidth * 0.5) - 35,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[700],
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.15),
                                        offset: Offset(0, 15),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/package.png",
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Send\nPackage",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DriverIdentify(),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  width: (screenWidth * 0.5) - 35,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[900],
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange[900]
                                            .withOpacity(0.15),
                                        offset: Offset(0, 15),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/box.png",
                                        width: 80,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Deliver\nPackage",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 30,
                left: 10,
                child: Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      print("hello");

                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> items = [
    Container(
      height: 120,
      child: Image.asset("assets/slide1.png"),
    ),
    Container(
      height: 120,
      child: Image.asset("assets/slide2.png"),
    ),
  ];
}
