import 'package:bukata/Screens/contactDetails.dart';
import 'package:flutter/material.dart';

class DateAndTimeScreen extends StatefulWidget {
  @override
  _DateAndTimeScreenState createState() => _DateAndTimeScreenState();
}

class _DateAndTimeScreenState extends State<DateAndTimeScreen> {
  String _timeSelected = "Morning";
  String _dateSelected = "Choose Date";
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
                          "Set your",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.white.withOpacity(1)),
                        ),
                        Text(
                          "Date & Time",
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
                          Icons.calendar_today,
                          color: Colors.orange[800],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Set Date & Time",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            Duration(days: 365),
                          ),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              _dateSelected =
                                  "${value.day} / ${value.month} / ${value.year}";
                            });
                          }
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_dateSelected),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        color: Colors.black.withOpacity(0.03),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: screenWidth - 60,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runAlignment: WrapAlignment.spaceBetween,
                        runSpacing: 10,
                        children: _buildSizes(screenWidth),
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(),
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
    {"time": "Morning", "image": "assets/sunrise.png", "desc": " Before 10am"},
    {"time": "Mid Day", "image": "assets/dawn.png", "desc": "10am - 2pm"},
    {"time": "Afternoon", "image": "assets/sun.png", "desc": "2pm - 6pm"},
    {"time": "Evening", "image": "assets/half-moon.png", "desc": " After 6pm"},
  ];
  _buildSizes(screenWidth) {
    return _sizes
        .map((element) => InkWell(
              onTap: () {
                setState(() {
                  _timeSelected = element["time"];
                });
              },
              child: Container(
                height: 100,
                width: ((screenWidth - 60) / 2) - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: _timeSelected == element["time"]
                      ? Border.all(color: Colors.orange[800])
                      : Border.all(color: Colors.transparent),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      offset:
                          Offset(0, _timeSelected == element["time"] ? 4 : 15),
                      blurRadius: _timeSelected == element["time"] ? 2 : 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(element["image"], width: 40),
                    SizedBox(height: 10),
                    Text(
                      element["time"],
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 3),
                    Text(
                      element["desc"],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
