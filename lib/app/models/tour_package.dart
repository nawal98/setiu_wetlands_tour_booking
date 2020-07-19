import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TourPackage {
  TourPackage(
      {@required this.tourPackageId,
      @required this.tourName,
      @required this.tourDescription,
      @required this.tourAdultAmount,
      @required this.tourChildAmount,
      @required this.tourInfantAmount,
      @required this.tourDiscount,
//      this.reference},
      });

  final String tourPackageId;
  final String tourName;
   String tourDescription;
   int tourAdultAmount;
   int tourChildAmount;
   int tourInfantAmount;
   int tourDiscount;

  factory TourPackage.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String tourName = data['tourName'];
    final String tourDescription = data['tourDescription'];
    final int tourAdultAmount = data['tourAdultAmount'];
    final int tourChildAmount = data['tourChildAmount'];
    final int tourInfantAmount = data['tourInfantAmount'];
    final int tourDiscount = data['tourDiscount'];
    return TourPackage(
      tourPackageId: documentId,
      tourName: tourName,
      tourDescription: tourDescription,
      tourAdultAmount: tourAdultAmount,
      tourChildAmount: tourChildAmount,
      tourInfantAmount: tourInfantAmount,
      tourDiscount: tourDiscount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tourName': tourName,
      'tourDescription': tourDescription,
      'tourAdultAmount': tourAdultAmount,
      'tourChildAmount': tourChildAmount,
      'tourInfantAmount': tourInfantAmount,
      'tourDiscount': tourDiscount,
    };
  }
}
