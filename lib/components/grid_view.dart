import 'package:flutter/material.dart';
import 'package:halalify/components/grid_items_cloud.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'grid_items_cloud.dart';

import './grid_items_local.dart';

import '../models/get_image.dart';
import '../models/food.dart';

class GridViewWidget extends StatelessWidget {
  final foodList;

  const GridViewWidget({
    Key key,
    this.foodList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('food'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          else {
            final foodBox = Hive.box('food');
            // foodBox.add(Food('nissin.jpg', 'Nissin Noodles', 'Halal'));
            // foodBox.deleteAt(0);
            return Container(
              height: MediaQuery.of(context).size.height,
              child: foodBox.length != 0
                  ? GridView.builder(
                      itemCount: foodBox.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing:
                            MediaQuery.of(context).size.height * 0.03,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (_, index) {
                        final food = foodBox.getAt(index) as Food;
                        if (foodBox.isNotEmpty) {
                          print(food.imagePath);
                          return GridItemsLocal(
                            // imgPath: getImageURL(foodList[index]['img']),
                            // food: foodList[index]['food'],
                            // type: foodList[index]['type'],
                            // imgPath: getImageURL(food.imagePath),
                            imgPath: food.imagePath,
                            food: food.food,
                            type: food.type,
                          );
                        }
                      },
                    )
                  : Text("No previous data available"),
              // TODO: shift the text to center of page aka prettify this error handling
            );
          }
        } else
          return Scaffold(
            body: Container(),
          );
      },
    );
  }
}
