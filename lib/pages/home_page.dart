import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/header.dart';

import '../pages/capture_page.dart';

class HomePage extends StatefulWidget {
  final CameraDescription camera;

  HomePage({Key key, this.camera}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var foodList = [
    {
      'img': 'assets/images/chips.jpeg',
      'food': 'Lays Potato Chips',
      'type': 'Halal'
    },
    {
      'img': 'assets/images/samyang.jpg',
      'food': 'Samyang Noodles',
      'type': 'Non Halal'
    },
    {
      'img': 'assets/images/nissin.png',
      'food': 'Nissin Noodles',
      'type': 'Halal'
    },
    {
      'img': 'assets/images/timtam.png',
      'food': 'Tim Tam',
      'type': 'Halal',
    },
    {
      'img': 'assets/images/chips.jpeg',
      'food': 'Chipsmore',
      'type': 'Halal',
    },
    {
      'img': 'assets/images/lexus.jpg',
      'food': 'Lexus Biscuit',
      'type': 'Halal'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CaptureScreen(
                  camera: widget.camera,
                ),
              ));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 50.0, 0, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            HeaderLogo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                itemCount: foodList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
                    crossAxisSpacing: 10),
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.19,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          foodList[index]['img'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        foodList[index]['food'],
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                          color: Colors.black54,
                        )),
                      ),
                      Text(
                        foodList[index]['type'],
                        style: GoogleFonts.alegreyaSans(
                          textStyle: TextStyle(
                            color: foodList[index]['type'] == 'Non Halal'
                                ? Colors.red[900]
                                : Colors.green[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
