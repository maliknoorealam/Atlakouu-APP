import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Job{
  final String city;
  final String creationDate;
  final String industry;
  final String jobCategory;
  final String jobType;
  final String offerDescription;
  final String jobId;

  Job({
    required this.city,
    required this.creationDate,
    required this.industry,
    required this.jobCategory,
    required this.jobType,
    required this.offerDescription,
    required this.jobId
  });

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'creation-date': creationDate,
      'industry': industry,
      'job-category': jobCategory,
      'job-type': jobType,
      'offer-description': offerDescription,
      // 'jobId': jobId
    };
  }

  factory Job.fromMap(Map<String, dynamic> map, String docId) {
    Timestamp creationTimestamp = map['creation-date'] as Timestamp;
    String creationDate = DateFormat('dd-MM-yy').format(creationTimestamp.toDate());
    return Job(
      city: map['city'] as String,
      creationDate: creationDate,
      industry: map['industry'] as String,
      jobCategory: map['job-category'] as String,
      offerDescription: map['offer-description'] as String,
      jobType: map['job-type'] as String,
      jobId: docId
    );

  }
}