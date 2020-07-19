import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/BookingRoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_booking_list_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/BookingDetail.dart';

import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_list_item.dart';

class BookingCustomer extends StatelessWidget {
  const BookingCustomer({@required this.database, @required this.tourPackage, @required this.room});
  final Database database;
  final TourPackage tourPackage;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
      appBar: AppBar(
        title: Text("My Booking"),
        bottom:   TabBar(
          tabs: [
            Tab(icon: Icon(Icons.event_busy),text: 'Tour Booking',),
            Tab(icon: Icon(Icons.hotel),text: "Room Booking",),
          ],
          indicatorColor: Colors.black87,
          indicatorWeight: 5.0,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          _buildContents(context, tourPackage,room),
        _buildContentsRoom(context, room),
        ],
      ),
//      _buildContents(context, tourPackage),
        ));
  }

  Widget _buildContents(BuildContext context, TourPackage tourPackage,Room room) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Booking>>(
      stream: database.bookingsStream(tourPackage: tourPackage),
      builder: (context, snapshot) {
        return ListItemBuilder<Booking>(
          snapshot: snapshot,
          itemBuilder: (context, booking) => DismissibleBookingListItem(
            key: Key('booking-${booking.bookingId}'),
            booking: booking,
//            tourPackage: tourPackage,
            onDismissed: () => _deleteBookingTour(context, booking),
            onTap: () => BookingDetail(),
          ),
        );
      },
    );
  }

  Widget _buildContentsRoom(BuildContext context, Room room) {

    final database = Provider.of<Database>(context);
    return StreamBuilder<List<BookingRoom>>(
      stream: database.bookingsRoomStream(room: room),
      builder: (context, snapshot) {
        return ListItemBuilder<BookingRoom>(
          snapshot: snapshot,
          itemBuilder: (context, bookingRoom) => DismissibleBookingRoomListItem(
            key: Key('bookingRoom-${bookingRoom.bookingRoomId}'),
            bookingRoom: bookingRoom,
//            room: room,
            onDismissed: () => _deleteBookingRoom(context, bookingRoom),
            onTap: () => BookingRoomDetail(),
          )
          );

      },
    );
  }
  Future<void> _deleteBookingRoom(BuildContext context, BookingRoom bookingRoom) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteBookingRoom(bookingRoom);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
  Future<void> _deleteBookingTour(BuildContext context, Booking booking) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteBooking(booking);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
