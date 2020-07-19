import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/RoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/ActivityDetail.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class RoomCustomerListTile extends StatelessWidget {
  const RoomCustomerListTile(
      {Key key,
      @required this.room,
      @required this.booking,
      this.database,
      this.onTap})
      : super(key: key);
  final Room room;
  final VoidCallback onTap;
  final Booking booking;
  final Database database;

  static Future<void> show(
      BuildContext context, Room room, Booking booking) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false, //back button
        builder: (context) => RoomCustomerListTile(
          database: database,
          room: room,
          booking: booking,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  RoomDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: room,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context, room),
            ),
            Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context, Room room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
//            SizedBox(width: 15.0),
            Text(room.resortName, style: TextStyle(fontSize: 18.0)),
            Expanded(child: Container()),
            Text(
              'RM' + room.roomPrice.toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
        ),
        Row(children: <Widget>[
//            SizedBox(width: 15.0),
          Text(room.roomType, style: TextStyle(fontSize: 18.0)),
        ]),
        Row(
          children: <Widget>[
//            SizedBox(width: 15.0),
            Text(room.bedType + ' * For ' + room.person.toString() + ' person',
                style: TextStyle(fontSize: 15.0, color: Colors.black54)),
            Expanded(child: Container()),
          ],
        ),
        Row(
          children: <Widget>[
//            SizedBox(width: 15.0),
            Text(room.roomUnit.toString() + ' units available',
                style: TextStyle(fontSize: 15.0, color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
