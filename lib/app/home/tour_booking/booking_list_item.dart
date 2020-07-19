import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/BookingDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
class BookingListItem extends StatelessWidget {
  const BookingListItem({
    @required this.booking,
    @required this.tourPackage,
    @required this.onTap,
    @required this.room,
    @required this.database,
  });
final Database database;
  final Booking booking;
  final TourPackage tourPackage;
  final VoidCallback onTap;
final Room room;
  static Future<void> show(
      {BuildContext context,
        Database database,
        TourPackage tourPackage,
        Room room,
        Booking booking}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => BookingListItem(
            database: database, tourPackage: tourPackage, booking: booking,room: room,),
        fullscreenDialog: true,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
return  InkWell(
      onTap:
//      onTap,
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  BookingDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: booking,
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

    final dayOfWeek = Format.dayOfWeek(booking.start);
    final startDate =   Format.date(booking.start);
    final startTime = TimeOfDay.fromDateTime(booking.start).format(context);
    final endTime = TimeOfDay.fromDateTime(booking.end).format(context);
    final durationFormatted = Format.hours(booking.durationInHours);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(booking.tourName, style: TextStyle(fontSize: 18.0, color: Colors.black87)),


        ],
        ),
        Row(children: <Widget>[
          Text(dayOfWeek, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          SizedBox(width: 15.0),
          Text(startDate, style: TextStyle(fontSize: 18.0)),

            Expanded(child: Container()),
            Text('RM '+
              booking.totalPrice.toString()+'0',
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),

        ],
        ),
        Row(children: <Widget>[
          Text('$startTime - $endTime', style: TextStyle(fontSize: 16.0)),
          Expanded(child: Container()),
          Text(durationFormatted, style: TextStyle(fontSize: 16.0)),
        ]),

      ],
    );
  }
}

class DismissibleBookingListItem extends StatelessWidget {
  const DismissibleBookingListItem({
    this.key,
    this.booking,
    this.room,
    this.tourPackage,
    this.onDismissed,
    this.onTap,
  });
final Room room;
  final Key key;
  final Booking booking;
  final TourPackage tourPackage;
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
                  "Are you sure you wish to cancel this tour booking?"),
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
      child: BookingListItem(
        booking: booking,
        tourPackage: tourPackage,
        onTap: onTap,
        room:room
      ),
    );
  }
}
