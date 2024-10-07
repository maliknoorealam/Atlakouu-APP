import 'package:atalakou/models/job.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class JobInfoSection extends StatelessWidget {
  const JobInfoSection({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            job.jobCategory,
            style: const TextStyle(
                fontSize: 24,
                color: navyColor,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                locationTextRow(job.city),
                infoTextRow(job.industry),
                infoTextRow(job.jobType),
                infoTextRow(job.creationDate)
              ],
            )
          ],
        ),
      ],
    );
  }
}

locationTextRow(String location) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: const Icon(
          Icons.location_on_rounded,
          color: navyColor,
          size: 20,
        ),
      ),
      Text(
        location,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 17,color: navyColor),
      )
    ],
  );
}

infoTextRow(String text) {
  return Row(
    children: [
      const SizedBox(
        width: 30,
      ),
      Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 17,color: navyColor,fontWeight: FontWeight.w400),
      )
    ],
  );
}
