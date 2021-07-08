import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img/back.jpg'), fit: BoxFit.fitHeight)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Card(
                color: Color(0xFF184e77),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Dev🤟Info",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFd9ed92)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // Shadow
              elevation: 3,
              color: Color(0xffffc300),
              child: Container(
                // Full Width
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Developer Name:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "S M Abiduzzaman",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Matric ID:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "1623715",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Project Name:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "Real-Time \nOutdoor Air\nQuality Monitoring \nSystem",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "App Name:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "I-Air quality \nMonitor",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "App Platform:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "Flutter",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Language:",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Text(
                              "Dart",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
