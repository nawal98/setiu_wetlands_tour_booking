import 'package:flutter/foundation.dart';

class Room {
  Room({
    @required this.id,
    @required this.resortId,
    @required this.roomNo,
    @required this.bedType,
    @required this.roomPrice,
    @required this.roomStatus,
  });

  String id;
  String resortId;
  String roomNo;
  String bedType;
  String roomPrice;
  String roomStatus;



  factory Room.fromMap(Map<dynamic, dynamic> value, String id) {

    return Room(
      id: id,
      resortId: value['resortId'],
      roomNo: value['roomNo'],
      bedType: value['bedType'],
      roomPrice: value['roomPrice'],
      roomStatus: value['roomStatus'],

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resortId': resortId,
      'roomNo': roomNo,
      'bedType': bedType,
      'roomPrice': roomPrice,
      'roomStatus': roomStatus,


    };
  }
}
