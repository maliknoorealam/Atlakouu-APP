import 'package:atalakou/models/expert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../authentication/auth_stream.dart';
import '../../screens/lookingforservices/Sub_categories/expert_details.dart';
import '../../utils/constants.dart';

class ExpertsResultTile extends StatelessWidget {
  const ExpertsResultTile({super.key, required this.expert, required this.index, required this.fromPage});

  final Expert expert;
  final int index;
  final int fromPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPage(screen: ResultDetails(expert: expert,fromPage: fromPage,))));
        },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border:
          Border.all(color: const Color(0xFF1D385C)), // navy border
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image(
                  image:AssetImage(index%2==0?
                  "assets/icons/looking_for_services/service_results/icon_result_male.png"
                      :"assets/icons/looking_for_services/service_results/icon_result_woman.png"),
                  height: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  "${expert.name} ${expert.surname}",
                  style: const TextStyle(
                      color: navyColor,
                      fontSize: 26,
                    ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF1D385C), // navy color
                  size: 33,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    expert.city,
                    style: GoogleFonts.oregano(
                      textStyle: const TextStyle(
                        color: Color(0xFF1D385C), // navy color
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              expert.job,
              style: const TextStyle(
                color: navyColor, // navy color
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    expert.expertise1,
                    style: GoogleFonts.oregano(
                      textStyle: const TextStyle(
                        color: Color(0xFF1D385C), // navy color
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    expert.expertise2,
                    style: GoogleFonts.oregano(
                      textStyle: const TextStyle(
                        color: Color(0xFF1D385C), // navy color
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
