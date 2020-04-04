import 'package:flutter/material.dart';
//import 'package:setiuwetlandstourbooking/app/home/resort_rooms/format.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem({
    @required this.room,
    @required this.resort,
    @required this.onTap,
  });

  final Room room;
  final Resort resort;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text(room.roomNo, style: TextStyle(fontSize: 18.0, color: Colors.grey)),
          SizedBox(width: 15.0),
          Text(room.bedType, style: TextStyle(fontSize: 18.0)),
//          if (resort.ratePerHour > 0.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              room.roomStatus,
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
        ),
        Row(children: <Widget>[
          Text('', style: TextStyle(fontSize: 16.0)),
          SizedBox(width: 45.0),
          Text("RM "+room.roomPrice, style: TextStyle(fontSize: 16.0)),


        ]),

      ],
    );
  }
}

class DismissibleRoomListItem extends StatelessWidget {
  const DismissibleRoomListItem({
    this.key,
    this.room,
    this.resort,
    this.onDismissed,
    this.onTap,
  });

  final Key key;
  final Room room;
  final Resort resort;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart, confirmDismiss:
        (DismissDirection direction) async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text(
                "Are you sure you wish to delete this room?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("DELETE")),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("CANCEL"),
              ),
            ],
          );
        },
      );
    },
      onDismissed: (direction) => onDismissed(),
      child: RoomListItem(

        room: room,
        resort: resort,
        onTap: onTap,
      ),
    );
  }
}
