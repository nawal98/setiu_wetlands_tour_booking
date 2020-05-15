import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_list_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/edit_tour_package_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class TourBookingsPage extends StatelessWidget {
  const TourBookingsPage({@required this.database, @required this.tourPackage});
  final Database database;
  final TourPackage tourPackage;

  static Future<void> show(BuildContext context, TourPackage tourPackage) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => TourBookingsPage(database: database, tourPackage: tourPackage),
      ),
    );
  }

  Future<void> _deleteBooking(BuildContext context, Booking booking) async {
    try {
      await database.deleteBooking(booking);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(tourPackage.tourName),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () => EditTourPackagePage.show(context, tourPackage: tourPackage),
          ),
        ],
      ),
      body: _buildContent(context, tourPackage),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            BookingPage.show(context: context, database: database, tourPackage: tourPackage),
      ),
    );
  }

  Widget _buildContent(BuildContext context, TourPackage tourPackage) {
    return StreamBuilder<List<Booking>>(
      stream: database.bookingsStream(tourPackage: tourPackage),
      builder: (context, snapshot) {
        return ListItemBuilder<Booking>(
          snapshot: snapshot,
          itemBuilder: (context, booking) {
            return DismissibleBookingListItem(
              key: Key('booking-${booking.bookingId}'),
              booking: booking,
              tourPackage: tourPackage,
              onDismissed: () => _deleteBooking(context, booking),
              onTap: () => BookingPage.show(
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
  }
}
