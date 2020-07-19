import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/RoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_customer_list_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_admin_list_item.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
class ResortRoomsCustomer extends StatelessWidget {
  const ResortRoomsCustomer({@required this.database, @required this.resort});
  final Database database;
  final Resort resort;

  static Future<void> show(BuildContext context, Resort resort) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
        CupertinoPageRoute(
            fullscreenDialog: false,//back button
            builder: (context) =>
                ResortRoomsCustomer(database: database, resort: resort),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Resort>(
        stream: database.resortStream(resortId: resort.resortId),
        builder: (context, snapshot) {
          final resort =snapshot.data;
          final resortName= resort ?.resortName?? '';
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(resortName),
        centerTitle: true,
      ),
      body: _buildContent(context, resort),
    );
        }
    );
  }

  Widget _buildContent(BuildContext context, Resort resort) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Room>>(
      stream: database.roomsStream(resort: resort),
      builder: (context, snapshot) {
        return ListItemBuilder<Room>(
            snapshot: snapshot,

            itemBuilder: (context, room){
            return DismissibleCustomerRoomListItem(
            key: Key('room-${room.id}'),
          room: room,
          resort: resort,
              onTap: () => RoomDetail(),


            );
      },
    );
  });
}}