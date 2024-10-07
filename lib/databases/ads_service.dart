import 'package:atalakou/models/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdsService extends GetxController {
  // observable list to hold publicity images
  RxList<String> imagesList = <String>[].obs;


  @override
  void onInit() {
    fetchImagesFromFireStore();
    super.onInit();
  }
  // Fetch images from Firebase Storage and update the observable list
  fetchImagesFromFireStore() async {
    try {
      // Get a reference to the 'ad-service' collection
      final collectionRef = FirebaseFirestore.instance.collection('ad-service');

      // Fetch all the documents from the collection
      final QuerySnapshot querySnapshot = await collectionRef.get();

      // Extract the ad URLs from the documents
      final List<Ads> ads = querySnapshot.docs.map((doc )=> Ads.fromMap(doc.data() as Map<String,dynamic>)).toList();

      //sort based on id
      ads.sort((a, b) => a.id.compareTo(b.id));

      //store in the observable list
      final List<String> imageUrls = ads.map((ad) => ad.imageUrl).toList();
      imagesList.assignAll(imageUrls);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
