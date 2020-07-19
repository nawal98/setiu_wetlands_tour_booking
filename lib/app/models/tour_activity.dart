import 'dart:io';

import 'package:flutter/foundation.dart';

class TourActivity {
  TourActivity(
      {@required this.tourActivityId,
        @required this.activityName,
        @required this.activityDescription,  this.url,
     });

  final String tourActivityId;
  final String activityName;
  final String activityDescription;
final String url;

  factory TourActivity.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String activityName = data['activityName'];
    final String activityDescription = data['activityDescription'];
    final String url=data['url'];

    return TourActivity(
      tourActivityId: documentId,
      activityName: activityName,
      activityDescription: activityDescription,
      url: url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activityName': activityName,
      'activityDescription': activityDescription,
      'url': url,

    };
  }
}