import 'package:atalakou/databases/expert_calls_services.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/notifs.dart';
import 'package:atalakou/widgets/lookingforservices/bottom_navigation_separate_lfs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../databases/favorite_service.dart';
import '../../../models/expert.dart';
import 'rate_service_page.dart';

class ResultDetails extends StatefulWidget {
  const ResultDetails({super.key, required this.expert, required this.fromPage});

  @override
  State<ResultDetails> createState() => _ResultDetailsState();
  final Expert expert;
  final int fromPage;
}

class _ResultDetailsState extends State<ResultDetails> {

  FavoritesService favoritesService = FavoritesService();
  bool isFav = false;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Color favoriteTileColor = navyColor;
  bool buttonTapExecuted = true;

  @override
  void initState() {
    getFavStatus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(resultDetailScreenAppBarTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildExpertDetailTopBar(size),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     SvgPicture.asset("assets/vectors/common/icon_profile.svg",height: 75,),
            //     const SizedBox(width: 16),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "${widget.expert.name} ${widget.expert.surname}",
            //           style: const TextStyle(fontSize: 24, color: navyColor),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           widget.expert.job,
            //           style: const TextStyle(fontSize: 18, color: navyColor),
            //         ),
            //         const SizedBox(height: 4),
            //         Text(
            //           softWrap: true,
            //           overflow: TextOverflow.ellipsis,
            //           maxLines: 3,
            //           "${widget.expert.district}, ${widget.expert.municipality}, ${widget.expert.city}",
            //           style: const TextStyle(fontSize: 18, color: navyColor),
            //         ),
            //         const SizedBox(height: 4),
            //         Text(
            //           "Note: ${widget.expert.cumulativeRatings}",
            //           style: const TextStyle(fontSize: 18, color: navyColor),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Container(
              height: 1,
              color: goldColor, // Gold line
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            Text(
              activityInfoHeading,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(fontSize: 20, color: navyColor),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.expert.information,
              style: const TextStyle(fontSize: 16, color: navyColor)
            ),
            const SizedBox(height: 8),
            Text(
              examplesHeading,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(fontSize: 20, color: navyColor),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: size.height/5,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.expert.exampleOfImplementation.length,
                itemBuilder: (context,index)
                {
                  return _buildAchievementImage(widget.expert.exampleOfImplementation[index].toString(),size);
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoContainer(size,addToFavTitle, "icon_favorite.png",
                    ()=>onFavTap(context),primaryColor: favoriteTileColor),
            const SizedBox(height: 8),
            _buildInfoContainer(size,connectTitle, "icon_connecting.png", () {
              showBottomSheet(context);
            }),
            const SizedBox(height: 8),
            _buildInfoContainer(size,rateServiceTitle, "icon_rate.png", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RateServicePage(expert: widget.expert)),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationLFS(context, widget.fromPage),
    );
  }

  getFavStatus () async {
    isFav = await favoritesService.isFavorite(userId, widget.expert.docID);
    setState(() {
      favoriteTileColor = isFav? navyColorWithOpacity : navyColor;
    });
  }
  
  onFavTap( BuildContext context) async {
    if(buttonTapExecuted) {
      if (isFav) {
        buttonTapExecuted = false;
        await favoritesService.removeFavorite(userId, widget.expert.docID);
        showToast(removedFromFavorites);
        setState(() {
          isFav = false;
          favoriteTileColor = navyColor;
        });
        buttonTapExecuted = true;
      } else {
        buttonTapExecuted = false;
        await favoritesService.addFavorite(userId, widget.expert.docID);
        showToast(addedToFavorites);
        setState(() {
          isFav = true;
          favoriteTileColor = navyColorWithOpacity;
        });
        buttonTapExecuted= true;
      }
    }
    else{
      return;
    }
  }

  showBottomSheet(BuildContext context){
    return showModalBottomSheet(
      context: context,
      backgroundColor: whiteColor,

      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 200,
          decoration: BoxDecoration(
              color: goldColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
          ),
          child: Column(
            children: [
              const Text(
                callBottomSheetDescription,
                textAlign: TextAlign.center,
                style:TextStyle(
                    fontSize: 28, color: whiteColor),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPopupOption(
                      text: cancelCall,
                      icon: "assets/vectors/looking_for_services/icon_cancel_call.svg",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      isSvg: true
                  ),
                  _buildPopupOption(
                      text: proceedWithCall,
                      icon: "assets/icons/looking_for_services/call/icon_call.png",
                      onTap: () async {
                        launchUrl(Uri.parse("tel:${widget.expert.contactNo}"));
                        updateCallInfo(widget.expert.docID);
                      },
                      isSvg: false
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  buildExpertDetailTopBar(Size size){
    String location = "${widget.expert.district}, ${widget.expert.municipality}, ${widget.expert.city}";
    return Container(
      height: size.height/5.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/vectors/common/icon_profile.svg",height: 75,),
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
                  style: const TextStyle(fontSize: 18, color: navyColor),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    location,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 18, color: navyColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Note: ${widget.expert.cumulativeRatings}",
                  style: const TextStyle(fontSize: 18, color: navyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAchievementImage(String imagePath,Size size) {
    return Container(
      height: size.height/5,
      width: size.height/5,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(image: NetworkImage(imagePath),fit: BoxFit.cover)
      ),
    );
  }

  _buildInfoContainer(Size size, String text, String icon, VoidCallback onTap,
      {Color primaryColor = navyColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: primaryColor), // Navy border
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width/6,
              margin: const EdgeInsets.only(right: 8),
              child: Opacity(
                opacity: primaryColor == navyColor?1.0:0.4,
                child: Image(
                  image: AssetImage("assets/icons/looking_for_services/service_detail/$icon"),
                  //as the icon provided for contact is small, we'll adjust the size accordingly.
                  height: icon == "icon_connecting.png"?60:55,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Text(
              text,
              style: GoogleFonts.oregano(
                textStyle: TextStyle(
                  fontSize: 25,
                  color: primaryColor, // Navy color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _buildPopupOption({
    required String text,
    required String icon,
    required  onTap,
    required bool isSvg
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1D385C), // Navy color
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: GoogleFonts.oregano(
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white, // White text color
                ),
              ),
            ),
            const SizedBox(width: 8),
            isSvg?
            SvgPicture.asset(icon,height: 24,)
                :Image(image: AssetImage(icon),height: 24,)
          ],
        ),
      ),
    );
  }
}
