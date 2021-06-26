import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import '../components/header.dart';

class ResultScreen extends StatefulWidget {
  final Future<String> ocrResult;

  ResultScreen({Key key, this.ocrResult}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  String displayResult = "Getting results...";
  String finalResult;

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.ocrResult,
        builder: (context, result) {
          if (result.hasData) {
            Map resultMap = json.decode(result.data);
            finalResult = resultMap['text'];
            var resultList = finalResult.split(" ");
            resultList = resultList.where((x) => x != "").toList();
            print(resultList);
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
                        height: MediaQuery.of(context).size.height * 0.5,
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
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
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
                          child: Text(
                            'HALAL',
                            style: GoogleFonts.alegreyaSans(
                              textStyle: TextStyle(fontSize: 23),
                              color: Colors.green[900],
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          child: Text(
                            'Back',
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
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
        });
  }
}
