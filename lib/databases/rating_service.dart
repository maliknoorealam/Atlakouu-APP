import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/notifs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RatingService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to add a rating and review for an expert
  addRatingAndReview(String expertId, String userId, int rating, String reviewText) async {
    num returnRating = rating;
    try {
      DocumentReference expertRef = _fireStore.collection('looking-for-expert').doc(expertId);

      // Create a new review document
      DocumentReference reviewRef = expertRef.collection('reviews').doc();
      await reviewRef.set({
        'userId': userId,
        'rating': rating,
        'reviewText': reviewText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update the expert's cumulative rating
      await _fireStore.runTransaction((transaction) async {
        DocumentSnapshot expertSnapshot = await transaction.get(expertRef);

        if (expertSnapshot.exists) {
          num currentCumulativeRating = expertSnapshot.get('cumulativeRating') ?? 0.0;
          num ratingCount = expertSnapshot.get('ratingCount') ?? 0;

          // Calculate the new cumulative rating
          num newCumulativeRating = ((currentCumulativeRating * ratingCount) + rating) / (ratingCount + 1);
          returnRating = newCumulativeRating;

          // Update the expert document with new rating and increment the rating count
          transaction.update(expertRef, {
            'cumulativeRating': newCumulativeRating,
            'ratingCount': ratingCount + 1,
          });
        } else {
          // If the expert document does not exist, create it
          transaction.set(expertRef, {
            'cumulativeRating': rating,
            'ratingCount': 1,
          });
        }
      });

      return {'done': true ,'rating': returnRating as double};
    } catch (e) {
      showToast(errorOccurred);
      debugPrint('Failed to add rating and review: ${e.toString()}');
      return {'done': false,'rating': returnRating};
    }
  }

  //to check if user has already rated the expert
  Future<bool> hasUserRatedExpert(String expertId) async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        return false;
      }

      QuerySnapshot querySnapshot = await _fireStore
          .collection('looking-for-expert')
          .doc(expertId)
          .collection('reviews')
          .where('userId', isEqualTo: userId)
          .limit(1) // Limit to 1 to check for existence
          .get();


      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Failed to check if user has rated expert: $e');
      return false;
    }
  }

}
