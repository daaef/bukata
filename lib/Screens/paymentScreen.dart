import 'package:bukata/Screens/paymentDetails.dart';
import 'package:bukata/Screens/success.dart';
import 'package:flutter/material.dart';

class PaymentRadio extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final IconData icon;
  final bool value;
  final Function onChanged;

  const PaymentRadio(
      {Key key,
      this.label,
      this.padding,
      this.groupValue,
      this.icon,
      this.value,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 40.0,
              width: 40.0,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isRadioSelected = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orange[700],
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        elevation: 0,
        /*title: Text(
          "Payment",
          style: TextStyle(color: Colors.white),
        ),*/
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
                          "Choose your",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Colors.white.withOpacity(1)),
                        ),
                        Text(
                          "Payment Method",
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
                height: screenHeight - 190 - kToolbarHeight,
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
                    PaymentRadio(
                      label: 'Use a Credit / Debit Card',
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      value: true,
                      icon: Icons.credit_card,
                      groupValue: _isRadioSelected,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isRadioSelected = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    PaymentRadio(
                      label: 'Cash on Delivery',
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      value: false,
                      icon: Icons.money,
                      groupValue: _isRadioSelected,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isRadioSelected = newValue;
                        });
                      },
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => _isRadioSelected
                                      ? PaymentDetails()
                                      : SuccessScreen(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.orange.withOpacity(0.2),
                                        offset: Offset(0, 15),
                                        blurRadius: 10,
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                child: Text(
                                    _isRadioSelected ? "Proceed" : "Post",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                              ),
                            ),
                          ),
                        ),
                      ],
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
