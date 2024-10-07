import 'package:atalakou/databases/category_service.dart';
import 'package:atalakou/models/expert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../widgets/common/notifs.dart';
import 'favorite_service.dart';

class ExpertsService extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final CategoryService categoryService = Get.find();

  // Observable lists for experts
  RxList<Expert> allExperts = <Expert>[].obs;
  RxList<Expert> availableExperts = <Expert>[].obs;
  RxList<Expert> displayedExperts = <Expert>[].obs;
  RxList<Expert> favExperts = <Expert>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAllExperts();
    super.onInit();
  }


  fetchAllExperts() async {
    try {
      QuerySnapshot querySnapshot = await _fireStore
          .collection('looking-for-expert').get();

      // Convert FireStore documents to a list of Expert objects
      List<Expert> experts = querySnapshot.docs
          .map((doc) => Expert.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      allExperts.assignAll(experts); // Store fetched experts in availableExperts
      debugPrint("Fetched $experts ");
    } catch (e) {
      showToast("$errorOccurred: ${e.toString()}");
    }
  }
  // Fetch all experts by category and store in availableExperts
  Future<void> fetchAllExpertsByCategory(int categoryId) async {
    try {

      List<Expert> experts = allExperts.where((e)=>e.categoryId == categoryId).toList();


      availableExperts.assignAll(experts); // Store fetched experts in availableExperts
      debugPrint("Fetched ${availableExperts.length} experts by category.");
    } catch (e) {
      showToast("$errorOccurred: ${e.toString()}");
    }
  }

  // Function to filter experts by subcategory, community, and district
  void filterExperts(int subCategoryId) {
    try {
      isLoading.value = true;
      List<Expert> filteredExperts = availableExperts.where((expert) {
        bool matchesSubCategory = expert.subCategoryId == subCategoryId;
        bool matchesCommunity = categoryService.searchedCommunity.value == null ||
            expert.municipality == categoryService.searchedCommunity.value;
        bool matchesDistrict = categoryService.searchedDistrict.value == null ||
            expert.district == categoryService.searchedDistrict.value;

        return matchesSubCategory && matchesCommunity && matchesDistrict;
      }).toList();

      displayedExperts.assignAll(filteredExperts); // Update displayedExperts with filtered experts
      debugPrint("Filtered experts: ${displayedExperts.length}");
      isLoading.value = false;
    } catch (e) {
      showToast("$errorOccurred: ${e.toString()}");
    }
  }

  // Fetch favorite experts by their document IDs and store in favExperts
  Future<void> fetchFavoriteExperts(String userId) async {
    List<String> expertDocIds = await FavoritesService().fetchFavorites(userId);
    try {
      if (expertDocIds.isEmpty) {
        return;
      }

      QuerySnapshot querySnapshot = await _fireStore
          .collection('looking-for-expert')
          .where(FieldPath.documentId, whereIn: expertDocIds)
          .get();

      List<Expert> experts = querySnapshot.docs
          .map((doc) => Expert.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      favExperts.assignAll(experts); // Store favorite experts in favExperts
      debugPrint("Fetched favorite experts: ${favExperts.length}");
    } catch (e) {
      showToast(
        "$errorOccurred: ${e.toString()}",
      );
    }
  }
}
