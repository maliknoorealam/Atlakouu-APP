import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class JobDescriptionSection extends StatelessWidget {
  const JobDescriptionSection({super.key, required this.jobDescription});

  final String jobDescription;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              jobDescriptionHeading,
              style: TextStyle(
                  fontSize: 20,
                  color: navyColor,
                  fontWeight: FontWeight.w400
              ),
            ),
            Text(jobDescription,
                maxLines: 20,
                style: const TextStyle(
                    fontSize: 17,
                    color: navyColor,
                    fontWeight: FontWeight.w400
                ))
          ],
        ),
      ),
    );
  }
}
