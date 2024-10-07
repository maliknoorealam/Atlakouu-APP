import 'package:atalakou/models/sub_categories.dart';

class Category{
  final String categoryName;
  final int categoryID;
  final String categoryIcon;
  final List<SubCategories> subCategories;

  Category({required this.categoryName, required this.categoryID, required this.categoryIcon, required this.subCategories});

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'categoryID': categoryID,
      'categoryIcon': categoryIcon,
      'subCategories': subCategories,
    };
  }

  //To make category objects from cloud store documents
  factory Category.fromMap(Map<String, dynamic> map,List<SubCategories> subCategories) {
    return Category(
      categoryName: map['categoryName'] as String,
      categoryID: map['id'] as int,
      categoryIcon: map['iconURL'] as String,
      subCategories: subCategories
    );
  }
}