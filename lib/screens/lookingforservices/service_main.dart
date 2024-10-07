import 'package:atalakou/databases/ads_service.dart';
import 'package:atalakou/databases/category_service.dart';
import 'package:atalakou/models/category.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:atalakou/widgets/common/news_widget.dart';
import 'package:atalakou/widgets/common/notifs.dart';
import 'package:atalakou/widgets/lookingforservices/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../databases/location_services.dart';
import '../../widgets/lookingforservices/locations_dropdown.dart';
import 'Sub_categories/sub_categories_page.dart';

class ServiceMain extends StatefulWidget {
  const ServiceMain({super.key});

  @override
  State<ServiceMain> createState() => _ServiceMainState();
}

class _ServiceMainState extends State<ServiceMain> {
  final CategoryService categoryService = Get.find();
  final LocationServices locationServices = Get.find();

  @override
  void initState() {
    // fetchCommunities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          mainAppBarTitle,
        ),
        leading: BackArrow(),
      ),
      body: RefreshIndicator(
        color: goldColor,
        onRefresh: () async {
          AdsService adService = Get.find();
          await categoryService.fetchCategories();
          await adService.fetchImagesFromFireStore();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        localization,
                        style: GoogleFonts.oregano(
                          textStyle: const TextStyle(
                              color: Color(0xFF1D385C), fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownWidget(
                    hint: search1,
                    selectedValue: locationServices.selectedCommunityName.value,
                    items: [none, ...locationServices.allCommunitiesNames],
                    onChanged: (String? newValue) async {
                      locationServices.fetched.value = false;
                      locationServices.selectedCommunityName.value = newValue;
                      locationServices.selectedSubDistrict.value = null;
                      locationServices.selectedSubDistrictName.value = null;

                      categoryService.searchedCommunity.value = newValue != none
                          ? locationServices.selectedCommunityName.value
                          : null;
                      categoryService.searchedDistrict.value =
                          locationServices.selectedSubDistrictName.value;

                      if (newValue != null && newValue != none) {
                        final communityDocId = locationServices.allCommunities
                            .firstWhere((c) => c.comName == newValue)
                            .docId;
                        await fetchSubDistricts(communityDocId);
                        locationServices.fetched.value = true;
                      } else {
                        locationServices.fetched.value = false;
                        locationServices.displayedSubDistricts.value = [];
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (locationServices.selectedCommunityName.value ==
                              null ||
                          locationServices.selectedCommunityName.value ==
                              none) {
                        showToast(searchForCommunityFirst);
                      }
                    },
                    child: DropdownWidget(
                      hint: search2,
                      selectedValue:
                          locationServices.selectedSubDistrictName.value,
                      items: locationServices.selectedCommunityName.value != null? [
                        none,
                        ...locationServices.displayedSubDistrictsNames
                      ]:[],
                      onChanged: locationServices.fetched.value
                          ? (String? newValue) {
                              locationServices.selectedSubDistrictName.value =
                                  newValue;
                              categoryService.searchedDistrict.value =
                                  newValue != none
                                      ? locationServices
                                          .selectedSubDistrictName.value
                                      : null;
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    adNews,
                    style: GoogleFonts.oregano(
                      textStyle: const TextStyle(
                          color: Color(0xFF1D385C), fontSize: 24),
                    ),
                  ),
                  const NewsTransitionTile(),
                  Container(
                      height: size.height * 0.65,
                      margin: const EdgeInsets.only(top: 20),
                      child: CategoryGrid(
                        selectedCommunity:
                            locationServices.selectedCommunityName.value,
                        selectedDistrict:
                            locationServices.selectedSubDistrictName.value,
                      ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  fetchSubDistricts(String communityDocId) async {
    locationServices.getSubDistricts(communityDocId);
  }
}
