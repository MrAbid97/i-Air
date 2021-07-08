import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:io_base/pages/about.dart';
import 'package:io_base/pages/air_quality.dart';
import 'package:io_base/pages/detail.dart';
import 'package:io_base/pages/homepage.dart';

void main() async {
  // https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-do/63873689
  WidgetsFlutterBinding.ensureInitialized();
  // Init Firebase
  await Firebase.initializeApp();
  // Main/Root Method to Start App
  return runApp(MaterialApp(
    //Theme data only Font
    theme: ThemeData(fontFamily: 'Roboto'),
    // First Component to Load
    home: App(),
  ));
}

// Statefull Class
class App extends StatefulWidget {
  // Constructor
  const App({
    Key key,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // IndexFor Pages to Display
  int currentIndex = 0;

  // Default Page
  Widget body = HomePage();

  // Splash Screen State
  bool initScreen = true;

  @override
  Widget build(BuildContext context) {
    // if Splash true return it other wise return Scaffold of HomePage
    return initScreen
        ? infoScreen()
        : Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/back.jpg'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomNavigationBar(
                  iconSize: 25.0,
                  selectedColor: Color(0xfff07167),
                  strokeColor: Color(0xFFA35555),
                  unSelectedColor: Color(0xff06d6a0),
                  backgroundColor: Color(0xff00151d),
                  borderRadius: Radius.circular(12),
                  // Define All Bottom Bar Color, Icon, Name
                  items: [
                    CustomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      title:
                          Text("Home", style: TextStyle(color: Colors.white)),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(Icons.history),
                      title: Text("History",
                          style: TextStyle(color: Colors.white)),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(Icons.supervised_user_circle_outlined),
                      title: Text("Air Quality",
                          style: TextStyle(color: Colors.white)),
                    ),
                    CustomNavigationBarItem(
                      icon: Icon(Icons.info_outline),
                      title:
                          Text("Info", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  currentIndex: currentIndex,
                  // Set which item to load on click event
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                      if (currentIndex == 0) {
                        body = HomePage();
                      } else if (currentIndex == 1) {
                        body = DetailPage();
                      } else if (currentIndex == 3) {
                        body = About();
                      } else if (currentIndex == 2) {
                        body = AirQuality();
                      }
                    });
                  },
                ),
              ),
            ),
            // Top/Head Bar
            appBar: AppBar(
              actions: [
                // Create a fixed box
                SizedBox(
                  width: 40,
                  // Button with Shadow
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      ),
                      onPressed: () {
                        setState(() {
                          initScreen = true;
                        });
                      },
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      )),
                )
              ],
              backgroundColor: Color(0xff00151d),
              elevation: 10,
              centerTitle: true,
              toolbarHeight: 50,
              // Head bar title
              title: Text(
                "i-Air quality Monitor",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xffedf2f4),
                  fontSize: 30,
                ),
              ),
            ),
            body: body,
          );
  }

  // Splash Screen Page
  Widget infoScreen() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/back.jpg'),
                fit: BoxFit.fitHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Elements
          children: [
            Text(
              "i-Air",
              style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color(0x86000000),
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            Image.asset('assets/img/logo.png'),
            // On Click Change State
            ElevatedButton(
              onPressed: () {
                setState(() {
                  initScreen = false;
                });
              },
              child: Text("Get Start"),
            )
          ],
        ),
      ),
    );
  }
}
