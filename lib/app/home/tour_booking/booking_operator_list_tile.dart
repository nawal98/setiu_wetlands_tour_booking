import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/BookingDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
class BookingOperatorListTile extends StatelessWidget {
  const BookingOperatorListTile({Key key, @required this.booking,@required this.database, @required this.tourPackage, this.onTap}):super(key:key);
  final Booking booking;
  final VoidCallback onTap;
  final TourPackage tourPackage;
  final Database database;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: booking,),),);
      },

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _buildContents(context, tourPackage),
            ),
            Icon(Icons.chevron_right, color: Colors.black),
          ],
        ),
      ),

    );
//        }
//    );
  }

  Widget _buildContents(BuildContext context, TourPackage tourPackage) {
    return StreamBuilder<TourPackage>(
        stream: database.tourPackageStream(tourPackageId: tourPackage.tourPackageId),
        builder: (context, snapshot) {
          final tourPackage =snapshot.data;
          final tourName= tourPackage ?.tourName?? '';
          final tourAdultAmount= tourPackage ?.tourAdultAmount??'0';
          final dayOfWeek = Format.dayOfWeek(booking.start);
          final startDate = Format.date(booking.start);
          final startTime = TimeOfDay.fromDateTime(booking.start).format(context);
          final endTime = TimeOfDay.fromDateTime(booking.end).format(context);
          final durationFormatted = Format.hours(booking.durationInHours);
//
//    final pay = booking.durationInHours * tourAdultAmount;
//    final payFormatted = Format.currency(pay);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text(dayOfWeek, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                SizedBox(width: 15.0),
                Text(startDate, style: TextStyle(fontSize: 18.0)),
                if (0.0 < tourAdultAmount) ...<Widget>[
                  Expanded(child: Container()),
                  Text(
                    booking.totalPriceAdult.toString(),
                    style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
                  ),
                ],
              ]),
              Row(children: <Widget>[
                Text('$startTime - $endTime', style: TextStyle(fontSize: 16.0)),
                Expanded(child: Container()),
                Text(durationFormatted, style: TextStyle(fontSize: 16.0)),
              ]),
            ],
          );
        }
    );
  }

}