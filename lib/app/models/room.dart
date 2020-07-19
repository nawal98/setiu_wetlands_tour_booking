import 'package:flutter/foundation.dart';

class Room {
  Room({
    @required this.id,
    @required this.resortId,
    @required this.roomUnit,
    @required this.bedType,
    @required this.roomPrice,
    @required this.roomStatus,
    @required this.resortName,
    @required this.roomType,
    @required this.person,
    @required this.roomDescription,
    @required this.bathroom,
    @required this.television,
    @required this.extraBed,
    @required this.checkinTime,
    @required this.checkoutTime,



  });

  String id;
  String resortId;
  String resortName;
  int roomUnit;
  String roomType;
  String bedType;
  int person;
  int roomPrice;
  String roomStatus;
  String roomDescription;
  int bathroom;
  int television;
  int extraBed;
  String checkinTime;
  String checkoutTime;



  factory Room.fromMap(Map<dynamic, dynamic> value, String id) {

    return Room(
      id: id,
      resortId: value['resortId'],
      resortName: value['resortName'],
      roomUnit: value['roomUnit'],
      roomType: value['roomType'],
      bedType: value['bedType'],
      person: value['person'],
      roomPrice: value['roomPrice'],
      roomStatus: value['roomStatus'],
      roomDescription: value['roomDescription'],
      bathroom: value['bathroom'],
      television: value['television'],
      extraBed: value['extraBed'],
      checkinTime: value['checkinTime'],
      checkoutTime: value['checkoutTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resortId': resortId,
      'roomUnit': roomUnit,
      'bedType': bedType,
      'roomPrice': roomPrice,
      'roomStatus': roomStatus,
      'resortName': resortName,
      'roomType': roomType,
      'person': person,
      'roomDescription': roomDescription,
      'bathroom': bathroom,
      'television': television,
      'extraBed': extraBed,
     'checkinTime':checkinTime,
     'checkoutTime':checkoutTime,

    };
  }
}
