import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dateAndTime.dart';

class OtherDeliveryServices extends StatefulWidget {
  @override
  _OtherDeliveryServicesState createState() => _OtherDeliveryServicesState();
}

class _OtherDeliveryServicesState extends State<OtherDeliveryServices> {
  bool _isLoading = false;
  bool isChecked = false;
  var company;
  List<String> _companies = [
    'Amazon',
    'Ebay',
    'UPS',
    'DHL',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.orange[800];
    }

    return Scaffold(
      backgroundColor: Colors.orange[700],
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        elevation: 0,
        // title: Text("Send Package"),
        centerTitle: false,
      ),
      body: _isLoading
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  height: screenHeight - kToolbarHeight - 40,
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
                                  "Other",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(1)),
                                ),
                                Text(
                                  "Delivery Services",
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
                        height: screenHeight - 200 - kToolbarHeight,
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
                            DropdownButton(
                              hint: Text(
                                'Select a Company',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              dropdownColor: Colors.white,
                              value: company,
                              focusColor: Colors.blue,
                              isExpanded: true,
                              items: _companies.map((String plan) {
                                return DropdownMenuItem<String>(
                                  value: plan,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        plan,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  company = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DateAndTimeScreen(),
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
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
            ),
    );
  }
}
