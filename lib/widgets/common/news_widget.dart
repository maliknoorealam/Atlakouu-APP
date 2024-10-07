import 'package:atalakou/databases/ads_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NewsTransitionTile extends StatefulWidget {
  const NewsTransitionTile({super.key});

  @override
  State<NewsTransitionTile> createState() => _NewsTransitionTileState();
}

class _NewsTransitionTileState extends State<NewsTransitionTile> {
  int _currentIndex = 0;
  late PageController _pageController;
  AdsService adsService = Get.find();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    startImageSlider();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 0),
      height: size.height / 4,
      width: size.width,
      child: adsService.imagesList.isEmpty
          ? Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      )
          : PageView.builder(
        controller: _pageController,
        itemCount: adsService.imagesList.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              adsService.imagesList[index],
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  startImageSlider() {
    Future.delayed(const Duration(seconds: 3), () {
      if (adsService.imagesList.isNotEmpty && adsService.imagesList.length != 1) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % adsService.imagesList.length;
            _pageController.animateToPage(
              _currentIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
        });
        startImageSlider();
      }
    });
  }
}


