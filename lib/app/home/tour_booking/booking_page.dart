import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/BookingDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/date_time_picker.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/tour_bookings_page.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class BookingPage extends StatefulWidget {
  const BookingPage(
      {@required this.database, @required this.tourPackage, this.booking});
  final TourPackage tourPackage;
  final Booking booking;
  final Database database;

  static Future<void> show(
      {BuildContext context,
      Database database,
      TourPackage tourPackage,
      Booking booking}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookingPage(
            database: database, tourPackage: tourPackage, booking: booking),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;

  int _paxAdult = 0;
  int _paxChild = 0;
  int _paxInfant = 0;

//  String _comment;

  @override
  void initState() {
    super.initState();
    final start = widget.booking?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.booking?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    _paxAdult = widget.booking?.paxAdult ?? 0;
    _paxAdult = widget.booking?.paxChild ?? 0;
    _paxAdult = widget.booking?.paxInfant ?? 0;
//    _comment = widget.booking?.comment ?? '';
  }

  Booking _bookingFromState() {
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute);
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    final id = widget.booking?.bookingId ?? documentIdFromCurrentDate();
    return Booking(
      bookingId: id,
      tourPackageId: widget.tourPackage.tourPackageId,
      start: start,
      end: end,
      paxAdult: _paxAdult,
      paxChild: _paxChild,
      paxInfant: _paxInfant,

//      comment: _comment,
    );
  }

  Future<void> _setBookingAndDismiss(BuildContext context) async {
    try {
      final booking = _bookingFromState();
      await widget.database.setBooking(booking);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingDetail()),
      );
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
    void add() {
    setState(() {
      _paxAdult++;
    });
  }

  void minus() {
    setState(() {
      if (_paxAdult != 0) _paxAdult--;
    });
  }

  void addm() {
    setState(() {
      _paxChild++;
    });
  }

  void minusm() {
    setState(() {
      if (_paxChild != 0) _paxChild--;
    });
  }

  void addo() {
    setState(() {
      _paxInfant++;
    });
  }

  void minuso() {
    setState(() {
      if (_paxInfant != 0) _paxInfant--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.tourPackage.tourName),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.booking != null ? 'Update' : 'Create',
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

              SizedBox(
                width: 300,
                child: Text(
                  'Select Tour Date and Time',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black54),
                ),
              ),
              SizedBox(height: 12),
              _buildStartDate(),
              _buildEndDate(),
              SizedBox(height: 8.0),
              _buildDuration(),
              SizedBox(height: 8.0),

//              _buildComment(),
              SizedBox(
                width: 300,
                child: Text(
                  'Select No. of Pax',
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
                  SizedBox(
                    width: 105,
                    child: Text(
                      'Adult',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: Text(
                      'Child',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: Text(
                      'Infant',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  SizedBox(
                    width: 105,
                    child: Text(
                      '> 12 Yrs',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.0, color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: Text(
                      '2 - 12 Yrs',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.0, color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    width: 105,
                    child: Text(
                      '0 - 2 Yrs',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.0, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  SizedBox(
                    width: 30,
                    child: FloatingActionButton(
                      heroTag: "bt1",
                      onPressed: minus,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: Colors.black),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  new Text('$_paxAdult', style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        heroTag: "bt2",
                        onPressed: add,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.lightGreen,
                      )),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 30,
                    child: FloatingActionButton(
                      heroTag: "bt3",
                      onPressed: minusm,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: Colors.black),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  new Text('$_paxChild', style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        heroTag: "bt4",
                        onPressed: addm,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.lightGreen,
                      )),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 30,
                    child: FloatingActionButton(
                      heroTag: "bt5",
                      onPressed: minuso,
                      child: new Icon(
                          const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                          color: Colors.black),
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  new Text('$_paxInfant', style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 30,
                      child: FloatingActionButton(
                        heroTag: "bt6",
                        onPressed: addo,
                        child: new Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.lightGreen,
                      )),
                ],
              ),
//              _buildAdult(),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildDuration() {
    final currentBooking = _bookingFromState();
    final durationFormatted = Format.hours(currentBooking.durationInHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Duration: $durationFormatted',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

//  Widget _buildAdult() {
//    return TextField(
//      keyboardType: TextInputType.number,
//      maxLength: 20,
//      inputFormatters: <TextInputFormatter>[
//        WhitelistingTextInputFormatter.digitsOnly
//      ], // Only numbers can be entered
//
////      controller: TextEditingController(text: (_paxAdult).toString()),
//      decoration: InputDecoration(
//        labelText: 'Adult',
//        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
//      ),
//      style: TextStyle(fontSize: 20.0, color: Colors.black),
//      maxLines: null,
//      onChanged: (paxAdult) => _paxAdult = int.tryParse(paxAdult) ??paxAdult,
////      onChanged: (comment) => _comment = comment,
//    );
//  }
}
