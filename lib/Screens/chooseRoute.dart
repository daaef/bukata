import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:timelines/timelines.dart';

import 'packageDel.dart';

class ChooseRoute extends StatefulWidget {
  const ChooseRoute({Key key}) : super(key: key);

  @override
  _ChooseRouteState createState() => _ChooseRouteState();
}

class _ChooseRouteState extends State<ChooseRoute> {
  Position _currentPosition;
  bool _isLoading = false;
  bool isChecked = false;
  getPosition() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _isLoading = false;
    });
    print(position);
  }

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
                                  "Select",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(1)),
                                ),
                                Text(
                                  "Station",
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
                            SizedBox(
                              height: 15,
                            ),
                            TimelineTile(
                              nodePosition: 0.24,
                              nodeAlign: TimelineNodeAlign.basic,
                              oppositeContents: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('08:00'),
                                ),
                              ),
                              contents: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Card(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(13.0),
                                    child: Text(
                                      'Departed',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              node: TimelineNode(
                                indicator: DotIndicator(
                                  size: 7,
                                ),
                                startConnector: SizedBox(
                                  height: 30,
                                ),
                                endConnector: SolidLineConnector(),
                              ),
                            ),
                            TimelineTile(
                              nodePosition: 0.24,
                              nodeAlign: TimelineNodeAlign.basic,
                              oppositeContents: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('10:00'),
                                ),
                              ),
                              contents: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Card(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(13.0),
                                    child: Text(
                                      'Halfway',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              node: TimelineNode(
                                indicator: DotIndicator(
                                  size: 7,
                                ),
                                startConnector: SolidLineConnector(),
                                endConnector: SolidLineConnector(),
                              ),
                            ),
                            TimelineTile(
                              nodePosition: 0.24,
                              nodeAlign: TimelineNodeAlign.basic,
                              oppositeContents: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('12:13'),
                                ),
                              ),
                              contents: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Card(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(13.0),
                                    child: Text(
                                      'Arrived',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              node: TimelineNode(
                                indicator: DotIndicator(
                                  color: Colors.grey,
                                  size: 7,
                                ),
                                startConnector: SolidLineConnector(
                                  color: Colors.grey,
                                ),
                                endConnector: SizedBox(
                                  height: 30,
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PackageDeliveryTrackingPage(),
                                    // builder: (context) => RequestsScreen(),
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
