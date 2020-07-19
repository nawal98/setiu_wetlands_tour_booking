import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_booking/tour_bookings_page.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class PackageOperatorDetail extends StatelessWidget {
  const PackageOperatorDetail(
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

        builder: (context) => PackageOperatorDetail(
            database: database, tourPackage: tourPackage),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TourPackage tourPackage = ModalRoute.of(context).settings.arguments;

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
//                      FutureBuilder(
//                        future: _getImage(context, image),
//                        builder: (context, snapshot) {
//                          if (snapshot.connectionState == ConnectionState.done)
//                            return Container(
//                              height: MediaQuery.of(context).size.height / 2.5,
//                              width: MediaQuery.of(context).size.width / 1.25,
//                              child: snapshot.data,
//                            );
//
//                          if (snapshot.connectionState ==
//                              ConnectionState.waiting)
//                            return Container(
//                                height:
//                                MediaQuery.of(context).size.height / 1.1,
//                                width: MediaQuery.of(context).size.width / 1.25,
//                                child: CircularProgressIndicator());
//
//                          return Container();
//                        },
//                      ),

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
                            (tourPackage.tourDiscount).toString() +'% Discount',
                            style: TextStyle(
                              fontSize: 13.0,
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
                      SizedBox(height: 18),
                      Row(children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.person, color: Colors.lightGreen),
                        ),
                        SizedBox(
                          width: 260,
                          child:
                          Text('RM'+tourPackage.tourAdultAmount.toString()+' /adult', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                        ), ]), SizedBox(height: 15),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.child_care, color: Colors.lightGreen),
                        ),

                        Text('RM'+tourPackage.tourChildAmount.toString()+' /child', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),
                      SizedBox(height: 15),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.child_friendly, color: Colors.lightGreen),
                        ),

                        Text('RM'+tourPackage.tourInfantAmount.toString()+' /infant', style: TextStyle(fontSize: 16.0, color: Colors.black54)),
                      ]),
                      const SizedBox(height: 20),
                      _buildContent(context, tourPackage),
                      const SizedBox(height: 50),

                    ]))));

  }



  Widget _buildContent(BuildContext context, TourPackage tourPackage) {
    final Database database = Provider.of<Database>(context);
//              StreamBuilder<List<Booking>>(
//                  stream:database.bookingsStream(tourPackage: tourPackage),
//
//    builder: (context, snapshot) {

    return ButtonTheme(
      minWidth: 325.0,
      child: RaisedButton(
                onPressed: ()  => TourBookingsPage.show(context, tourPackage),//list package
        color: Colors.lightGreen,
        child: const Text('BOOK NOW',
            style: TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }
  }


