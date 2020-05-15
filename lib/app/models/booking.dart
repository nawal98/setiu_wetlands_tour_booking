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
  });

  String bookingId;
  String tourPackageId;
  DateTime start;
  DateTime end;
 int paxAdult;
  int paxChild;
  int paxInfant;

  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Booking.fromMap(Map<dynamic, dynamic> value, String bookingId) {
    final int startMilliseconds = value['start'];
    final int endMilliseconds = value['end'];
    return Booking(
      bookingId: bookingId,
      tourPackageId: value['tourPackageId'],
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      paxAdult:value['paxAdult'],
      paxChild:value['paxChild'],
      paxInfant:value['paxInfant'],
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
    };
  }
}
