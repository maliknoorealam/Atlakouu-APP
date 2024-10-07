class SubDistrict{
  final int subDistrictId;
  final String subDistrictName;

  SubDistrict({required this.subDistrictId, required this.subDistrictName});

  // fromJson function
  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      subDistrictId: json['subDistrictID'],
      subDistrictName: json['subDistrictName'],
    );
  }

  // toJson function
  Map<String, dynamic> toJson() {
    return {
      'subDistrictID': subDistrictId,
      'subDistrictName': subDistrictName,
    };
  }
}