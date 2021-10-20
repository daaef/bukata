import 'package:bukata/Screens/setBudget.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orange[700],
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        elevation: 0,
        // title: Text("Send Package"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.orange[700],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Set receivers",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.white.withOpacity(1)),
                        ),
                        Text(
                          "Contact Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white.withOpacity(1)),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/logo-white.png",
                      width: 80,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 20,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.orange,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                height: screenHeight - 180 - kToolbarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.orange[800],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Receiver Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Receiver Name",
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "e.g. John Doe",
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Receiver Phone Number",
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "e.g. 08031234567",
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetBudgetScreen(),
                          ),
                        );
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
                          child: Text("Continue",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
