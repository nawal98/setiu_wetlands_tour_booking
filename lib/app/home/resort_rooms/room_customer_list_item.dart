import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/RoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';

class RoomCustomerListItem extends StatelessWidget {
  const RoomCustomerListItem({
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  RoomDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: room,
            ),
          ),
        );
      },
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
        Row(
          children: <Widget>[
//            SizedBox(width: 15.0),
            Text(room.roomType, style: TextStyle(fontSize: 18.0)),
            Expanded(child: Container()),
            Text(
              'RM' + room.roomPrice.toString(),
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
        ),
        Row(
          children: <Widget>[
//            SizedBox(width: 15.0),
            Text(room.bedType+ ' * For ' + room.person.toString()+' person', style: TextStyle(fontSize: 15.0, color: Colors.black54)),
            Expanded(child: Container()),

          ],
        ),
        Row(
          children: <Widget>[
//            SizedBox(width: 15.0),
            Text(room.roomUnit.toString() + ' units available', style: TextStyle(fontSize: 15.0, color: Colors.black54)),

          ],
        ),
      ],
    );
  }
}

class DismissibleCustomerRoomListItem extends StatelessWidget {
  const DismissibleCustomerRoomListItem({
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
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Delete"),
              content: const Text("Are you sure you wish to delete this room?"),
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
      child: RoomCustomerListItem(
        room: room,
        resort: resort,
        onTap: onTap,
      ),
    );
  }
}
