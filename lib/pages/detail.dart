import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int dropdownValue = 1;

  // Time Duration for 7 Days
  Duration backDays = Duration(days: 7);
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/back.jpg'), fit: BoxFit.fitHeight)),
      child: Column(
        children: [
          // Top Bar to Select Days
          Container(
            width: double.infinity,
            color: Color(0xFF000000),
            child: DropdownButtonHideUnderline(
              child: Padding(
                // Padding from all side
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                    dropdownColor: Color(0xFF000000),
                    elevation: 20,
                    value: dropdownValue,
                    items: [
                      DropdownMenuItem(
                        child: Text("Today"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Yesterday"),
                        value: 2,
                      ),
                      DropdownMenuItem(child: Text("7 Days"), value: 3),
                      DropdownMenuItem(child: Text("All"), value: 4)
                    ],
                    // Change state on Value Change
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                        if (dropdownValue == 1) {
                          backDays = Duration(hours: DateTime.now().hour);
                        } else if (dropdownValue == 2) {
                          backDays = Duration(hours: DateTime.now().hour + 24);
                        } else if (dropdownValue == 3) {
                          backDays = Duration(hours: DateTime.now().hour + 168);
                        } else if (dropdownValue == 4) {
                          backDays = Duration(hours: DateTime.now().hour + 800);
                        }
                      });
                    }),
              ),
            ),
          ),
          Expanded(
            // Expanded Widget cover all remain Space like flex
            // Stream Build for Continues Data And Re-build component if any things changes
            child: StreamBuilder(
                // Select the stream to watch
                stream:
                    FirebaseFirestore.instance.collection('data').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    children: snapshot.data.docs
                        .map((document) {
                          // Filter the Data Based on Input from Top Bar
                          var time = new DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.id.toString()) * 1000);
                          var today = new DateTime.now()
                              .subtract(backDays)
                              .millisecondsSinceEpoch;
                          if (time.millisecondsSinceEpoch > today) {
                            // Return detailItem for each value group
                            return detailItem(
                                document.get('long').toString(),
                                document.get('lat').toString(),
                                document.get('gas').toString(),
                                time);
                          }
                          return const SizedBox();
                        })
                        .toList()
                        .reversed
                        .toList(),
                    //   Reverse the list so we see the latest first
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget detailItem(String long, String lat, String gas, DateTime time) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Card(
      elevation: 5,
      // Border Radius
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        color: Color(0xFFFFD29C),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lat",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              lat,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Long",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              long,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Api",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  gas,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
            Container(
              width: double.infinity,
              color: Color(0xFF000000),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                //Convert TimeStamp to User Friendly String
                child: Text(
                  "${time.year.toString()}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
