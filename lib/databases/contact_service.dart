import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';
import '../widgets/common/notifs.dart';

class ContactService extends GetxController{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var contactNum =  Rxn<String>();
  var isLoading = true.obs;

  @override
  void onInit() {
    getContactNum();
    // listenToContactNumChanges();
    super.onInit();
  }

  getContactNum() async {
    try{

      QuerySnapshot snapShot = await _fireStore.collection("Contact").get();

      Map<String, dynamic> contactsData =
          snapShot.docs.first.data() as Map<String, dynamic>;

      contactNum.value = contactsData['Contact-num'] as String;

    }
    catch(e){

      showToast("$errorOccurred $e");
      debugPrint(e.toString());
    }
  }

  launchWhatsApp() async {
    isLoading.value = true;
    if (contactNum.value != null) {
      final url = 'https://wa.me/${contactNum.value}';
      launchUrl(Uri.parse(url));
    } else {

      showToast(whatsAppError);
      getContactNum(); // Retry fetching the contact number
    }
  }


}