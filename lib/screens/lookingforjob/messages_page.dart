import 'dart:async';

import 'package:atalakou/databases/contact_service.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/common/back_arrow.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  ContactService contactService = Get.find();

  @override
  void initState() {
    Timer(const Duration(milliseconds: 500), () {
      contactService.launchWhatsApp();
      contactService.isLoading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        leading: BackArrow(),
      ),
      body: RefreshIndicator(
        color: goldColor,
        onRefresh: () async {
          await contactService.launchWhatsApp();
        },
        child: Center(
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(whatsAppRedirect),
                contactService.isLoading.value
                    ? CircularProgressIndicator(
                        color: goldColor,
                      )
                    : Container()
              ],
            );
          }),
        ),
      ),
    );
  }
}
