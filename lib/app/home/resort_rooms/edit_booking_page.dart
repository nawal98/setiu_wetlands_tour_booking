
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/bookingOperatorDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/date_time_picker.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class EditBookingPage extends StatefulWidget {
  const EditBookingPage(
      {@required this.database,
        @required this.tourPackage,
//        @required this.room,
      this.booking});
  final TourPackage tourPackage;
  final Booking booking;
  final Database database;
//  final Room room;

  static Future<void> show(
      {BuildContext context,
      Database database,
        TourPackage tourPackage,
//        Room room,
      Booking booking}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditBookingPage(
          database: database, tourPackage: tourPackage, booking: booking,
//          room: room,

//          database: database, booking: booking,
        ),
        fullscreenDialog: true,
//      ),
    ));
  }

  @override
  State<StatefulWidget> createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;

  int _paxAdult = 0;
  int _paxChild = 0;
  int _paxInfant = 0;
  double _totalPriceAdult;
  double _totalPriceChild;
  double _totalPriceInfant;
  double _totalPrice;
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

    final start = widget.booking?.start ?? DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    final end = widget.booking?.end ?? DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);
    _paxAdult = widget.booking?.paxAdult ?? 0;
    _paxAdult = widget.booking?.paxChild ?? 0;
    _paxAdult = widget.booking?.paxInfant ?? 0;
    _totalPriceAdult = widget.booking?.totalPriceAdult ?? 0.0;
    _totalPriceChild = widget.booking?.totalPriceChild ?? 0;
    _totalPriceInfant = widget.booking?.totalPriceInfant ?? 0;
    _totalPrice = widget.booking?.totalPrice ?? 0;
    _bookingStatus = widget.booking?.bookingStatus ?? 'Not Approved Yet';
    _bookingStatus = widget.booking?.bookingStatus ?? 'Not Approved Yet';
    _tourStatusDescription = widget.booking?.tourStatusDescription ??
        'Please make your payment first';
    _accNo = widget.booking?.accNo ?? 70211683205724;
    _accBank = widget.booking?.accBank ?? 'CIMB';

  }

  Booking _bookingFromState() {
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
        _startTime.hour, _startTime.minute);
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
        _endTime.hour, _endTime.minute);
    final paxA= widget.booking?.paxAdult ?? _paxAdult;
    final paxC= widget.booking?.paxChild ?? _paxChild;
    final paxI= widget.booking?.paxInfant ?? _paxInfant;
//    final accNumber= widget.booking?.accNo ?? _accNo;


    final id = widget.booking?.bookingId ?? documentIdFromCurrentDate();
    return Booking(
      bookingId: id,
      tourPackageId: widget.tourPackage.tourPackageId,
      tourName: widget.tourPackage.tourName,
      start: start,
      end: end,
      paxAdult: paxA,
      paxChild: paxC,
      paxInfant: paxI,
      totalPriceAdult: _totalPriceAdult,
      totalPriceChild: _totalPriceChild,
      totalPriceInfant: _totalPriceInfant,
      totalPrice: _totalPrice,
      bookingStatus: _bookingStatus,
      tourStatusDescription: _tourStatusDescription,
      accBank: _accBank,
      accNo: _accNo,
//      comment: _comment,
    );
  }
//  Future<void> updateOneField = Firestore.instance
//      .collection('users/uid/bookings')
//      .document('2020-06-07T08:42:11.365771')
//      .updateData(
//      {
//        "bookingStatus": "Approved"
//      });
  Future<void> _setBookingAndDismiss(BuildContext context) async {
    try {
      final booking = _bookingFromState();

      await widget.database.setBooking(booking);

      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingOperatorDetail(),
            settings: RouteSettings(
              arguments: booking,
            )),
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

//  void pay(){
//    setState(() {
//    final currentBooking = _bookingFromState();
//    if(widget.tourPackage.tourAdultAmount != 0)
//     _totalAdult = (widget.tourPackage.tourAdultAmount).toDouble() *
//        currentBooking.durationInHours* currentBooking.paxAdult ;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Edit Status'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.booking != null ? 'Update' : 'Submit',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
//            onPressed: () => _setBookingAndDismiss(context),
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
  Widget _buildPayStatusDescription() {
    return DropdownButton(
//      hint: Text('Please choose a bed type'), // Not necessary for Option 1
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
//      hint: Text('Please choose a bed type'), // Not necessary for Option 1
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
    final currentBooking = _bookingFromState();

    _accNo = currentBooking.accNo;
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

  Widget _buildBookingStatus() {
    return DropdownButton(
//      hint: Text('Please choose a bed type'), // Not necessary
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
    );
  }
}
