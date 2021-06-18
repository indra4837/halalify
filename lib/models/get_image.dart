import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageURL(String imageName) async {
  String downloadURL =
      await FirebaseStorage.instance.ref(imageName).getDownloadURL();
  return downloadURL;
}
