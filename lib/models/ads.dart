class Ads{
  final String imageUrl;
  final int id;

  Ads({required this.id, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'adURL': imageUrl,
      'id': id,
    };
  }

  factory Ads.fromMap(Map<String, dynamic> map) {
    return Ads(
      imageUrl: map['adURL'] as String,
      id: map['id'] as int,
    );
  }
}