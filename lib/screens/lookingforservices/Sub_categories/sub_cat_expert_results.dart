import 'package:atalakou/databases/experts_service.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/lookingforservices/experts_result_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/expert.dart';
import '../../../widgets/common/back_arrow.dart';

class SubCatExpertsResult extends StatefulWidget {
  const SubCatExpertsResult({super.key, required this.categoryId, required this.subCategoryId});

  final int categoryId;
  final int subCategoryId;
  @override
  State<SubCatExpertsResult> createState() => _SubCatExpertsResultState();
}

class _SubCatExpertsResultState extends State<SubCatExpertsResult> {
  
  ExpertsService expertsService = Get.find();

  @override
  void initState() {
    getExperts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          resultsScreenAppBarTitle,
        ),
        leading: BackArrow(),
      ),
      body: expertsService.isLoading.value?
      const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: navyColor,),
            Text(isLoading)
          ],
        ),
      )
      :expertsService.displayedExperts.isNotEmpty?ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: expertsService.displayedExperts.length, // Number of containers you want
        itemBuilder: (BuildContext context, int index) {
          Expert expert = expertsService.displayedExperts[index];
          return ExpertsResultTile(expert: expert, index: index,fromPage: 0,);
        },
      ):const Center(child: Text(noExpertsFound),),
    );
  }

  getExperts() async {
    expertsService.filterExperts(widget.subCategoryId);
  }
}
