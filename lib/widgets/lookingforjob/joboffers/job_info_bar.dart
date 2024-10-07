import 'package:atalakou/authentication/auth_stream.dart';
import 'package:atalakou/screens/lookingforjob/job_detail_page.dart';
import 'package:flutter/material.dart';
import '../../../models/job.dart';
import '../../../utils/constants.dart';

class JobInfoBar extends StatelessWidget {
  const JobInfoBar(
      {super.key,
     required this.job});

  final Job job;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AuthPage(screen: JobDetailPage(job: job,))));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(15),
        width: size.width,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: goldColor, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.jobCategory,
              style: const TextStyle(fontSize: 20,color: navyColor),
            ),
            locationTextRow(job.city),
            infoTextRow(job.industry),
            infoTextRow(job.jobType),
            infoTextRow(job.creationDate),
          ],
        ),
      ),
    );
  }
}

locationTextRow(String location) {
  return Row(
    children: [
      const Icon(
        Icons.location_on_rounded,
        color: navyColor,
        size: 20,
      ),
      Text(
        location,
        style: const TextStyle(fontSize: 17,color: navyColor),
      )
    ],
  );
}

infoTextRow(String text) {
  return Row(
    children: [
      const SizedBox(
        width: 20,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 17,color: navyColor),
      )
    ],
  );
}
