import 'package:atalakou/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX

import '../models/job.dart';
import '../widgets/common/notifs.dart';

class JobService extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Observable lists for jobs
  RxList<Job> availableJobs = <Job>[].obs;
  RxList<Job> displayedJobs = <Job>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllJobs(); // Automatically fetch all jobs on initialization
  }

  // Fetch all jobs and store in availableJobs
  Future<void> fetchAllJobs() async {
    try {
      Query query = _fireStore.collection('looking-for-job').where('Available', isEqualTo: true);

      QuerySnapshot querySnapshot = await query.get();

      List<Job> jobs = querySnapshot.docs
          .map((doc) => Job.fromMap(doc.data() as Map<String, dynamic>,doc.id))
          .toList();

      availableJobs.assignAll(jobs); // Store fetched jobs in availableJobs
      debugPrint("Fetched all jobs: ${availableJobs.length}");
    } catch (e) {
      debugPrint("Error fetching all jobs: $e");
      showToast("$errorOccurred: ${e.toString()}",);
    }
  }

  // Fetch filtered jobs based on domain and city, and store in displayedJobs
  Future<void> fetchWithQuery({String? jobDomain, String? city}) async {
    try {
      // Filter jobs from availableJobs based on jobDomain and city
      List<Job> filteredJobs = availableJobs.where((job) {
        bool matchesDomain = jobDomain == null || jobDomain.isEmpty || job.jobCategory.toLowerCase().startsWith(jobDomain.toLowerCase());
        bool matchesCity = city == null || city.isEmpty || job.city.toLowerCase().startsWith(city.toLowerCase());
        return matchesDomain && matchesCity;
      }).toList();

      displayedJobs.assignAll(filteredJobs); // Update displayedJobs with filtered jobs
      debugPrint("Displayed jobs: ${displayedJobs.length}");
    } catch (e) {
      debugPrint("Error fetching jobs with query: $e");
      showToast("$errorOccurred: ${e.toString()}",);
    }
  }
}
