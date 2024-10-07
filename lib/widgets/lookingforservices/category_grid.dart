import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../databases/category_service.dart';
import '../../models/category.dart';
import '../../screens/lookingforservices/Sub_categories/sub_categories_page.dart';
import '../../utils/constants.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid(
      {super.key, this.selectedCommunity, this.selectedDistrict});
  final String? selectedCommunity;
  final String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    final CategoryService categoryService = Get.find();

    //displaying based on search
    if (selectedCommunity != null && selectedCommunity != none) {
      if (selectedDistrict != null && selectedDistrict != none) {
        //Only fetch categories which have experts available in this community
        categoryService.fetchCategoriesByCommunityAndDistrict(
            selectedCommunity!, selectedDistrict!);
      } else {
        //Only fetch categories which have experts available in this community and the selected district
        categoryService.fetchCategoriesByCommunity(selectedCommunity!);
      }
    }

    return Obx(() {
      if (categoryService.isLoading.value) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
                child: CircularProgressIndicator(
              color: navyColor,
            )),
          ],
        );
      } else {

          // List<Category> categories = (selectedCommunity == null ||
          //         selectedCommunity == none)
          //     ? categoryService.allCategories
          //     : categoryService.displayedCategories;

        List<Category> categories = categoryService.allCategories;
          return  categories.isEmpty?
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(child: Text(noCategoryAvailable)),
              ],
            ):
          GridView.builder(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return SquareProfileContainer(
                title: category.categoryName,
                icon: category.categoryIcon,
                onPressed: () {
                  navigateToSubCategoryPage(context, category);
                },
              );
            },
          );
        }
      }
    );
  }

  void navigateToSubCategoryPage(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubCategory(category: category),
      ),
    );
  }
}

class SquareProfileContainer extends StatelessWidget {
  final String title;
  final String? icon;
  final VoidCallback onPressed;

  const SquareProfileContainer({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: navyColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width / 8,
              height: size.width / 8,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: whiteColor, // White background for small square
                borderRadius: BorderRadius.circular(5), // Rounded corners
                image: DecorationImage(image: NetworkImage(icon!)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
