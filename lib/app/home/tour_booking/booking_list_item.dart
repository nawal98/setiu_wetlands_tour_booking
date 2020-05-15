import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';

class BookingListItem extends StatelessWidget {
  const BookingListItem({
    @required this.booking,
    @required this.tourPackage,
    @required this.onTap,
  });

  final Booking booking;
  final TourPackage tourPackage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
  }

  Widget _buildContents(BuildContext context) {
    final dayOfWeek = Format.dayOfWeek(booking.start);
    final startDate = Format.date(booking.start);
    final startTime = TimeOfDay.fromDateTime(booking.start).format(context);
    final endTime = TimeOfDay.fromDateTime(booking.end).format(context);
    final durationFormatted = Format.hours(booking.durationInHours);

    final pay = (tourPackage.tourAdultAmount).toDouble() * booking.durationInHours;
    final payFormatted = Format.currency(pay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(dayOfWeek, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          SizedBox(width: 15.0),
          Text(startDate, style: TextStyle(fontSize: 18.0)),
          if (tourPackage.tourAdultAmount > 0.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              payFormatted,
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
        ]),
        Row(children: <Widget>[
          Text('$startTime - $endTime', style: TextStyle(fontSize: 16.0)),
          Expanded(child: Container()),
          Text(durationFormatted, style: TextStyle(fontSize: 16.0)),
        ]),
//        if (booking.comment.isNotEmpty)
//          Text(
//            booking.comment,
//            style: TextStyle(fontSize: 12.0),
//            overflow: TextOverflow.ellipsis,
//            maxLines: 1,
//          ),
      ],
    );
  }
}

class DismissibleBookingListItem extends StatelessWidget {
  const DismissibleBookingListItem({
    this.key,
    this.booking,
    this.tourPackage,
    this.onDismissed,
    this.onTap,
  });

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
      onDismissed: (direction) => onDismissed(),
      child: BookingListItem(
        booking: booking,
        tourPackage: tourPackage,
        onTap: onTap,
      ),
    );
  }
}
