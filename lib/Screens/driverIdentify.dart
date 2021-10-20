import 'package:bukata/Screens/journeyDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class DriverIdentify extends StatefulWidget {
  const DriverIdentify({Key key}) : super(key: key);

  @override
  _DriverIdentifyState createState() => _DriverIdentifyState();
}

class _DriverIdentifyState extends State<DriverIdentify> {
  bool _isLoading = false;
  bool _hasError = false;
  String _countryCode = "234";
  String _isRadioSelected = 'riding';

  String _networkError = "";
  Country _selectedCountry;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passNumController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  bool _transportMode = false;

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
                top: 150,
                right: 0,
                left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    "Identity",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.orange.withOpacity(1)),
                                  ),
                                  Text(
                                    "Verification",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 28,
                                        color:
                                            Colors.orange[800].withOpacity(1)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 242,
                right: 0,
                left: 0,
                child: Container(
                  height: screenHeight - 242,
                  width: screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: screenWidth,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Full Name",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                        TextField(
                                          controller: _usernameController,
                                          onChanged: (value) {
                                            setState(() {
                                              _hasError = false;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Aef Badmus",
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Phone Number",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                        Row(
                                          children: [
                                            CountryPicker(
                                              showDialingCode: true,
                                              showFlag: true,
                                              showName: false,
                                              dialingCodeTextStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                              onChanged: (Country country) {
                                                setState(() {
                                                  _selectedCountry = country;
                                                  _countryCode =
                                                      country.dialingCode;
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
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: "Phone Number",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Passport Number",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                        TextField(
                                          controller: _passNumController,
                                          onChanged: (value) {
                                            setState(() {
                                              _hasError = false;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "C, F, G, H, J, K /0 - 9",
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(height: 20),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JourneyDetails(),
                                              ),
                                            );
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.orange
                                                          .withOpacity(0.2),
                                                      offset: Offset(0, 15),
                                                      blurRadius: 10,
                                                      spreadRadius: 1)
                                                ]),
                                            child: Center(
                                              child: Text("Continue",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key key,
    this.label,
    this.padding,
    this.value,
    this.onChanged,
    this.groupValue,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final String value;
  final Function onChanged;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio(
              groupValue: groupValue,
              value: value,
              onChanged: (newValue) {
                onChanged(newValue);
              },
            ),
            Container(
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
