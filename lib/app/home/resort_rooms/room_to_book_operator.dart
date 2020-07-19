import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/booking_room_operator_list_item.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/edit_booking_room_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class RoomtoBook extends StatelessWidget {
  const RoomtoBook({@required this.database, @required this.room});
  final Database database;
  final Room room;

  static Future<void> show(BuildContext context, Room room) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
        builder: (context) => RoomtoBook(database: database, room: room),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Room>(
        stream: database.roomStream(id: room.id),
        builder: (context, snapshot) {
          final room =snapshot.data;
          final roomName= room ?.roomType?? '';
          return Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              title: Text(room.roomType + ' booking'),
              actions: <Widget>[
//          FlatButton(
//            child: Text(
//              'Edit',
//              style: TextStyle(fontSize: 18.0, color: Colors.white),
//            ),
//            onPressed: () => EditTourPackagePage.show(context, tourPackage: tourPackage),
//          ),
              ],
            ),
            body: _buildContent(context, room),

          );
        });
//    );
  }

  Widget _buildContent(BuildContext context, Room room) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<BookingRoom>>(
      stream: database.bookingsRoomStream(room: room),
      builder: (context, snapshot) {
        return ListItemBuilder<BookingRoom>(
          snapshot: snapshot,
          itemBuilder: (context, bookingRoom) {
            return DismissibleBookingRoomOperatorListItem(
              key: Key('bookingRoom-${bookingRoom.bookingRoomId}'),
              bookingRoom: bookingRoom,
              room: room,
//              onDismissed: () => _deleteBooking(context, booking),
              onTap: () => EditBookingRoom.show(
                context: context,
                database: database,
                room: room,
                bookingRoom: bookingRoom,
              ),
            );
          },
        );
      },
    );
  }}
//}
