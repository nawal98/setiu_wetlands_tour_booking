import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_booking.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_page.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';

import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class RoomDetail extends StatefulWidget {

  const RoomDetail(
      {@required this.database, @required this.room, this.booking});
  final Room room;
  final Booking booking;
  final Database database;

  State<StatefulWidget> createState() => _RoomDetailState();
}
class _RoomDetailState extends State<RoomDetail> {
  String get image => null;
  int _r = 0;
  void addr() {
    setState(() {
      _r++;
    });
  }

  void minusr() {
    setState(() {
      if (_r != 0) _r--;
    });
  }
  @override
  Widget build(BuildContext context) {
    final Room room = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(room.roomType),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 250,
                            child: Text(
                              'General Info',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black54),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text('RM'+
                            room.roomPrice.toString(),
                            style: TextStyle(fontSize: 18.0, color: Colors.green[700],fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),
                      SizedBox(
                        width: 360,
                        child: Text(
                          room.roomDescription,
//                  textAlign: TextAlign.left,
                          style:
                          TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.people, color: Colors.lightGreen),
                        ),
                        SizedBox(
                          width: 260,
                          child:
                          Text('Maximum for '+room.person.toString()+ ' persons only', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                        ), ]),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.hotel, color: Colors.lightGreen),
                        ),

                        Text(room.bedType, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),

                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.room, color: Colors.lightGreen),
                        ),

                        Text(room.roomUnit.toString()+' units available', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.opacity, color: Colors.lightGreen),
                        ),

                        Text(room.roomUnit.toString()+' bathroom', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.live_tv, color: Colors.lightGreen),
                        ),

                        Text(room.television.toString()+' television', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add_box, color: Colors.lightGreen),
                        ),

                        Text('RM'+room.extraBed.toString() +' / extra mattress', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),

                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.access_time, color: Colors.lightGreen),
                        ),

                        Text('Check-in: '+room.checkinTime+'/Check-out: '+room.checkoutTime, style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),



                    _buildContent(context, room),
                      SizedBox(height: 50),
                    ]))));
  }
  Widget _buildContent(BuildContext context, Room room) {
    final Database database = Provider.of<Database>(context);

    return ButtonTheme(
      minWidth: 325.0,
      child: RaisedButton(
//                onPressed: ()  => TourBookingsPage.show(context, tourPackage),//list booking
        onPressed: () =>
           RoomBooking.show(context: context,database: database,room: room),
//                onPressed: ()  => BookingDetail(),
//                  onPressed: () => BookingDetail.show(context, tourPackage),
//                onPressed: () => _setBookingAndDismiss(context),
        color: Colors.lightGreen,
        child: const Text('Add To Booking',
            style: TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }

}