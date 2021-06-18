import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridItems extends StatelessWidget {
  final Future<String> imgPath;
  final String food;
  final String type;

  const GridItems({
    Key key,
    this.imgPath,
    this.food,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: imgPath,
      builder: (context, img) {
        if (img.hasData)
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
                child: CachedNetworkImage(
                  imageUrl: img.data,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(
                    Icons.error,
                  ), //// YOU CAN CREATE YOUR OWN ERROR WIDGET HERE
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
                    color: type == 'Non Halal'
                        ? Colors.red[900]
                        : Colors.green[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        return Text("Loading data");
      },
    );
  }
}
