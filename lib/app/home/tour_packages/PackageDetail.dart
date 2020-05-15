import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/BookingDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/tour_bookings_page.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/plugins/firetop/storage/fire_storage_service.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_list_item.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/date_time_picker.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/format.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
//final String image1 = "gs://setiu-wetlands-tour-booking.appspot.com/tourActivities/IMG-20200427-WA0010.jpg";
//String image = image1;

class PackageDetail extends StatelessWidget {
  const PackageDetail(
      {@required this.database, @required this.tourPackage, });
  final TourPackage tourPackage;

  final Database database;

  String get image => null;
  static Future<void> show(
      {BuildContext context,
      Database database,
      TourPackage tourPackage,
      }) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(

        builder: (context) => PackageDetail(
            database: database, tourPackage: tourPackage),
        fullscreenDialog: true,
      ),
    );
  }

//  State<StatefulWidget> createState() => _PackageDetailState();

//class _PackageDetailState extends State<PackageDetail> {
//  String get image => null;
//  DateTime _startDate;
//  TimeOfDay _startTime;
//  DateTime _endDate;
//  TimeOfDay _endTime;
////  String _comment;
//  int _paxAdult = 0;
//  int _paxChild = 0;
//  int _paxInfant = 0;
//  void initState() {
//    super.initState();
//    final start = widget.booking?.start ?? DateTime.now();
//    _startDate = DateTime(start.year, start.month, start.day);
//    _startTime = TimeOfDay.fromDateTime(start);
//
//    final end = widget.booking?.end ?? DateTime.now();
//    _endDate = DateTime(end.year, end.month, end.day);
//    _endTime = TimeOfDay.fromDateTime(end);
//
//    _paxAdult = widget.booking?.paxAdult ?? 0;
//    _paxAdult = widget.booking?.paxChild ?? 0;
//    _paxAdult = widget.booking?.paxInfant ?? 0;
//    _comment = widget.booking?.comment ?? '';
//  }

//  Booking _bookingFromState() {
//    final start = DateTime(_startDate.year, _startDate.month, _startDate.day,
//        _startTime.hour, _startTime.minute);
//    final end = DateTime(_endDate.year, _endDate.month, _endDate.day,
//        _endTime.hour, _endTime.minute);
//    final id = widget.booking?.bookingId ?? documentIdFromCurrentDate();
//    return Booking(
//      bookingId: id,
//      tourPackageId: widget.tourPackage.tourPackageId,
//      start: start,
//      end: end,
//
//      paxAdult: _paxAdult,
//      paxChild: _paxChild,
//      paxInfant: _paxInfant,
////      comment: _comment,
//    );
//  }

//  Future<void> _setBookingAndDismiss(BuildContext context) async {
//    try {
//      final booking = _bookingFromState();
//      await widget.database.setBooking(booking);
//      Navigator.of(context).pop();
//    } on PlatformException catch (e) {
//      PlatformExceptionAlertDialog(
//        title: 'Operation failed',
//        exception: e,
//      ).show(context);
//    }
//  }
//
//  void add() {
//    setState(() {
//      _paxAdult++;
//    });
//  }
//
//  void minus() {
//    setState(() {
//      if (_paxAdult != 0) _paxAdult--;
//    });
//  }
//
//  void addm() {
//    setState(() {
//      _paxChild++;
//    });
//  }
//
//  void minusm() {
//    setState(() {
//      if (_paxChild != 0) _paxChild--;
//    });
//  }
//
//  void addo() {
//    setState(() {
//      _paxInfant++;
//    });
//  }
//
//  void minuso() {
//    setState(() {
//      if (_paxInfant != 0) _paxInfant--;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final TourPackage tourPackage = ModalRoute.of(context).settings.arguments;
//
//    return StreamBuilder<TourPackage>(
//        stream: database.tourPackageStream(tourPackageId: tourPackage.tourPackageId),
//        builder: (context, snapshot) {
//          final tourPackage =snapshot.data;
//          final tourName= tourPackage ?.tourName?? '';

    return Scaffold(
        appBar: AppBar(
          title: Text(tourPackage.tourName),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: _getImage(context, image),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done)
                            return Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width / 1.25,
                              child: snapshot.data,
                            );

                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.1,
                                width: MediaQuery.of(context).size.width / 1.25,
                                child: CircularProgressIndicator());

                          return Container();
                        },
                      ),

