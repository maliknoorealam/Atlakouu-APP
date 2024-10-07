import 'package:atalakou/screens/lookingforjob/job_offer_page.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class JobOffersContainer extends StatelessWidget {
  const JobOffersContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const JobOffersPage()));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 1+0),
        height: size.height / 6,
        width: size.width,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: goldColor, width: 2)),
        child: const Center(
            child: Text(
          seeJobOffers,
          style: TextStyle(
              color: navyColor, fontWeight: FontWeight.w400, fontSize: 24),
        )),
      ),
    );
  }
}
