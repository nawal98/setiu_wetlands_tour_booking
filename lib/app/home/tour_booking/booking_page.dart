import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/room_admin_list_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/BookingDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/date_time_picker.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/tour_bookings_page.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/room.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class BookingPage extends StatefulWidget {
  const BookingPage(
      {@required this.database,
      @required this.tourPackage,
      @required this.room,
      this.booking});
  final TourPackage tourPackage;
  final Booking booking;
  final Database database;
  final Room room;

  static Future<void> show(
      {BuildContext context,
      Database database,
      TourPackage tourPackage,
      Room room,
      Booking booking}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => BookingPage(
          database: database,
          tourPackage: tourPackage,
          booking: booking,
          room: room,
        ),
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
  List<String> _bookingStatusOption = ['Not Approved Yet', 'Booking Approved'];
  String _bookingStatus;
  List<String> _tourStatusDescriptionOption = [
    'Please make your payment first',
    'Please completed your Profile information',
    'Payment received'
  ];
  String _tourStatusDescription;
  int _paxAdult;
  int _paxChild = 0;
  int _paxInfant = 0;
  double _totalPriceAdult;
  double _totalPriceChild;
  double _totalPriceInfant;
  double _totalPrice;
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
    _tourStatusDescription = widget.booking?.tourStatusDescription ??
        'Please make your payment first';
    _accNo = widget.booking?.accNo ?? 70211683205724;
    _accBank = widget.booking?.accNo ?? 'CIMB';
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
      tourName: widget.tourPackage.tourName,
      start: start,
      end: end,
      paxAdult: _paxAdult,
      paxChild: _paxChild,
      paxInfant: _paxInfant,
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

  Future<void> _setBookingAndDismiss(BuildContext context) async {
    try {
      final booking = _bookingFromState();
      await widget.database.setBooking(booking);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingDetail(),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(''),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.booking != null ? 'Update' : 'Submit',
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
              SizedBox(height: 12),
              SizedBox(
                width: 300,
                child: Text(
                  'Total Price ',
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
                  Text('Total Adult Price',
                      style: new TextStyle(fontSize: 15.0)),
                  SizedBox(width: 15.0),
                  Expanded(child: Container()),
                  _buildPayAdult(),
                ],
              ),
              Row(children: <Widget>[
                Text('Total Child Price', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildPayChild()
              ]),
              Row(children: <Widget>[
                Text('Total Infant Price',
                    style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildPayInfant()
              ]),

              Row(children: <Widget>[
                Text('Discount', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                Text('-' + widget.tourPackage.tourDiscount.toString() + '%',
                    style: new TextStyle(fontSize: 18.0)),
              ]),

              SizedBox(height: 8.0),
              Row(children: <Widget>[
                Text('Total', style: new TextStyle(fontSize: 15.0)),
                Expanded(child: Container()),
                _buildPay(),
              ]),
              SizedBox(height: 16.0),
              Row(children: <Widget>[
            _buildPayStatusDescription(),
                Text(' at:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black54),),

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
                SizedBox(
                  width: 120,
                  child: Text(
                    'Reference',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15.0,color: Colors.black87),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text( 'SetiuBooking'+ widget.tourPackage.tourName,
                      style: TextStyle(fontSize: 15.0, color: Colors.black87)),
                ),


              ]),
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

  Widget _buildPayStatus() {
    final currentBooking = _bookingFromState();

    _bookingStatus = currentBooking.bookingStatus;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_bookingStatus',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.red),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayAdult() {
    final currentBooking = _bookingFromState();

    _totalPriceAdult = (widget.tourPackage.tourAdultAmount).toDouble() *
        currentBooking.durationInHours *
        currentBooking.paxAdult;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalPriceAdult' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayChild() {
    final currentBooking = _bookingFromState();
    _totalPriceChild = (widget.tourPackage.tourChildAmount).toDouble() *
        currentBooking.durationInHours *
        currentBooking.paxChild;
//    final payFormatted = Format.currency(currentBooking.pay);
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalPriceChild' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayInfant() {
    final currentBooking = _bookingFromState();
    _totalPriceInfant = (widget.tourPackage.tourInfantAmount).toDouble() *
        currentBooking.durationInHours *
        currentBooking.paxInfant;
//    final payFormatted = Format.currency(currentBooking.pay);
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalPriceInfant' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPay() {
    _totalPrice = (100 - (widget.tourPackage.tourDiscount)) /
        100 *
        (_totalPriceAdult + _totalPriceChild + _totalPriceInfant);
//    final payFormatted = Format.currency(currentBooking.pay);
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        'RM$_totalPrice' + '0',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildPayStatusDescription() {
    final currentBooking = _bookingFromState();

    _tourStatusDescription = currentBooking.tourStatusDescription;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_tourStatusDescription',
        style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18.0, color: Colors.black54, ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildAccBank() {
    final currentBooking = _bookingFromState();

    _accBank = currentBooking.accBank;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_accBank',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w500, ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }

  Widget _buildAccNo() {
    final currentBooking = _bookingFromState();

    _accNo = currentBooking.accNo;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Text(
        '$_accNo',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w500, ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ]);
  }
}
