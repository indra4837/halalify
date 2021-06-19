import 'package:flutter/material.dart';

import '../components/grid_items.dart';

import '../models/get_image.dart';

class GridViewWidget extends StatelessWidget {
  final foodList;

  const GridViewWidget({
    Key key,
    this.foodList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // TODO: checkout other gridview widgets
      child: GridView.builder(
        itemCount: foodList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: MediaQuery.of(context).size.height * 0.03,
            crossAxisSpacing: 10),
        itemBuilder: (_, index) {
          return GridItems(
            imgPath: getImageURL(foodList[index]['img']),
            food: foodList[index]['food'],
            type: foodList[index]['type'],
          );
        },
      ),
    );
  }
}
