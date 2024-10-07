import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/notifs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobApplicationsService {

  User? currentUser = FirebaseAuth.instance.currentUser;

  submitJobApplication(String jobId) async {
    try {
      if (currentUser != null) {
        Map<String, dynamic> applicationData = {
          'jobId': jobId,
          'userID': currentUser!.uid,
          'userEmail': currentUser!.email,
          'submissionDate': FieldValue.serverTimestamp() //Current timestamp
        };

        // Update Data
        await FirebaseFirestore.instance
            .collection('job-applications')
            .add(applicationData);
        return true;
      } else {
        // if no user is signed in
        showToast('No user is currently logged in');
        return false;
      }
    }
    catch(e){
      showToast(errorOccurred);
      debugPrint("APPLICATION ERROR --------------------${e.toString()}");
      return false;
    }
  }

  hasUserAlreadyApplied(String jobId) async {
    try{
      if (currentUser != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('job-applications')
            .where('jobId', isEqualTo: jobId)
            .where('userID', isEqualTo: currentUser!.uid)
            .get();

        // If the query returns any documents, it means the user has already applied
        if (querySnapshot.docs.isNotEmpty) {
          return true;
        }

        return false;
      }
    }
    catch(e){
      return false;
    }
  }
}