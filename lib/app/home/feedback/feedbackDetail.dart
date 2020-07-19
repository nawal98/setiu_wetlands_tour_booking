import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/app/models/booking.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/app/models/feedback.dart';
class FeedbackDetail extends StatefulWidget {

  const FeedbackDetail(
      {@required this.database, @required this.feedback, this.tourPackage});
  final Feedbacks feedback;
  final TourPackage tourPackage;
  final Database database;

  State<StatefulWidget> createState() => _FeedbackDetailState();
}
class _FeedbackDetailState extends State<FeedbackDetail> {


  @override
  Widget build(BuildContext context) {
    final Feedbacks feedback = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Feedback'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 20),
                      SizedBox(
                        width: 360,
                        child: Text(feedback.feedbackDescription,
                          style:
                          TextStyle(fontSize: 18.0, color: Colors.black54),
                        ),
                      ),

                    ]))));
  }

}