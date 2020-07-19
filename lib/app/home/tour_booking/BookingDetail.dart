import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_booking_option_page.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail(
      {Key key,
      @required this.database,
      @required this.tourPackage,
      @required this.booking,
      @required this.room,
})
      : super(key: key);
  final Database database;
  final TourPackage tourPackage;
  final Booking booking;
  final Room room;


  @override
  Widget build(BuildContext context) {
    final Booking booking = ModalRoute.of(context).settings.arguments;

    final dayOfWeek = Format.dayOfWeek(booking.start);
    final startDate = Format.date(booking.start);
    final startTime = TimeOfDay.fromDateTime(booking.start).format(context);
    final endTime = TimeOfDay.fromDateTime(booking.end).format(context);

    final Firestore bf = Firestore.instance;
    return Scaffold(
        appBar: AppBar(
          title: Text('Booking Details'),
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
                      booking.tourName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black87),
                    ),
                  ),
                ]),
                SizedBox(height: 15),

                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      child: Text(
                        'Tour Date',
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
                      'Tour Time',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text('$startTime - $endTime',
                        style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                  ),
                ]),
                SizedBox(height: 12),
                Row(children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Text(
                      'Adult',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(booking.paxAdult.toString(),
                        style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                  ),
                ]),
                SizedBox(height: 12),
                Row(children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Text(
                      'Children',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(booking.paxChild.toString(),
                        style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                  ),
                ]),
                SizedBox(height: 12),
                Row(children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: Text(
                      'Infant',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.0,  fontWeight: FontWeight.bold,color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(booking.paxInfant.toString(),
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
                    child: Text('RM'+booking.totalPrice.toStringAsFixed(2),
                        style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                  ),
                ]),            SizedBox(height: 12),
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
                    child: Text(booking.bookingStatus,
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
                    child: Text(booking.tourStatusDescription,
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
                    child: Text(booking.accBank,
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
                    child: Text( booking.accNo.toString(),
                        style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                  ),


                ]), SizedBox(height: 12),
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
                    child: Text( 'SetiuBooking'+booking.tourName,
                        style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                  ),


                ]),
                SizedBox(height: 15),

                _buildContent(context, room,booking),
                SizedBox(height: 50),

              ]),
        )));
  }
  Widget _buildContent(BuildContext context, Room room, Booking booking) {


    return ButtonTheme(
      minWidth: 325.0,
      child: RaisedButton(
//                onPressed: ()  => TourBookingsPage.show(context, tourPackage),//list booking
        onPressed: () =>
           RoomBookListOptionState.show(context, room,booking),

        color: Colors.lightGreen,
        child: const Text('Get Room Nearby',
            style: TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }


}
