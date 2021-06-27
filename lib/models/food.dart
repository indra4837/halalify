import 'package:hive/hive.dart';

part 'food.g.dart';

@HiveType(typeId: 1)
class Food {
  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  final String food;
  @HiveField(2)
  final String type;

  Food(this.imagePath, this.food, this.type);
}
