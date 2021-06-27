import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class GridItemsLocal extends StatelessWidget {
  final String imgPath;
  final String food;
  final String type;

  const GridItemsLocal({
    Key key,
    this.imgPath,
    this.food,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Image.file(
            File(imgPath),
            fit: BoxFit.fill,
          ),
        ),
        Text(
          food,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
            color: Colors.black54,
          )),
        ),
        Text(
          type,
          style: GoogleFonts.alegreyaSans(
            textStyle: TextStyle(
              color: type == 'Halal' ? Colors.green[900] : Colors.red[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
