import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/resort_rooms_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/plugins/firetop/storage/fire_storage_service.dart';
import 'package:intl/intl.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:provider/provider.dart';
class BookingDetail extends StatelessWidget {
  const BookingDetail({@required this.database, @required this.tourPackage,@required this.booking});
  final Database database;
  final TourPackage tourPackage;
  final Booking booking;
  String get image => null;

  @override
  Widget build(BuildContext context) {
    final Booking booking = ModalRoute.of(context).settings.arguments;
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
                          Text((booking.paxAdult).toString(),
//                              (DateFormat().format(booking.start),

                            style: TextStyle(
                              fontSize: 15.0,
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
                          (booking.paxAdult).toString(),
//                  textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                    ]))));
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
