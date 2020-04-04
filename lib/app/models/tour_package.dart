import 'package:flutter/foundation.dart';

class TourPackage {
  TourPackage(
      {@required this.tourPackageId,
      @required this.tourName,
      @required this.durationPerHour,
      @required this.tourDescription,
      @required this.tourAdultAmount,
      @required this.tourChildAmount,
      @required this.tourInfantAmount,
      @required this.tourDiscount});

  final String tourPackageId;
  final String tourName;
  final String durationPerHour;
  final String tourDescription;
  final String tourAdultAmount;
  final int tourChildAmount;
  final int tourInfantAmount;
  final String tourDiscount;

  factory TourPackage.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String tourName = data['tourName'];
    final String durationPerHour = data['durationPerHour'];
    final String tourDescription = data['tourDescription'];
    final String tourAdultAmount = data['tourAdultAmount'];
    final int tourChildAmount = data['tourChildAmount'];
    final int tourInfantAmount = data['tourInfantAmount'];
    final String tourDiscount = data['tourDiscount'];
    return TourPackage(
      tourPackageId: documentId,
      tourName: tourName,
      durationPerHour: durationPerHour,
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
      'durationPerHour': durationPerHour,
      'tourDescription': tourDescription,
      'tourAdultAmount': tourAdultAmount,
      'tourChildAmount': tourChildAmount,
      'tourInfantAmount': tourInfantAmount,
      'tourDiscount': tourDiscount,
    };
  }
}
