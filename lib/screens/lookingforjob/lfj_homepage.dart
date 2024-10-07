import 'package:atalakou/databases/ads_service.dart';
import 'package:atalakou/databases/contact_service.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/contact_us_tile.dart';
import 'package:atalakou/widgets/common/news_widget.dart';
import 'package:atalakou/widgets/lookingforjob/home/job_offers_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/common/back_arrow.dart';

class LFJHomePage extends StatefulWidget {
  const LFJHomePage({super.key});

  @override
  State<LFJHomePage> createState() => _LFJHomePageState();
}

class _LFJHomePageState extends State<LFJHomePage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: BackArrow(),
        title: const Text(
          mainAppBarTitle,
          ),
      ),
      body: RefreshIndicator(
        color: goldColor,
        onRefresh: () async {
          Get.find<ContactService>().getContactNum();
          Get.find<AdsService>().fetchImagesFromFireStore();
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adNews,
                  style: TextStyle(
                      color: navyColor, fontWeight: FontWeight.w400, fontSize: 24),
                ),
                NewsTransitionTile(),
                SizedBox(height: 40),
                ContactUsTile(),
                JobOffersContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }

}
