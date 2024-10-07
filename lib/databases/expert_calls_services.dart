import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> updateCallInfo(String docID) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    final String userId = auth.currentUser!.uid;
    final String userEmail = auth.currentUser!.email!;

    debugPrint("User ID: $userId, User Email: $userEmail, Document ID: $docID");

    DocumentReference expertDocRef =
    FirebaseFirestore.instance.collection('looking-for-expert').doc(docID);
    DocumentReference callInfoDocRef =
    expertDocRef.collection('calls-info').doc(userId);

    // Get the current timestamp
    Timestamp currentTimestamp = Timestamp.now();
    debugPrint("Current timestamp: $currentTimestamp");

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Read expert document
      DocumentSnapshot expertSnapshot = await transaction.get(expertDocRef);
      debugPrint("Expert Document Snapshot: ${expertSnapshot.exists ? expertSnapshot.data() : 'Document does not exist'}");

      // Read call info document
      DocumentSnapshot callInfoSnapshot = await transaction.get(callInfoDocRef);
      debugPrint("Call Info Document Snapshot: ${callInfoSnapshot.exists ? callInfoSnapshot.data() : 'Document does not exist'}");

      // Prepare data to update expert document
      Map<String, dynamic> expertData = expertSnapshot.exists
          ? expertSnapshot.data() as Map<String, dynamic>
          : {};
      int currentNumOfCalls = expertData['numOfCalls'] ?? 0;

      debugPrint("Current number of calls in expert doc: $currentNumOfCalls");

      transaction.set(expertDocRef, {
        'numOfCalls': currentNumOfCalls + 1,
        'latestCall': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      debugPrint("Expert document updated with new numOfCalls and latestCall");

      // Prepare data to update or create call info in the sub-collection
      Map<String, dynamic> callInfoData = callInfoSnapshot.exists
          ? callInfoSnapshot.data() as Map<String, dynamic>
          : {};
      int currentCallInfoNumOfCalls = callInfoData['numOfCalls'] ?? 0;

      List<dynamic> currentTimestamps = callInfoData['timestamps'] ?? [];
      debugPrint("Current timestamps before update: $currentTimestamps");

      // Add the current timestamp to the list
      currentTimestamps.add(currentTimestamp);

      debugPrint("Updated timestamps: $currentTimestamps");

      transaction.set(callInfoDocRef, {
        'userId': userId,
        'userEmail': userEmail,
        'numOfCalls': currentCallInfoNumOfCalls + 1,
        'timestamps': currentTimestamps,
        'lastCall': currentTimestamp,
      }, SetOptions(merge: true));

      debugPrint("Call info document updated with new numOfCalls, timestamps, and lastCall");
    });

    debugPrint('Document and call info successfully updated');
  } catch (e) {
    debugPrint('Failed to update document and call info: $e');
  }
}
