import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:setiuwetlandstourbooking/app/home/tour_booking/date_time_picker.dart';

import 'package:setiuwetlandstourbooking/app/models/bookingroom.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/BookingRoomDetail.dart';

class RoomBooking extends StatefulWidget {
  const RoomBooking(
      {@required this.database, @required this.room, this.bookingRoom});
  final Room room;
  final BookingRoom bookingRoom;
  final Database database;

  static Future<void> show(
      {BuildContext context,
      Database database,
      Room room,
      BookingRoom bookingRoom}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => RoomBooking(
            database: database, room: room, bookingRoom: bookingRoom),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _RoomBookingState();
}

class _RoomBookingState extends State<RoomBooking> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;
  String resortName;
  String bedType;
  String roomType;
  int _totalRoom = 0;
  int _totalExtraMattress = 0;
  double _totalPriceRoom;
  double _totalPriceMattress;
  double _totalAmountRoom;
  String checkinTime;
  String checkoutTime;
  List<String> _bookingStatusOption = ['Not Approved Yet', 'Booking Approved'];
  String _bookingStatus;
  List<String> _tourStatusDescriptionOption = [
    'Please make your payment first',
    'Please completed your Profile information',
    'Payment received'
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
    final totRoom = widget.bookingRoom?.totalRoom ?? _totalRoom;
    final totMattress =
        widget.bookingRoom?.totalExtraMattress ?? _totalExtraMattress;
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

//      comment: _comment,
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
              _buildPayStatus(),
              SizedBox(height: 12),
              SizedBox(
                width: 300,
                child: Text(
                  widget.room.resortName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black54),
                ),
              ),
              SizedBox(
                width: 300,
                child: Text(
                  widget.room.roomType,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.black54),
                ),
              ),
              SizedBox(height: 12),
              _buildStartDate(),
              _buildEndDate(),
              SizedBox(height: 8.0),
//              _buildDurationDay(),

//              _buildComment(),

//              SizedBox(height: 12),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Extra Mattress',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      'Total Room',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 30),
                  SizedBox(
                    width: 30,
                    child: FloatingActionButton(
                      heroTag: "bt5",
                      onPressed: minusbed,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: Colors.black),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  new Text('$_totalExtraMattress',
                      style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        heroTag: "bt6",
                        onPressed: addbed,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.lightGreen,
                      )),
                  SizedBox(width: 65),
                  SizedBox(
                    width: 30,
                    child: FloatingActionButton(
                      heroTag: "bt7",
                      onPressed: minusroom,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: Colors.black),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  new Text('$_totalRoom', style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        heroTag: "bt8",
                        onPressed: addroom,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.lightGreen,
                      )),
                  SizedBox(width: 15),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 300,
                child: Text(
                  'TotalPrice ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black54),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Text('Total Room Price',
                      style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 15.0),
                  Expanded(child: Container()),
                  _buildPayRoom(),
                ],
              ),
              Row(children: <Widget>[
                Text('Total Mattress Price',
                    style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildPayMattress()
              ]),
              Row(children: <Widget>[
                Text('Total', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildPayTotal()
              ]),
              SizedBox(height: 16.0),
              Row(children: <Widget>[
                _buildPayStatusDescription(),
                Text(
                  ' at:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black54),
                ),
              ]),
              SizedBox(height: 8.0),
              Row(children: <Widget>[
                Text('Account Bank', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildAccBank(),
              ]),

              Row(children: <Widget>[
                Text('Account No.', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildAccNo(),
              ]),
              Row(children: <Widget>[
                  Text('Reference', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                Text('SetiuBooking'+ widget.room.roomType, style: new TextStyle(fontSize: 15.0)),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPayStatus() {
    final currentBooking = _bookingRoomFromState();

    _bookingStatus = currentBooking.bookingStatus;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_bookingStatus',
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.red),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayStatusDescription() {
    final currentBookingRoom = _bookingRoomFromState();

    _tourStatusDescription = currentBookingRoom.tourStatusDescription;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_tourStatusDescription',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.black54,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildAccBank() {
    final currentBookingRoom = _bookingRoomFromState();

    _accBank = currentBookingRoom.accBank;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_accBank',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildAccNo() {
    final currentBookingRoom = _bookingRoomFromState();

    _accNo = currentBookingRoom.accNo;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_accNo',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      selectDate: (date) => setState(() => _startDate = date),
      selectTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End',
      selectedDate: _endDate,
      selectedTime: _endTime,
      selectDate: (date) => setState(() => _endDate = date),
      selectTime: (time) => setState(() => _endTime = time),
    );
  }

  Widget _buildPayRoom() {
    final currentBookingRoom = _bookingRoomFromState();

    _totalPriceRoom = ((widget.room.roomPrice).toDouble() *
        ((currentBookingRoom.durationInHours.round() + 1 - 1)) *
        currentBookingRoom.totalRoom);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalPriceRoom' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayMattress() {
    final currentBookingRoom = _bookingRoomFromState();
    _totalPriceMattress = (widget.room.extraBed).toDouble() *
        currentBookingRoom.totalExtraMattress;
//    final payFormatted = Format.currency(currentBooking.pay);
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalPriceMattress' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayTotal() {
    _totalAmountRoom = _totalPriceRoom + _totalPriceMattress;
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalAmountRoom' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}
