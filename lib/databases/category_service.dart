import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:atalakou/models/category.dart';
import 'package:get/get.dart';

import '../models/sub_categories.dart';



class CategoryService extends GetxController{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //to show a circular progress indicator
  var isLoading = false.obs;

  //holding all the categories fetched from firebase
  var allCategories = <Category>[].obs;
  //holding the categories filtered according to the query
  var displayedCategories = <Category>[].obs;

  //holds the searched Community
  Rx<String?> searchedCommunity = Rx<String?>(null);
  //holds the searched district
  Rx<String?> searchedDistrict = Rx<String?>(null);

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // to fetch all categories
  fetchCategories() async {
    isLoading.value = true;
    QuerySnapshot querySnapshot = await _fireStore.collection('Categories').get();

    List<Category> categories = [];

    for (var doc in querySnapshot.docs) {
      DocumentSnapshot categoryDoc = doc;
      QuerySnapshot subCategoriesSnapshot = await categoryDoc.reference.collection('sub-categories').get();

      List<SubCategories> subCategories = subCategoriesSnapshot.docs.map((doc) => SubCategories.fromMap(doc.data() as Map<String, dynamic>)).toList();

      subCategories.sort((a, b) => a.subcategoryID.compareTo(b.subcategoryID));
      Category category = Category.fromMap(doc.data() as Map<String, dynamic>, subCategories);


      categories.add(category);
    }

    allCategories.value = categories;
    allCategories.sort((a, b) => a.categoryID.compareTo(b.categoryID));
    isLoading.value = false;
  }

  // to fetch categories and subcategories with experts available in the selected community
  fetchCategoriesByCommunity(String community) async {
    isLoading.value = true;
    List<Category> filteredCategories = [];

    // // Fetch all categories
    // List<Category> allCategories = await fetchCategories();

    for (var category in allCategories) {
      List<SubCategories> filteredSubCategories = [];

      // Check each subcategory if it has experts available in the selected community
      for (var subCategory in category.subCategories) {
        // List<Expert> experts = await ExpertsService().fetchExpertsByCommunity(
        //   category.categoryID,
        //   subCategory.subcategoryID,
        //   community,
        // );

        if (subCategory.expertCommunities.contains(community)) {
          filteredSubCategories.add(subCategory);
        }
      }

      // If the category has at least one subcategory with available experts, add it to the filtered list
      if (filteredSubCategories.isNotEmpty) {
        filteredCategories.add(Category(
          categoryName: category.categoryName,
          categoryID: category.categoryID,
          categoryIcon: category.categoryIcon,
          subCategories: filteredSubCategories,
        ));
      }
    }
    displayedCategories.value = filteredCategories;

    isLoading.value = false;
  }

  // to fetch categories and subcategories with experts available in the selected community and district
  fetchCategoriesByCommunityAndDistrict(String community, String district) async {
    isLoading.value = true;
    List<Category> filteredCategories = [];


    for (var category in allCategories) {
      List<SubCategories> filteredSubCategories = [];

      // Check each subcategory if it has experts available in the selected community and district
      for (var subCategory in category.subCategories) {


        if (subCategory.expertCommunities.contains(community) && subCategory.expertDistricts.contains(district)) {
          filteredSubCategories.add(subCategory);
        }
      }

      // If the category has at least one subcategory with available experts, add it to the filtered list
      if (filteredSubCategories.isNotEmpty) {
        filteredCategories.add(Category(
          categoryName: category.categoryName,
          categoryID: category.categoryID,
          categoryIcon: category.categoryIcon,
          subCategories: filteredSubCategories,
        ));
      }

    }

    displayedCategories.value = filteredCategories;

    isLoading.value = false;
  }
}