//              loadButton(context),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 250,
                            child: Text(
                              'General Info',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black54),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            'RM' + (tourPackage.tourAdultAmount).toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),
                      SizedBox(
                        width: 360,
                        child: Text(
                          tourPackage.tourDescription,
//                  textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),

                      const SizedBox(height: 20),
                      _buildContent(context, tourPackage),
                      const SizedBox(height: 50),

//    ButtonTheme(
//
//    minWidth: 325.0,
//
//       child: RaisedButton(
//
////                onPressed: ()  => TourBookingsPage.show(context, tourPackage),//list booking
//       onPressed: () => BookingPage.show(context: context, database: database, tourPackage: tourPackage),
////                onPressed: ()  => BookingDetail(),
////                  onPressed: () => BookingDetail.show(context, tourPackage),
////                onPressed: () => _setBookingAndDismiss(context),
//       color: Colors.lightGreen,
//       child: const Text('BOOK NOW',
//       style: TextStyle(
//       fontSize: 16,
//       )),
//       )),
                    ]))));

                    }



  Widget _buildContent(BuildContext context, TourPackage tourPackage) {
    final database = Provider.of<Database>(context);
//              StreamBuilder<List<Booking>>(
//                stream:database.bookingsStream(tourPackage: tourPackage),
////                  stream:database.bookingsStream(tourPackage: tourPackage),
//                builder: (context, snapshot) {

    return ButtonTheme(
      minWidth: 325.0,
      child: RaisedButton(
//                onPressed: ()  => TourBookingsPage.show(context, tourPackage),//list booking
        onPressed: () =>
            BookingPage.show(context: context,database: database, tourPackage: tourPackage),
//                onPressed: ()  => BookingDetail(),
//                  onPressed: () => BookingDetail.show(context, tourPackage),
//                onPressed: () => _setBookingAndDismiss(context),
        color: Colors.lightGreen,
        child: const Text('BOOK NOW',
            style: TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }


  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return m;
  }
}

//    );

//
//  Widget _buildStartDate() {
//    return DateTimePicker(
//      labelText: 'Start',
//      selectedDate: _startDate,
//      selectedTime: _startTime,
//      selectDate: (date) => setState(() => _startDate = date),
//      selectTime: (time) => setState(() => _startTime = time),
//    );
//  }
//
//  Widget _buildEndDate() {
//    return DateTimePicker(
//      labelText: 'End',
//      selectedDate: _endDate,
//      selectedTime: _endTime,
//      selectDate: (date) => setState(() => _endDate = date),
//      selectTime: (time) => setState(() => _endTime = time),
//    );
//  }
//
//  Widget _buildDuration() {
//    final currentBooking = _bookingFromState();
//    final durationFormatted = Format.hours(currentBooking.durationInHours);
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.end,
//      children: <Widget>[
//        Text(
//          'Duration: $durationFormatted',
//          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
//          maxLines: 1,
//          overflow: TextOverflow.ellipsis,
//        ),
//      ],
//    );
//  }
//
//  Widget _buildAdult() {
//    return TextField(
//      keyboardType: TextInputType.numberWithOptions(
//        signed: false,
//        decimal: false,
//      ),
//      maxLength: 20,
//      controller: TextEditingController(text: (_paxAdult).toString()),
//      decoration: InputDecoration(
//        labelText: 'Adult',
//        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
//      ),
//      style: TextStyle(fontSize: 20.0, color: Colors.black),
//      maxLines: null,
//      onChanged: (paxAdult) => _paxAdult = int.tryParse(paxAdult) ??0,
////      onChanged: (comment) => _comment = comment,
//    );
//  }

//  Widget _buildComment() {
//    return TextField(
//      keyboardType: TextInputType.text,
//      maxLength: 50,
//      controller: TextEditingController(text: _comment),
//      decoration: InputDecoration(
//        labelText: 'Comment',
//        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
//      ),
//      style: TextStyle(fontSize: 20.0, color: Colors.black),
//      maxLines: null,
//      onChanged: (comment) => _comment = comment,
//    );
//  }
//}
