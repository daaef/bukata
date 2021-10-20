import 'package:bukata/Screens/requestDetail.dart';
import 'package:flutter/material.dart';

class RequestsScreen extends StatefulWidget {
  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List _requests = [
    {
      "name": "John Doe",
      "amount": "1200",
      "pickup": "First Gate Dadinkowa",
      "dropoff": "Mees Palace, Rayfield",
      "weight": "Heavy",
      "date": "Monday",
      "time": "Mid day - 10am to 2pm ",
      "requests": "5",
      "description":
          "3 cartons of indomie noodles to be delivered to mees palace kitchen"
    },
    {
      "name": "Afe Badmus",
      "amount": "500",
      "pickup": "Sparkling Junction",
      "dropoff": "nHub Incubation & Acceleration",
      "weight": "Light",
      "date": "Tuesday",
      "time": "Morning - Before 10am ",
      "requests": "2",
      "description": "A USB flash drive"
    },
    {
      "name": "Mr Kwopnan",
      "amount": "750",
      "pickup": "Nigerian Air force",
      "dropoff": "Guaranty Trust Bank, British RD",
      "weight": "Medium",
      "date": "Tuesday",
      "time": "Afternoon - 2pm to 6pm",
      "requests": "3",
      "description": "Rolex wrist watch and an iPhone Battery"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight - kToolbarHeight,
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "3 Tasks Available",
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    child: Row(
                  children: [Text("Sort by"), Icon(Icons.arrow_drop_down)],
                ))
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: screenHeight - kToolbarHeight - 124,
              child: ListView.builder(
                  itemCount: _requests.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RequestDetailScreen(
                                  task: _requests[index],
                                ),
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: Offset(0, 10),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    child: Text(
                                      _requests[index]["name"][0],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.orange,
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _requests[index]["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _requests[index]["requests"] +
                                            " Requests",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _requests[index]["amount"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.orange[900]),
                                      ),
                                      Text(_requests[index]["weight"]),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            shape: BoxShape.circle),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15, top: 5, bottom: 5),
                                        width: 1,
                                        height: 15,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_requests[index]["pickup"]),
                                      Container(
                                        height: 15,
                                        color: Colors.grey,
                                      ),
                                      Text(_requests[index]["dropoff"]),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.calendar_today,
                                      color: Colors.orange),
                                  SizedBox(width: 5),
                                  Text(
                                    _requests[index]["date"],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Expanded(child: Container()),
                                  Icon(Icons.alarm, color: Colors.orange),
                                  SizedBox(width: 5),
                                  Text(
                                    _requests[index]["time"],
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
