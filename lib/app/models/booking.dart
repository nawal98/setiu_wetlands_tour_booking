import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Booking {
  Booking({
    @required this.bookingId,
    @required this.tourPackageId,
    @required this.start,
    @required this.end,
    @required this.paxAdult,
    @required this.paxChild,
    @required this.paxInfant,
    @required this.totalPriceAdult,
    @required this.totalPriceChild,
    @required this.totalPriceInfant,
    @required this.totalPrice,
    @required this.tourName,
    @required this.resortName,
    @required this.id,
    @required this.bedType,
    @required this.totalRoom,
    @required this.totalPriceRoom,
    @required this.roomType,
    @required this.totalExtraMattress,
    @required this.totalAmountRoom,
    @required this.totalPriceMattress,
    @required this.bookingStatus,
    @required this.tourStatusDescription,
    @required this.accBank,
    @required this.accNo,


  });
String tourName;
  String bookingId;
  String tourPackageId;
String bookingStatus;
  DateTime start;
  DateTime end;
  int paxAdult;
  int paxChild;
  int paxInfant;
  int get totalPax => paxAdult + paxChild;
  double totalPriceAdult;
  double totalPriceChild;
  double totalPriceInfant;
  double totalPrice;
  String id;
  String resortName;
  String bedType;
  String roomType;
  int totalRoom;
  int totalExtraMattress;
  double totalPriceRoom;
  double totalPriceMattress;
  double totalAmountRoom;
  String tourStatusDescription;
  String accBank;
  int accNo;

//final DocumentReference reference;
//double get pay;
//  double get durationInDays =>
//      end.difference(start).inDays.toDouble() / 24.0;
  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Booking.fromMap(Map<dynamic, dynamic> value, String bookingId) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    return Booking(
      bookingId: bookingId,
      tourPackageId: value['tourPackageId'],
      tourName: value['tourName'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      paxAdult: value['paxAdult'],
      paxChild: value['paxChild'],
      paxInfant: value['paxInfant'],
      totalPriceAdult: value['totalPriceAdult'],
      totalPriceChild: value['totalPriceChild'],
      totalPriceInfant: value['totalPriceInfant'],
      totalPrice: value['totalPrice'],
      id: value['id'],
      resortName: value['resortName'],
      bedType: value['bedType'],
      totalRoom: value['totalRoom'],
      totalPriceRoom: value['totalPriceRoom'],
      roomType:value['roomType'],
      bookingStatus:value['bookingStatus'],
      tourStatusDescription:value['tourStatusDescription'],
      accBank:value['accBank'],
      accNo:value['accNo'],

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tourPackageId': tourPackageId,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'paxAdult': paxAdult,
      'paxChild': paxChild,
      'paxInfant': paxInfant,
      'durationInHours': durationInHours,
      'totalPriceAdult': totalPriceAdult,
      'totalPriceChild': totalPriceChild,
      'totalPriceInfant': totalPriceInfant,
      'totalPrice': totalPrice,
      'tourName': tourName,
      'id': id,
      'resortName': resortName,
      'bedType': bedType,
      'totalRoom': totalRoom,
      'totalPriceRoom': totalPriceRoom,
      'roomType': roomType,
      'totalPax': totalPax,
      'bookingStatus': bookingStatus,
      'tourStatusDescription': tourStatusDescription,
      'accBank': accBank,
      'accNo': accNo,
    };
  }
}
