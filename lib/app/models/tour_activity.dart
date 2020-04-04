import 'package:flutter/foundation.dart';

class TourActivity {
  TourActivity(
      {@required this.tourActivityId,
        @required this.activityName,
        @required this.activityDescription,
     });

  final String tourActivityId;
  final String activityName;
  final String activityDescription;


  factory TourActivity.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String activityName = data['activityName'];
    final String activityDescription = data['activityDescription'];

    return TourActivity(
      tourActivityId: documentId,
      activityName: activityName,
      activityDescription: activityDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activityName': activityName,
      'activityDescription': activityDescription,

    };
  }
}