import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BookingRoom {
  BookingRoom({
    @required this.bookingRoomId,
    @required this.start,
    @required this.end,
    @required this.resortName,
    @required this.id,
    @required this.bedType,
    @required this.totalRoom,
    @required this.totalPriceRoom,
    @required this.roomType,
    @required this.totalExtraMattress,
    @required this.totalAmountRoom,
    @required this.totalPriceMattress,
    @required this.checkinTime,
    @required this.checkoutTime,
    @required this.bookingStatus,
    @required this.tourStatusDescription,
    @required this.accBank,
    @required this.accNo,

  });

  String bookingRoomId;

  DateTime start;
  DateTime end;

  String id;
  String resortName;
  String bedType;
  String roomType;
  int totalRoom;
  int totalExtraMattress;
  String checkinTime;
  String checkoutTime;
  double totalPriceRoom;
  double totalPriceMattress;
  double totalAmountRoom;
  String tourStatusDescription;
  String accBank;
  int accNo;
  String bookingStatus;
  double get durationInHours =>
      end.difference(start).inHours.round()/ 24;




  factory BookingRoom.fromMap(Map<dynamic, dynamic> value, String bookingRoomId) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];

    return BookingRoom(
      bookingRoomId: bookingRoomId,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      id: value['id'],
      resortName: value['resortName'],
      bedType: value['bedType'],
      totalRoom: value['totalRoom'],
      totalPriceRoom: value['totalPriceRoom'],
      roomType:value['roomType'],
      checkinTime:value['checkinTime'],
      checkoutTime:value['checkoutTime'],
      totalExtraMattress:value['totalExtraMattress'],
      totalPriceMattress:value['totalPriceMattress'],
      totalAmountRoom:value['totalAmountRoom'],
      bookingStatus:value['bookingStatus'],
      tourStatusDescription:value['tourStatusDescription'],
      accBank:value['accBank'],
      accNo:value['accNo'],

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,

      'durationInHours': durationInHours,
      'id': id,
      'resortName': resortName,
      'bedType': bedType,
      'totalRoom': totalRoom,
      'totalPriceRoom': totalPriceRoom,
      'roomType': roomType,
      'checkinTime': checkinTime,
      'totalExtraMattress': totalExtraMattress,
      'totalPriceMattress': totalPriceMattress,
      'checkoutTime': checkoutTime,
      'totalAmountRoom':totalAmountRoom,
      'bookingStatus': bookingStatus,
      'tourStatusDescription': tourStatusDescription,
      'accBank': accBank,
      'accNo': accNo,
    };
  }
}
