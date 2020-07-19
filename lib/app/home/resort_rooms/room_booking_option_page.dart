import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_customer_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class RoomBookListOptionState extends StatelessWidget {
  const RoomBookListOptionState({
    @required this.room,
    @required this.onTap,
    @required this.database,
    @required this.booking,
  });
  final Database database;
  final Room room;
  final VoidCallback onTap;
  final Booking booking;

  static Future<void> show(
      BuildContext context, Room room, Booking booking) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false, //back button
        builder: (context) => RoomBookListOptionState(
          database: database,
          room: room,
          booking: booking,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Option"),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);

    return StreamBuilder<List<Room>>(
        stream: database.roomsOptionStream(),
        builder: (context, snapshot) {
          return ListItemBuilder<Room>(
              snapshot: snapshot,
              itemBuilder: (context, room) => Dismissible(
                  key: Key('room-${room.id}'),
                  background: Container(),
                  child: RoomCustomerListTile(
                    room: room,
                    booking: booking,
                  )));
        });
  }
}
