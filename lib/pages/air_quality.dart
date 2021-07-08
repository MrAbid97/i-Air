import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AirQuality extends StatefulWidget {
  @override
  _AirQualityState createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  // Form Firebase get The Gas value
  final fbAir = FirebaseDatabase.instance.reference().child("gas");

  @override
  Widget build(BuildContext context) {
    // Stream Builder to re-build the child on Value receive
    return StreamBuilder(
        stream: fbAir.onValue,
        builder: (context, snapshot) {
          // Check if Stream Has Data other wise return Empty Container
          if (snapshot != null && snapshot.hasData) {
            var text = "";
            var color = Color(0x000);
            var value = snapshot.data.snapshot.value.toDouble();
            value = value == null ? 0 : value;
            if (value < 51) {
              text = "GOOD";
              color = Color(0xFF00FFFF);
            } else if (value > 51 && value < 101) {
              text = "MODERATE";
              color = Color(0xFF00FF3F);
            } else if (value > 100 && value < 201) {
              text = "UNHEALTHY";
              color = Color(0xFFFFE600);
            } else if (value > 200 && value < 301) {
              text = "VERY UNHEALTHY";
              color = Color(0xFFFFD500);
            } else if (value > 300) {
              text = "HAZADOUS";
              color = Color(0xFFFF0000);
            }
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/back.jpg'),
                      fit: BoxFit.fitHeight)),
              child: Center(
                child: Card(
                  elevation: 10,
                  child: Container(
                    color: color,
                    width: 300,
                    height: 300,
                    child: Column(
                      // Justify or Align Items in center
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 50)),
                        Text(
                          value.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 80),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
