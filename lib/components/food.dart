import 'package:flutter/material.dart';

class FoodComponent extends StatelessWidget {
  final String img;
  final String foodName;
  final String type;

  const FoodComponent({Key key, this.img, this.foodName, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [Image.asset(img)]);
  }
}
