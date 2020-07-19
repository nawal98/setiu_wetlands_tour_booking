import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/BookingRoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_booking.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
class BookingRoomListItem extends StatelessWidget {
  const BookingRoomListItem({
    @required this.bookingRoom,
    @required this.room,
    @required this.onTap,

  });

  final BookingRoom bookingRoom;
  final Room room;
  final VoidCallback onTap;

  static Future<void> show(
      {BuildContext context,
        Database database,
        Room room,
        BookingRoom bookingRoom}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => RoomBooking(
            database: database, room: room, bookingRoom: bookingRoom),
        fullscreenDialog: true,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  BookingRoomDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: bookingRoom,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
//      ),
//    );
  }

  Widget _buildContents(BuildContext context) {

    final dayOfWeek = Format.dayOfWeek(bookingRoom.start);
    final startDate = Format.date(bookingRoom.start);
    final startTime = TimeOfDay.fromDateTime(bookingRoom.start).format(context);
    final endTime = TimeOfDay.fromDateTime(bookingRoom.end).format(context);
    final durationFormatted = Format.hours(bookingRoom.durationInHours);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(bookingRoom.resortName, style: TextStyle(fontSize: 18.0, color: Colors.black87)),
        ],
        ),
        Row(children: <Widget>[
          Text(dayOfWeek, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          SizedBox(width: 15.0),
          Text(startDate, style: TextStyle(fontSize: 18.0)),

          Expanded(child: Container()),
          Text('RM '+
              bookingRoom.totalAmountRoom.toString()+'0',
            style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
          ),

        ],
        ),
        Row(children: <Widget>[
          Text((bookingRoom.durationInHours.round()+1).toString()+' Days '+ (bookingRoom.durationInHours.round()+1 - 1).toString()+' Night',
              style: TextStyle(fontSize: 15.0, color: Colors.black87)),

        ],
        ),

      ],
    );
  }
}

class DismissibleBookingRoomListItem extends StatelessWidget {
  const DismissibleBookingRoomListItem({
    this.key,
    this.bookingRoom,
//    this.room,
    this.onDismissed,
    this.onTap,
  });

  final Key key;
  final BookingRoom bookingRoom;
//  final Room room;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,

      direction: DismissDirection.endToStart,
      confirmDismiss: ( DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Cancel"),
              content: const Text(
                  "Are you sure you wish to cancel this room booking?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => onDismissed(),
      child: BookingRoomListItem(

        bookingRoom: bookingRoom,
//        room: room,
        onTap: onTap,
      ),
    );
  }

}


