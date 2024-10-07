class SubCategories {
  final String subCategoryName;
  final int subcategoryID;
  final List expertCommunities;
  final List expertDistricts;

  SubCategories({required this.subCategoryName, required this.subcategoryID, required this.expertCommunities, required this.expertDistricts, });

  Map<String, dynamic> toMap() {
    return {
      'subCategoryName': subCategoryName,
      'subcategoryID': subcategoryID,
    };
  }

  factory SubCategories.fromMap(Map<String, dynamic> map) {


    return SubCategories(
      subCategoryName: map['categoryName'] as String,
      subcategoryID: map['id'] as int,
      expertCommunities: map['expert-communities'] as List,
      expertDistricts: map['expert-subdistricts'] as List
    );
  }
}