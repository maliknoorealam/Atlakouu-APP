import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../databases/contact_service.dart';
import '../../utils/constants.dart';

class ContactUsTile extends StatelessWidget {
  const ContactUsTile({super.key});


  @override
  Widget build(BuildContext context) {
    ContactService contactService = Get.find();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
       contactService.launchWhatsApp();
       contactService.isLoading.value = false;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: size.height/6,
        width: size.width,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius:  BorderRadius.circular(20),
            border: Border.all(color: goldColor,width: 2)
        ),
        child: const Center(child: Text(contactUS,style: TextStyle(color: navyColor, fontWeight: FontWeight.w400, fontSize: 24),)),
      ),
    );
  }
}
