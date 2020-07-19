import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_admin_list_item.dart';
//import 'package:setiuwetlandstourbooking/app/home/resort_rooms/edit_room_page.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/edit_resort_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class ResortRoomsPage extends StatelessWidget {
  const ResortRoomsPage({@required this.database, @required this.resort});
  final Database database;
  final Resort resort;

  static Future<void> show(BuildContext context, Resort resort) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,//back button
        builder: (context) =>
            ResortRoomsPage(database: database, resort: resort),
      ),
    );
  }

  Future<void> _deleteRoom(BuildContext context, Room room) async {
    try {
      await database.deleteRoom(room);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
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
            actions: <Widget>[
              IconButton(
                icon:Icon(Icons.edit,color: Colors.black),

                onPressed: () => EditResortPage.show(context,
                    database: database, resort: resort),
              ),
              IconButton(
//                icon:Icon(Icons.add,color: Colors.black),
//                onPressed: () =>
//                    RoomPage.show(context: context, database: database, resort: resort),
//              ),
              )],

          ),
          body: _buildContent(context, resort),
        );
      }
    );
  }

  Widget _buildContent(BuildContext context, Resort resort) {
    return StreamBuilder<List<Room>>(
      stream: database.roomsStream(resort: resort),
      builder: (context, snapshot) {
        return ListItemBuilder<Room>(
          snapshot: snapshot,
          itemBuilder: (context, room) {
            return DismissibleRoomListItem(
              key: Key('room-${room.id}'),
              room: room,
              resort: resort,
              onDismissed: () => _deleteRoom(context, room),
//              onTap: () => RoomPage.show(
//                context: context,
//                database: database,
//                resort: resort,
//                room: room,
//              ),
            );
          },
        );
      },
    );
  }

}
