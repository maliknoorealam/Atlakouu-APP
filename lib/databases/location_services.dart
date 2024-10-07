import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/community.dart';
import '../models/sub_districts.dart';

class LocationServices extends GetxController{
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var allCommunities = <Community>[].obs;
  var displayedSubDistricts = <SubDistrict>[].obs;

  var allCommunitiesNames = <String>[].obs;
  var displayedSubDistrictsNames = <String>[].obs;

  var selectedCommunity = Rxn<Community>();
  var selectedSubDistrict = Rxn<SubDistrict>();
  var selectedSubDistrictName = Rxn<String>();
  var selectedCommunityName = Rxn<String>();

  var fetched = false.obs;

  @override
  void onInit() {
    getCommunities();
    super.onInit();
  }

  getCommunities() async {
    fetched.value = false;
    selectedCommunity.value = null;
    QuerySnapshot querySnapshot =
    await fireStore.collection('search-by-community').get();

    List<Community> communities = [];

    for (var doc in querySnapshot.docs) {
      QuerySnapshot subDistrictSnapshot =
      await doc.reference.collection('sub-districts').get();

      List<SubDistrict> subDistricts = subDistrictSnapshot.docs
          .map((subDoc) =>
          SubDistrict.fromJson(subDoc.data() as Map<String, dynamic>))
          .toList();
      Community community = Community.fromMap(
          doc.data() as Map<String, dynamic>, doc.id, subDistricts);

      communities.add(community);
    }

    allCommunities.value = communities;
    allCommunitiesNames.value =
        communities.map((c) => c.comName).toList();


    fetched.value = true;
  }

  // Function to fetch sub-districts for a specific community
  Future<List<SubDistrict>> getSubDistricts(String communityDocId) async {
    Community community =
    allCommunities.firstWhere((c) => c.docId == communityDocId);

    displayedSubDistricts.value = community.subDistricts;
    displayedSubDistrictsNames.value = community.subDistricts.map((s) => s.subDistrictName).toList();
    return community.subDistricts;
  }
}