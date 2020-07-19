import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/feedback_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/models/feedback.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:setiuwetlandstourbooking/app/home/tour_booking/booking_page.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class PackageDetail extends StatelessWidget {
  const PackageDetail(
      {@required this.database, @required this.tourPackage,@required this.feedback, });
  final TourPackage tourPackage;
final Feedbacks feedback;
  final Database database;

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
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            child: Text(
                              'General Info',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.green[900]),
                            ),
                          ),
                          Expanded(child: Container()),
                          _buildReview(context,tourPackage,feedback),
                        ],
                      ),

                      SizedBox(height: 12),
                      SizedBox(
                        width: 360,
                        child: Text(
                          tourPackage.tourDescription,

                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Price',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.green[900]),
                            ),
                          ),
                          Expanded(child: Container()),
                           Text(
                              (tourPackage.tourDiscount).toString() +'% Discount',

                              style:
                              TextStyle(fontSize: 15.0, color: Colors.green[700], fontWeight: FontWeight.bold),
                            ),

                        ],
                      ),      SizedBox(height: 18),
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

    return ButtonTheme(
      minWidth: 325.0,
      child: RaisedButton(

        onPressed: () =>
            BookingPage.show(context: context,database: database, tourPackage: tourPackage),
        color: Colors.lightGreen,
        child: const Text('BOOK NOW',
            style: TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }

  Widget _buildReview(BuildContext context, TourPackage tourPackage,Feedbacks feedback) {
    final Database database = Provider.of<Database>(context);

    return ButtonTheme(
      minWidth: 100.0,
      child: RaisedButton(
        onPressed: () =>
            TourFeedback.show(context, tourPackage, database, feedback),

        color: Colors.lightGreen,
        child: const Text('See Review',
            style: TextStyle(
              fontSize: 16,
            )),
      ),
    );
  }



}
