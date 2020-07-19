
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/BookingRoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/date_time_picker.dart';
import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class EditBookingRoom extends StatefulWidget {
  const EditBookingRoom(
      {@required this.database,
        @required this.room,
        this.bookingRoom});
  final Room room;
  final BookingRoom bookingRoom;
  final Database database;


  static Future<void> show(
      {BuildContext context,
        Database database,

        BookingRoom bookingRoom, Room room}) async {
    await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => EditBookingRoom(
            database: database, bookingRoom: bookingRoom,
          room: room,
          ),
          fullscreenDialog: true,
        ));
  }

  @override
  State<StatefulWidget> createState() => _EditBookingRoomState();
}

class _EditBookingRoomState extends State<EditBookingRoom> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;
  String resortName;
  String bedType;
  String roomType;
  int _totalRoom = 0;
  int _totalExtraMattress = 0;
  String checkinTime;
  String checkoutTime;
  double _totalPriceRoom;
  double _totalPriceMattress;
  double _totalAmountRoom;
  List<String> _bookingStatusOption = ['Not Approved Yet', 'Booking Approved', 'Rejected'];
  String _bookingStatus;
  List<String> _tourStatusDescriptionOption = [
    'Please make your payment first',
    'Please completed your Profile information',
    'Payment received',

  ];
  String _tourStatusDescription;
  int _accNo;
  List<String> _accBankOption = [
    'CIMB',
    'MayBank',
    'Public Bank',
    'Bank Islam Berhad',
    'RHB Bank'
  ];
  String _accBank;

  @override
  void initState() {
    super.initState();

    final start = widget.bookingRoom?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.bookingRoom?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);
    _totalRoom = widget.bookingRoom?.totalRoom ?? 0;
    _totalExtraMattress = widget.bookingRoom?.totalExtraMattress ?? 0;
    _totalPriceRoom = widget.bookingRoom?.totalPriceRoom ?? 0;
    _totalPriceMattress = widget.bookingRoom?.totalPriceMattress ?? 0;
    _totalAmountRoom = widget.bookingRoom?.totalAmountRoom ?? 0;

    _bookingStatus = widget.bookingRoom?.bookingStatus ?? 'Not Approved Yet';
    _tourStatusDescription = widget.bookingRoom?.tourStatusDescription ??
        'Please make your payment first';
    _accNo = widget.bookingRoom?.accNo ?? 70211683205724;
    _accBank = widget.bookingRoom?.accBank ?? 'CIMB';

  }

  BookingRoom _bookingRoomFromState() {
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute);
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    final totRoom= widget.bookingRoom?.totalRoom ?? _totalRoom;
    final totMattress= widget.bookingRoom?.totalExtraMattress ?? _totalExtraMattress;
    final id = widget.bookingRoom?.bookingRoomId ?? documentIdFromCurrentDate();
    return BookingRoom(
      bookingRoomId: id,
      id: widget.room.id,
      resortName: widget.room.resortName,
      bedType: widget.room.bedType,
      roomType: widget.room.roomType,
      checkinTime: widget.room.checkinTime,
      checkoutTime: widget.room.checkoutTime,
      start: start,
      end: end,
      totalRoom: totRoom,
      totalExtraMattress: totMattress,
      totalPriceRoom: _totalPriceRoom,
      totalPriceMattress: _totalPriceMattress,
      totalAmountRoom: _totalAmountRoom,
      bookingStatus: _bookingStatus,
      tourStatusDescription: _tourStatusDescription,
      accBank: _accBank,
      accNo: _accNo,

    );
  }

  Future<void> _setBookingAndDismiss(BuildContext context) async {
    try {
      final bookingRoom = _bookingRoomFromState();

      await widget.database.setBookingRoom(bookingRoom);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingRoomDetail(),
            settings: RouteSettings(
              arguments: bookingRoom,
            )),
      );
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  void addbed() {
    setState(() {
      _totalExtraMattress++;
    });
  }

  void minusbed() {
    setState(() {
      if (_totalExtraMattress != 0) _totalExtraMattress--;
    });
  }

  void addroom() {
    setState(() {
      _totalRoom++;
    });
  }

  void minusroom() {
    setState(() {
      if (_totalRoom != 0) _totalRoom--;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Room Booking'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.bookingRoom != null ? 'Update' : 'Submit',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            onPressed: () => _setBookingAndDismiss(context),
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
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 165,
                    child: Text(
                      'Booking Status',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0,color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: _buildBookingStatus(),
                  ),
                ],
              ), SizedBox(height: 18),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: Text(
                      'Booking Status Description',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0,color: Colors.black54),
                    ),
                  ),],),
              Row(
                children: <Widget>[
                  Flexible(child: _buildPayStatusDescription()),
                ],
              ), SizedBox(height: 12),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 165,
                    child: Text(
                      'Account Bank',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0,color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    child: _buildAccBank(),
                  ),
                ],
              ), SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                      child: _buildAccNo()
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingStatus() {
    return DropdownButton(
      value: _bookingStatus,
      onChanged: (newValue) {
        setState(() {
          _bookingStatus = newValue;
        });
      },
      items: _bookingStatusOption.map((bookstatus) {
        return DropdownMenuItem(
          child: new Text(bookstatus),
          value: bookstatus,
        );
      }).toList(),
    ); }
  Widget _buildPayStatusDescription() {
    return DropdownButton(

      value: _tourStatusDescription,
      onChanged: (newValue) {
        setState(() {
          _tourStatusDescription = newValue;
        });
      },
      items: _tourStatusDescriptionOption.map((bookstatusdesc) {
        return DropdownMenuItem(
          child: new Text(bookstatusdesc),
          value: bookstatusdesc,
        );
      }).toList(),
    );
  }

  Widget _buildAccBank() {
    return DropdownButton(
      value: _accBank,
      onChanged: (newValue) {
        setState(() {
          _accBank = newValue;
        });
      },
      items: _accBankOption.map((acc) {
        return DropdownMenuItem(
          child: new Text(acc),
          value: acc,
        );
      }).toList(),
    );
  }

  Widget _buildAccNo() {
    final currentBookingRoom = _bookingRoomFromState();

    _accNo = currentBookingRoom.accNo;
    return TextField(
      decoration: InputDecoration(labelText: 'Account Number',labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
      controller: TextEditingController(text: _accNo.toString()),

      keyboardType: TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      onChanged: (accno) => _accNo = int.tryParse(accno) ?? 0,
    );
  }

}
