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
  final int durationPerHour;
  final String tourDescription;
  final int tourAdultAmount;
  final int tourChildAmount;
  final int tourInfantAmount;
  final int tourDiscount;

  factory TourPackage.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String tourName = data['tourName'];
    final int durationPerHour = data['durationPerHour'];
    final String tourDescription = data['tourDescription'];
    final int tourAdultAmount = data['tourAdultAmount'];
    final int tourChildAmount = data['tourChildAmount'];
    final int tourInfantAmount = data['tourInfantAmount'];
    final int tourDiscount = data['tourDiscount'];
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
