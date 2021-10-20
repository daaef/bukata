import 'package:flutter/material.dart';

import 'otherDeliveryService.dart';

class PackageDescriptionScreen extends StatefulWidget {
  @override
  _PackageDescriptionScreenState createState() =>
      _PackageDescriptionScreenState();
}

class _PackageDescriptionScreenState extends State<PackageDescriptionScreen> {
  String _sizeSelected = "Light";
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
                          "Describe your",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.white.withOpacity(1)),
                        ),
                        Text(
                          "Package",
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
                          Icons.local_mall,
                          color: Colors.orange[800],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Describe Package",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      minLines: 3,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "e.g. a 32 inch TV Set",
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          Icons.network_check,
                          color: Colors.orange[800],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Package Weight",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildSizes(screenWidth),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtherDeliveryServices(),
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

  List _sizes = [
    {"weight": "Light", "image": "assets/feather.png"},
    {"weight": "Medium", "image": "assets/package-1.png"},
    {"weight": "Heavy", "image": "assets/trolley.png"},
  ];
  _buildSizes(screenWidth) {
    return _sizes
        .map((element) => InkWell(
              onTap: () {
                setState(() {
                  _sizeSelected = element["weight"];
                });
              },
              child: Container(
                height: 120,
                width: ((screenWidth - 60) / 3) - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: _sizeSelected == element["weight"]
                      ? Border.all(color: Colors.orange[800])
                      : Border.all(color: Colors.transparent),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      offset: Offset(
                          0, _sizeSelected == element["weight"] ? 4 : 15),
                      blurRadius: _sizeSelected == element["weight"] ? 2 : 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(element["image"], width: 60),
                    SizedBox(height: 10),
                    Text(element["weight"]),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
