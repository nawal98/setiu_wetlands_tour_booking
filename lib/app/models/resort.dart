import 'package:flutter/foundation.dart';

class Resort{
  Resort(
      {@required this.resortId,
        @required this.resortName,
        @required this.resortDescription,
        @required this.resortAddress,
        @required this.resortTel,
        @required this.resortType,

        });

  final String resortId;
  final String resortName;
  final String resortDescription;
  final String resortAddress;
  final String resortTel;
  final String resortType;



  factory Resort.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String resortName = data['resortName'];
    final String resortDescription = data['resortDescription'];
    final String resortAddress = data['resortAddress'];
    final String resortTel = data['resortTel'];
    final String resortType = data['resortType'];


    return Resort(
      resortId: documentId,
      resortName: resortName,
      resortDescription: resortDescription,
      resortAddress: resortAddress,
      resortTel: resortTel,
      resortType: resortType,


    );
  }

  Map<String, dynamic> toMap() {
    return {
      'resortName': resortName,
      'resortDescription': resortDescription,
      'resortAddress': resortAddress,
      'resortTel': resortTel,
      'resortType': resortType,


    };
  }
}