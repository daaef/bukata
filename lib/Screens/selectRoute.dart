import 'package:bukata/Screens/packageDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class SelectRouteScreen extends StatefulWidget {
  @override
  _SelectRouteScreenState createState() => _SelectRouteScreenState();
}

class _SelectRouteScreenState extends State<SelectRouteScreen> {
  Position _currentPosition;
  bool _isLoading = true;
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
    getPosition();
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
                                  "Choose your",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20,
                                      color: Colors.white.withOpacity(1)),
                                ),
                                Text(
                                  "Route",
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
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       checkColor: Colors.white,
                            //       fillColor: MaterialStateProperty.resolveWith(
                            //           getColor),
                            //       value: isChecked,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           isChecked = value;
                            //         });
                            //       },
                            //     ),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Text(
                            //       "Use existing Delivery Companies",
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 16,
                            //           color: Colors.black),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_searching,
                                  color: Colors.orange[800],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Pickup Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Enter Address",
                              style: TextStyle(color: Colors.orange),
                            ),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Pick Up address",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.location_on),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                          apiKey:
                                              "AIzaSyCnsV15LLfhEoZgC_UFuhPXTS9aSVgWEpo", // Put YOUR OWN KEY here.
                                          onPlacePicked: (result) {
                                            print(result.formattedAddress);
                                            Navigator.of(context).pop();
                                          },
                                          usePinPointingSearch: true,
                                          usePlaceDetailSearch: true,
                                          initialPosition: LatLng(
                                            _currentPosition.latitude,
                                            _currentPosition.longitude,
                                          ),
                                          useCurrentLocation: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Icon(
                                  Icons.my_location,
                                  color: Colors.orange[800],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Package Destination",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Enter Address",
                              style: TextStyle(color: Colors.orange),
                            ),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: "Drop Off address",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.location_on),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlacePicker(
                                            apiKey:
                                                "AIzaSyCnsV15LLfhEoZgC_UFuhPXTS9aSVgWEpo", // Put YOUR OWN KEY here.
                                            onPlacePicked: (result) {
                                              print(result.formattedAddress);
                                              Navigator.of(context).pop();
                                            },
                                            usePinPointingSearch: true,
                                            usePlaceDetailSearch: true,
                                            initialPosition: LatLng(
                                              _currentPosition.latitude,
                                              _currentPosition.longitude,
                                            ),
                                            useCurrentLocation: true,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PackageDescriptionScreen(),
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
