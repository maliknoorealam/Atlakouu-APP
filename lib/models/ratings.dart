import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Rating {
  final String userId;
  final int rating;
  final String review;
  final String createdAt;

  Rating({
    required this.userId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  // Convert Rating object to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'reviewText': review,
      'timestamp': createdAt,
    };
  }

  // Convert Map to Rating object
  factory Rating.fromMap(Map<String, dynamic> map) {
    Timestamp creationTimestamp = map['timestamp'] as Timestamp;
    String creationDate = DateFormat('dd-MM-yy').format(creationTimestamp.toDate());
    return Rating(
      userId: map['userId'],
      rating: map['rating'],
      review: map['reviewText'],
      createdAt: creationDate,
    );
  }
}
