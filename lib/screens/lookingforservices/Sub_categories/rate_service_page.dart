import 'package:atalakou/databases/experts_service.dart';
import 'package:atalakou/databases/rating_service.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/expert.dart';
import '../../../widgets/common/notifs.dart';

class RateServicePage extends StatefulWidget {
  const RateServicePage({super.key, required this.expert});

  final Expert expert;

  @override
  State<RateServicePage> createState() => _RateServicePageState();
}

class _RateServicePageState extends State<RateServicePage> {
  int _rating = 0;
  String ratingText = '';
  final FocusNode focusNode = FocusNode();
  final TextEditingController commentEditingController = TextEditingController();
  Color textFieldColor = navyColorWithOpacity;
  Color borderColor = navyColorWithOpacity;
  bool isLoading = false;
  bool hasRated = true;
  ExpertsService expertsService = Get.find();
  @override
  void initState() {
    super.initState();
    ratedStatus();
    focusNode.addListener(() {
      setState(() {
        textFieldColor =
            focusNode.hasFocus && !hasRated ? navyColor : navyColorWithOpacity;
            borderColor = (focusNode.hasFocus &&
                commentEditingController.text.isNotEmpty &&
                !hasRated)
            ? navyColor
            : navyColorWithOpacity;
      });
    });
    commentEditingController.addListener(() {
      setState(() {
        borderColor = (focusNode.hasFocus &&
                commentEditingController.text.isNotEmpty &&
                !hasRated)
            ? navyColor
            : navyColorWithOpacity;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    commentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          rateServiceScreenAppBarTitle,
        ),
        leading: BackArrow(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildExpertDetailTopBar(size),
            const SizedBox(height: 16),
            Container(
              height: 1,
              color: goldColor, // Gold line
              margin: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                rateServiceString,
                style: TextStyle(fontSize: 20, color: navyColor),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Text(
                    '1. Mauvais',
                    style: GoogleFonts.oregano(
                      textStyle:
                          const TextStyle(fontSize: 20, color: navyColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '5. Excellent',
                    style: GoogleFonts.oregano(
                      textStyle:
                          const TextStyle(fontSize: 20, color: navyColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) => buildStar(index)),
                  ),
                  _rating == 0
                      ? const SizedBox()
                      : Text(
                          ratingText,
                          style: TextStyle(fontSize: 18, color: goldColor),
                        )
                ],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (hasRated) {
                  showToast(alreadyRated);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: textFieldColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(comment,
                        style: TextStyle(fontSize: 24, color: whiteColor)),
                    TextField(
                      enabled: !hasRated,
                      controller: commentEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: whiteColor),
                      maxLines: 7,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (!hasRated) {
                    submitRatings();
                  } else {
                    showToast(alreadyRated);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: borderColor, width: 2)),
                  fixedSize: Size(size.width - 80, 80),
                  backgroundColor: whiteColor, // Navy color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: navyColor,
                        ),
                      )
                    : Text(submit,
                        style: TextStyle(fontSize: 20, color: borderColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ratedStatus() async {
    hasRated = await RatingService().hasUserRatedExpert(widget.expert.docID);

    setState(() {});
    if (hasRated) {
      debugPrint('User has already rated this expert.');
    } else {
      debugPrint('User has not rated this expert yet.');
    }
  }

  getRatingText(int rating) {
    switch (rating) {
      case 1:
        return oneStar;
      case 2:
        return twoStar;
      case 3:
        return threeStar;
      case 4:
        return fourStar;
      case 5:
        return fiveStar;
      default:
        return '';
    }
  }

  buildExpertDetailTopBar(Size size){
    return Container(
      height: size.height/6.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/vectors/common/icon_profile.svg",
            height: 75,
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.expert.name} ${widget.expert.surname}",
                  style: const TextStyle(fontSize: 24, color: navyColor),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.expert.job,
                  style: const TextStyle(fontSize: 20, color: navyColor),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    "${widget.expert.district}, ${widget.expert.municipality}, ${widget.expert.city}",
                    style: GoogleFonts.oregano(
                      textStyle:
                      const TextStyle(fontSize: 20, color: navyColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildStar(int index) {
    const simpleStar =
        "assets/vectors/looking_for_services/icon_rate_silver.svg";
    const goldenStar =
        "assets/vectors/looking_for_services/icon_rate_yellow.svg";
    const goldenFilledStar =
        "assets/vectors/looking_for_services/icon_rate_yellow_filled.svg";
    return IconButton(
      icon: SvgPicture.asset(
        _rating == 0
            ? simpleStar
            : index < _rating
                ? goldenFilledStar
                : goldenStar, // Gold color
        height: 40.0,
      ),
      onPressed: () {
        if (!hasRated) {
          setState(() {
            _rating = index + 1;
            ratingText = getRatingText(_rating);
          });
        } else {
          showToast(alreadyRated);
        }
      },
    );
  }

  submitRatings() async {
    if (_rating != 0 && commentEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth auth = FirebaseAuth.instance;
      Map<String,dynamic> functionReturn = await RatingService().addRatingAndReview(
          widget.expert.docID,
          auth.currentUser!.uid,
          _rating,
          commentEditingController.text);
      if (functionReturn['done']) {
        try{
          showToast(thankYouForFeedback);
          widget.expert.cumulativeRatings = functionReturn['rating'];
          expertsService.allExperts
              .firstWhere((a) => a.docID == widget.expert.docID)
              .cumulativeRatings = functionReturn['rating'];
          expertsService.displayedExperts
              .firstWhere((a) => a.docID == widget.expert.docID)
              .cumulativeRatings = functionReturn['rating']
          ;expertsService.availableExperts
              .firstWhere((a) => a.docID == widget.expert.docID)
              .cumulativeRatings = functionReturn['rating'];
        }
        catch(e){
          print(e);
        }
      }
      setState(() {
        isLoading = false;
        hasRated = true;
      });
      Navigator.pop(context);
    } else {
      showToast(submitRatingValidation);
      return;
    }
  }
}
