import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:setiuwetlandstourbooking/app/home/resort_rooms/date_time_picker.dart';
//import 'package:setiuwetlandstourbooking/app/home/resort_rooms/format.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({@required this.database, @required this.resort, this.room});
  final Resort resort;
  final Room room;
  final Database database;

  static Future<void> show(
      {BuildContext context,
      Database database,
      Resort resort,
      Room room}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) =>
            RoomPage(database: database, resort: resort, room: room),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String _roomNo;
  String _bedType;
  String _roomPrice;
  String _roomStatus;

  @override
  void initState() {
    super.initState();

     _roomNo = widget.room?.roomNo ?? '';
    _bedType = widget.room?.bedType ?? '';
    _roomPrice = widget.room?.roomPrice ?? '';
    _roomStatus = widget.room?.roomStatus ?? '';
  }


  Room _roomFromState() {
    final id = widget.room?.id ?? documentIdFromCurrentDate();
    return Room(
      id: id,
      resortId: widget.resort.resortId,
      roomNo: _roomNo,
      bedType: _bedType,
      roomPrice: _roomPrice,
      roomStatus: _roomStatus,
    );
  }

  Future<void> _setRoomAndDismiss(BuildContext context) async {
    try {
      final room = _roomFromState();
      await widget.database.setRoom(room);
      Navigator.of(context).pop();
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
        title: Text(widget.resort.resortName),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.room != null ? 'Update' : 'Create',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            onPressed: () => _setRoomAndDismiss(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildRoomNo(),
              _buildBedType(),
              SizedBox(height: 8.0),
              _buildRoomPrice(),
              SizedBox(height: 8.0),
              _buildRoomStatus(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildRoomNo() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _roomNo),
      decoration: InputDecoration(
        labelText: 'Room Number',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (roomNo) => _roomNo = roomNo,
    );
  }

  Widget _buildBedType() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _bedType),
      decoration: InputDecoration(
        labelText: 'Bed Type',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (bedType) => _bedType = bedType,
    );
  }

  Widget _buildRoomPrice() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _roomPrice),
      decoration: InputDecoration(
        labelText: 'Room Price(RM)',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (roomPrice) => _roomPrice = roomPrice,
    );
  }

  Widget _buildRoomStatus() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: _roomStatus),
      decoration: InputDecoration(
        labelText: 'Room Status',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (roomStatus) => _roomStatus = roomStatus,
    );
  }
}