import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:halalify/components/grid_view.dart';

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
      'img': 'assets/images/lays.jpg',
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
        tooltip: 'Check another',
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
            GridViewWidget(
              foodList: foodList,
            ),
          ]),
        ),
      ),
    );
  }
}
