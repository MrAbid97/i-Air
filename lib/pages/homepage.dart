import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Select The Value from firebase which we needed on this page
  final fbAir = FirebaseDatabase.instance.reference().child("gas");
  final fbGps = FirebaseDatabase.instance.reference().child("gps");

  // Dummy Value
  double gasValue = 10.0;
  double gpsLat = 32.90;
  double gpsLong = 53.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/back.jpg'), fit: BoxFit.fitHeight),
      ),
      child: Column(
        children: [
          // Stream Builder to watch GPS value
          StreamBuilder(
              stream: fbGps.onValue,
              builder: (context, snapshot) {
                // if Data return GpsCard otherwise Container
                if (snapshot != null && snapshot.hasData) {
                  var temp = snapshot.data.snapshot.value;
                  print(temp);
                  return GpsCard(
                      lat: temp[0].toDouble(), long: temp[1].toDouble());
                } else {
                  return Container();
                }
              }),
          SizedBox(height: 20),
          // Stream builder to watch Gas Value
          StreamBuilder(
              stream: fbAir.onValue,
              builder: (context, snapshot) {
                // if Data return GasCard otherwise Container
                if (snapshot != null && snapshot.hasData) {
                  return GasCard(
                    gas: snapshot.data.snapshot.value.toDouble(),
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}

class GpsCard extends StatelessWidget {
  final double lat;
  final double long;

  // Constructor
  const GpsCard({this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Color(0xfff9c74f),
        elevation: 10,
        child: Container(
          height: size.height * 0.2,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.gps_fixed_sharp,
                  size: size.width * 0.15,
                  color: Color(0xff003150),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LATITUDE    ",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF014E90),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          lat.toStringAsFixed(6),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00265F),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 2,
                    width: 100,
                    color: Color(0xFF090000),
                  ),
                  Row(
                    children: [
                      Text(
                        "LONGITUDE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF014E90),
                        ),
                      ),
                      Padding(
                        // Padding from All side
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          long.toStringAsFixed(6),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00265F),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GasCard extends StatelessWidget {
  final double gas;

  // Constructor
  const GasCard({Key key, this.gas});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Color(0xffc4f1ff),
        elevation: 10,
        child: Container(
          height: size.height * 0.13,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.api,
                  size: size.width * 0.15,
                  color: Color(0xff003150),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "API",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF014E90),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          gas.toStringAsFixed(5),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00265F),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
