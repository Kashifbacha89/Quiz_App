import 'package:flutter_study_app/firebase_ref/refrences.dart';
import 'package:get/get.dart';




class FirebaseStorageServices extends GetxService {
  //load images from firebase storage
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child('question_paper_images')
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e) {
      return null;
    }
  }
}
