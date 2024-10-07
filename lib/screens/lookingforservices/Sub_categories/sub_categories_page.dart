import 'package:atalakou/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../databases/experts_service.dart';
import '../../../widgets/common/back_arrow.dart';
import '../../../widgets/lookingforservices/bottom_navigation_separate_lfs.dart';
import 'sub_cat_expert_results.dart';

class SubCategory extends StatefulWidget {
  final Category category;


  const SubCategory({super.key, required this.category});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {

  @override
  void initState() {

    // fetching all the category experts
    getCategoryExperts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.categoryName,
        ),
        leading: BackArrow(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1, // Square aspect ratio
                ),
                itemCount: widget.category.subCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SubCatExpertsResult(
                                    categoryId: widget.category.categoryID,
                                    subCategoryId: widget.category
                                        .subCategories[index].subcategoryID,
                                  ))));
                    },
                    child: Container(
                      width: 100, // Adjust width as needed
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D385C), // Navy color
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          Text(
                            widget.category.subCategories[index].subCategoryName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationLFS(context,0),
    );
  }

  getCategoryExperts(){
    ExpertsService expertsService = Get.find();
    expertsService.fetchAllExpertsByCategory(widget.category.categoryID);
  }
}
