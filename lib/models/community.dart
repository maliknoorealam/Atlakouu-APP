import 'package:atalakou/models/sub_districts.dart';


class Community {
  final int comId;
  final String comName;
  late String docId;
  final List<SubDistrict> subDistricts;

  Community({required this.comId, required this.comName,required this.docId,required this.subDistricts});

  Map<String, dynamic> toMap() {
    return {
      'com_id': comId,
      'com_name': comName,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map, String id, List<SubDistrict> subDistricts) {
    return Community(
        comId: map['com_id'] as int,
        comName: map['com_name'] as String,
        docId: id,
        subDistricts: subDistricts
    );
  }
}