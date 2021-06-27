import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/header.dart';

import '../models/food.dart';
import '../models/haram_list.dart';

class ResultScreen extends StatefulWidget {
  final Future<String> ocrResult;
  final String imgPath;

  ResultScreen({Key key, this.ocrResult, this.imgPath}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  String displayResult = "Getting results...";
  String finalResult;
  final foodController = TextEditingController();
  bool halal = true;
  List<dynamic> haramList;

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAsset(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: widget.ocrResult,
            builder: (context, result) {
              if (result.hasData) {
                Map resultMap = json.decode(result.data);
                finalResult = resultMap['text'];
                var resultList = finalResult.split(" ");
                resultList = resultList.where((x) => x != "").toList();
                final foodBox = Hive.box('food');

                // convert haramList ingredients to lowercase
                final haramList =
                    snapshot.data.map((e) => e.toLowerCase()).toList();

                // check if ocr results contains haram ingredients
                // haramList.data.forEach((e) {
                //   print(e);
                // });

                for (var i in resultList) {
                  if (haramList.contains(i.toLowerCase())) {
                    print(i);
                    halal = false;
                    break;
                  }
                }

                return Scaffold(
                  body: SafeArea(
                    minimum: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        HeaderLogo(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.height * 0.05,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                ),
                                itemCount: resultList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (resultList[index] != " ") {
                                    return Text(
                                      '- ' + resultList[index],
                                      style: GoogleFonts.alegreyaSans(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }
                                  return Text("No ingredients detected");
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: halal
                                  ? Text(
                                      'HALAL',
                                      style: GoogleFonts.alegreyaSans(
                                        textStyle: TextStyle(fontSize: 23),
                                        color: Colors.green[900],
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  : Text(
                                      'HARAM',
                                      style: GoogleFonts.alegreyaSans(
                                        textStyle: TextStyle(fontSize: 23),
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                              labelText: 'Food',
                              hintText: 'Enter food name',
                            ),
                            controller: foodController,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              child: Text(
                                'Save',
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue[900]),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // update Hive DB
                                foodBox.add(Food(
                                    widget.imgPath,
                                    foodController.text,
                                    halal ? 'Halal' : 'Haram'));
                                // popping twice to go back to home screen
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              child: Text(
                                'Back',
                                style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // popping twice to go back to capture screen
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SafeArea(
                child: Scaffold(
                  body: Text(displayResult),
                ),
              );
            },
          );
        } else {
          return SafeArea(
            child: Scaffold(),
          );
        }
      },
    );
  }
}
