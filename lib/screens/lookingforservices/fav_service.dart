import 'package:atalakou/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../databases/experts_service.dart';
import '../../models/expert.dart';
import '../../widgets/lookingforservices/experts_result_tile.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  // Use RxBool for reactive boolean variables
  var isLoading = true.obs;
  var isLoggedIn = false.obs;
  ExpertsService expertsService = Get.find();

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favorites),
      ),
      body: Obx(() {
        // Reactively use isLoading and isLoggedIn
        return isLoading.value
            ? const Center(child: CircularProgressIndicator(color: navyColor))
            : isLoggedIn.value
            ? expertsService.favExperts.isNotEmpty
            ? ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: expertsService.favExperts.length,
          itemBuilder: (BuildContext context, int index) {
            Expert expert = expertsService.favExperts[index];
            return ExpertsResultTile(
                expert: expert, index: index, fromPage: 1);
          },
        )
            : const Center(child: Text(noExpertsFound))
            : const Center(child: Text(signInToSeeFavorites));
      }),
    );
  }

  getExperts(String userId) async {
    await expertsService.fetchFavoriteExperts(userId);
    isLoading.value = false; // Update reactive variable
  }

  checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      isLoggedIn.value = true; // Update reactive variable
      await getExperts(user.uid);
    } else {
      isLoading.value = false; // Update reactive variable
      isLoggedIn.value = false; // Update reactive variable
    }
  }
}
