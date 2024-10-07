
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:atalakou/widgets/lookingforjob/common/bottom_navigation_separate_lfj.dart';
import 'package:atalakou/widgets/lookingforjob/jobdetail/apply_button.dart';
import 'package:atalakou/widgets/lookingforjob/jobdetail/job_description_section.dart';
import 'package:atalakou/widgets/lookingforjob/jobdetail/job_info_section.dart';
import 'package:flutter/material.dart';

import '../../models/job.dart';
import '../../utils/constants.dart';

class JobDetailPage extends StatelessWidget {
  const JobDetailPage({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(resultDetailScreenAppBarTitle),
        leading: BackArrow(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JobInfoSection(job: job),
            Divider(
              color: goldColor,
            ),
            JobDescriptionSection(jobDescription: job.offerDescription),
            ApplyButton(jobId: job.jobId,)
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationLFJ(context),
    );
  }
}

