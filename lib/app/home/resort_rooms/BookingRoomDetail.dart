import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';

class BookingRoomDetail extends StatelessWidget {
  const BookingRoomDetail(
      {Key key,
        @required this.database,
        @required this.tourPackage,
        @required this.bookingRoom,
        @required this.room,
      })
      : super(key: key);
  final Database database;
  final TourPackage tourPackage;
  final BookingRoom bookingRoom;
  final Room room;


  @override
  Widget build(BuildContext context) {
    final BookingRoom bookingRoom = ModalRoute.of(context).settings.arguments;

    final dayOfWeek = Format.dayOfWeek(bookingRoom.start);
    final startDate = Format.date(bookingRoom.start);
    final dayEndOfWeek = Format.dayOfWeek(bookingRoom.end);
    final endDate = Format.date(bookingRoom.end);
    final startTime = TimeOfDay.fromDateTime(bookingRoom.start).format(context);
    final endTime = TimeOfDay.fromDateTime(bookingRoom.end).format(context);

    final Firestore bf = Firestore.instance;
    return Scaffold(
        appBar: AppBar(
          title: Text('Room Booking Details'),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: Text(
                          bookingRoom.resortName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black87),
                        ),
                      ),
                    ]),
                    SizedBox(height: 15),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Duration',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text((bookingRoom.durationInHours.round()+1).toString()+' Days '+ (bookingRoom.durationInHours.round()+1 - 1).toString()+' Night',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),          SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Check-in Date',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(dayOfWeek + ' ' + startDate,
                              style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Check-in Time',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.checkinTime,
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),          SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Check-out Date',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(dayEndOfWeek + ' ' + endDate,
                              style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Check-out Time',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.checkoutTime,
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Room Type',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.roomType,
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Bed Type',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(bookingRoom.bedType,
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Total Room Booking',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.totalRoom.toString(),
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Total Extra Mattress',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.totalExtraMattress.toString(),
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Total Amount',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text('RM'+bookingRoom.totalAmountRoom.toStringAsFixed(2),
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),
                    ]), SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Tour Status',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.bookingStatus,
//                      child: Text('In Progress',
                            style: TextStyle(fontSize: 15.0,  color: Colors.black87)),
                      ),
                    ]),            SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Tour Status Description',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(bookingRoom.tourStatusDescription,
//                      child: Text('In Progress',
                            style: TextStyle(fontSize: 15.0,  color: Colors.black87)),
                      ),
                    ]),
                    SizedBox(height: 50),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: Text(
                          'Transfer your Payment To:',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),

                    ]),
                    SizedBox(height: 15),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Account Bank',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(bookingRoom.accBank,
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),

                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Account Number',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text( bookingRoom.accNo.toString(),
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),


                    ]),
                    SizedBox(height: 12),
                    Row(children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: Text(
                          'Reference',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text( 'SetiuBooking'+bookingRoom.roomType,
                            style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                      ),


                    ]),

                    SizedBox(height: 50),
//                    _buildContent(context, room,booking)
                  ]),
            )));
  }



}
