

class Expert{
  final String docID;
  final String information;
  final String city;
  final String country;
  final String district;
  final List exampleOfImplementation;
  final String expertise1;
  final String expertise2;
  final String job;
  final String municipality;
  final String name;
  final String surname;
  final int categoryId;
  final int subCategoryId;
  final String contactNo;
  double cumulativeRatings;

  Expert({
    required this.information,
    required this.city,
    required this.country,
    required this.district,
    required this.exampleOfImplementation,
    required this.expertise1,
    required this.expertise2,
    required this.job,
    required this.municipality,
    required this.name,
    required this.surname,
    required this.categoryId,
    required this.subCategoryId,
    required this.contactNo,
    required this.docID,
    required this.cumulativeRatings
  });

  factory Expert.fromMap(Map<String, dynamic> map,String docID,) {
    double cumulativeRating;
    if(map['cumulativeRating'].runtimeType == int ){
      int rating = map['cumulativeRating'];
      cumulativeRating = rating.toDouble();
    }
    else{
      cumulativeRating = map['cumulativeRating'];
    }

    return Expert(
      categoryId: map['categoryId'] as int,
      subCategoryId: map['subCategoryId'] as int,
      information: map['activity-info'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      district: map['district'] as String,
      exampleOfImplementation: map['example-of-implementation'] as List,
      expertise1: map['expertise-1'] as String,
      expertise2: map['expertise-2'] as String,
      job: map['job'] as String,
      municipality: map['municipality'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      contactNo: map['contactNo'] as String,
      cumulativeRatings: cumulativeRating,
      docID: docID,
    );
  }
}