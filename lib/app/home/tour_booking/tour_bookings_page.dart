import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/edit_booking_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_operator_list_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class TourBookingsPage extends StatelessWidget {
  const TourBookingsPage({@required this.database, @required this.tourPackage});
  final Database database;
  final TourPackage tourPackage;

  static Future<void> show(BuildContext context, TourPackage tourPackage) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
        builder: (context) => TourBookingsPage(database: database, tourPackage: tourPackage),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TourPackage>(
        stream: database.tourPackageStream(tourPackageId: tourPackage.tourPackageId),
        builder: (context, snapshot) {
          final tourPackage =snapshot.data;
          final tourName= tourPackage ?.tourName?? '';
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(tourPackage.tourName + ' booking'),
        actions: <Widget>[
        ],
      ),
      body: _buildContent(context, tourPackage),

    );
        });
//    );
  }

  Widget _buildContent(BuildContext context, TourPackage tourPackage) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Booking>>(
      stream: database.bookingsStream(tourPackage: tourPackage),
      builder: (context, snapshot) {
        return ListItemBuilder<Booking>(
          snapshot: snapshot,
          itemBuilder: (context, booking) {
            return DismissibleBookingOperatorListItem(
              key: Key('booking-${booking.bookingId}'),
              booking: booking,
              tourPackage: tourPackage,
//              onDismissed: () => _deleteBooking(context, booking),
              onTap: () => EditBookingPage.show(
                context: context,
                database: database,
                tourPackage: tourPackage,
                booking: booking,
              ),
            );
          },
        );
      },
    );
  }}
//}
