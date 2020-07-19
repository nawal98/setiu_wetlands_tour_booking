import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_operator_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_to_book_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/tour_bookings_page.dart';
import 'dart:async';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_operator_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class BookingOperator extends StatelessWidget {
  const BookingOperator({@required this.database,
    @required this.tourPackage, @required this.room,

    @required this.booking});
  final Database database;
  final TourPackage tourPackage;
  final Room room;
  final Booking booking;
//  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Customer Booking"),
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
              _buildContents(context, tourPackage,room,booking),
              _buildContentsRoom(context, room),
            ],
          ),

        ));
  }

  Widget _buildContents(BuildContext context, TourPackage tourPackage,Room room,Booking booking) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<TourPackage>>(
      stream: database.tourPackagesStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<TourPackage>(
            snapshot: snapshot,
            itemBuilder: (context, tourPackage) => Dismissible(
          key: Key('tourPackage-${tourPackage.tourPackageId}'),
          background: Container(),
          child: TourPackageOperatorListTile(
            tourPackage: tourPackage,
              onTap: () =>  TourBookingsPage.show(context,tourPackage),

            ),
          ),
        );
      },
    );
  }

  Widget _buildContentsRoom(BuildContext context, Room room) {

    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Room>>(
        stream: database.roomsOptionStream(),
        builder: (context, snapshot) {
          return ListItemBuilder<Room>(
              snapshot: snapshot,
              itemBuilder: (context, room) => Dismissible(
              key: Key('room-${room.id}'),
          background: Container(),
          child: RoomOperatorListTile(
          room: room,
          onTap: () =>  RoomtoBook.show(context,room),

          )));});
  }
//  Future<void> _deleteBookingRoom(BuildContext context, BookingRoom bookingRoom) async {
//    try {
//      final database = Provider.of<Database>(context);
//      await database.deleteBookingRoom(bookingRoom);
//    } on PlatformException catch (e) {
//      PlatformExceptionAlertDialog(
//        title: 'Operation failed',
//        exception: e,
//      ).show(context);
//    }
//  }
//  Future<void> _deleteBookingTour(BuildContext context, Booking booking) async {
//    try {
//      final database = Provider.of<Database>(context);
//      await database.deleteBooking(booking);
//    } on PlatformException catch (e) {
//      PlatformExceptionAlertDialog(
//        title: 'Operation failed',
//        exception: e,
//      ).show(context);
//    }
//  }
}
