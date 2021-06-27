import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

List<dynamic> data = [];
Future<List<dynamic>> loadAsset() async {
  final myData = await rootBundle.loadString("assets/data/haram.csv");
  List<dynamic> csvTable = CsvToListConverter().convert(myData);

  // data cleaning to get List<String>
  data = csvTable.expand((element) => element).toList();
  data = data.where((element) => element != "").toList();

  // print(data);
  return data;
}
