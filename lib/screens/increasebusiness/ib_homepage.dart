import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:atalakou/widgets/common/contact_us_tile.dart';
import 'package:atalakou/widgets/common/news_widget.dart';
import 'package:flutter/material.dart';

class IBHomePage extends StatelessWidget {
  const IBHomePage({super.key});

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
      body: SingleChildScrollView(
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
            ],
          ),
        ),
      ),
    );
  }
}
