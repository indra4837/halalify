import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageURL(String imageName) async {
  // FirebaseStorage storage =
  //     FirebaseStorage.instanceFor(bucket: 'gs://halalify-24bc1.appshot.com');
  String downloadURL =
      await FirebaseStorage.instance.ref(imageName).getDownloadURL();
  return downloadURL;
}
