import 'package:flutter/material.dart';
import 'dart:convert';

class ResultScreen extends StatefulWidget {
  final Future<String> ocrResult;

  ResultScreen({Key key, this.ocrResult}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  String displayResult = "Getting results...";

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.ocrResult,
        builder: (context, result) {
          if (result.hasData) {
            Map resultMap = json.decode(result.data);
            return SafeArea(
              child: Scaffold(
                body: Text(resultMap['text']),
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
