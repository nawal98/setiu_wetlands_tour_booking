
import 'package:flutter/foundation.dart';

class Feedbacks {
  Feedbacks({
    @required this.tourPackageId,
    @required this.tourName,
    @required this.feedbackId,
    @required this.feedbackDescription,
    @required this.userId,
  });
final String tourPackageId;
  final String tourName;
  final String feedbackId;
  final String feedbackDescription;
  final String userId;

  factory Feedbacks.fromMap(Map<dynamic, dynamic> value, String feedbackId) {

    return Feedbacks(
      feedbackId: feedbackId,
      tourPackageId: value['tourPackageId'],
      tourName: value['tourName'],
      feedbackDescription: value['feedbackDescription'],
      userId: value['userId'],

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'feedbackDescription': feedbackDescription,
      'tourName': tourName,
      'tourPackageId': tourPackageId,
      'userId': userId,

    };
  }
}
