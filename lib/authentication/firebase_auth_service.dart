import 'package:atalakou/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/common/notifs.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'userEmail': email,
        'creationTimestamp': FieldValue.serverTimestamp(),
        'endOfSubscription': null,
      });

      _auth.signOut();
      //For Email Verification in Future Updates
      // await _auth.currentUser?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(emailInUse);
      }
      else if (e.code == 'invalid-email') {
        showToast(emailInvalid);
      }
      else {
        showToast("$errorOccurred : ${e.code}");
      }
    }
    return false;
  }

  signInWithEmailAndPassword(String email, String password,) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint(credential.toString());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showToast(emailIncorrect);
      }
      else if (e.code == 'user-disabled') {
        showToast(userDisabled);
      }
      else if (e.code == 'user-not-found') {
        showToast(userNotFound);
      }
      else if (e.code == 'wrong-password') {
        showToast(wrongPassword);
      }
      else {
        showToast("$errorOccurred : ${e.code}");
      }
    }
    return false;
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showToast(resetLinkSent);
      return true;
    } on FirebaseAuthException catch (e) {
      showToast("$errorOccurred : ${e.code}");
    }
    return false;
  }

  signOut() async{
    try{
      await _auth.signOut();

      showToast(logoutSuccess);
    }
    on FirebaseAuthException catch (e){
      showToast("$errorOccurred : ${e.code}");
    }
  }

  deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      showToast(deleteSuccess);
    } on FirebaseAuthException catch (e) {
      showToast("$errorOccurred : ${e.code}");
    } catch (e) {
      showToast("$errorOccurred : ${e.toString()}");
      // Handle general exception
    }
  }

  Future<DateTime?> getSubscriptionExpiryDate() async {
    if (_auth.currentUser == null) {
      // If user is not logged in or the UID is not set
      return null;
    }
    DateTime defaultDate = DateTime(2025,DateTime.january,1);

    try {
      String currentUserID = _auth.currentUser!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUserID).get();

      if (userDoc.exists) {
        Timestamp? endOfSubscription = userDoc.get('endOfSubscription');

        if (endOfSubscription != null) {
          return endOfSubscription.toDate(); // Convert Timestamp to DateTime
        } else {

          return defaultDate; // Subscription date not set
        }
      } else {
        return defaultDate; // User document does not exist
      }
    } catch (e) {
      debugPrint("Error getting subscription expiry date: ${e.toString()}");
      return defaultDate; // Handle error and return null
    }
  }
}