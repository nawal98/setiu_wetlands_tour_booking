import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/models/feedback.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';


class EditFeedback extends StatefulWidget {
  const EditFeedback({@required this.database, @required this.feedback, this.tourPackage, this.userInfo});
  final TourPackage tourPackage;
  final Feedbacks feedback;
  final Database database;
  final UserInfo userInfo;

  static Future<void> show(
      {BuildContext context,
        Database database,
        TourPackage tourPackage,
        Feedbacks feedback}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) =>
            EditFeedback(database: database, tourPackage: tourPackage, feedback: feedback),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _EditFeedbackState();
}

class _EditFeedbackState extends State<EditFeedback> {



  String _feedbackDescription;


  @override
  void initState() {
    super.initState();

    _feedbackDescription = widget.feedback?.feedbackDescription ?? '';

  }


  Feedbacks _feedbackFromState() {
    final id = widget.feedback?.feedbackId ?? documentIdFromCurrentDate();
    return Feedbacks(
      feedbackId: id,
      tourPackageId: widget.tourPackage.tourPackageId,
      feedbackDescription: _feedbackDescription,
      tourName: widget.tourPackage.tourName,
//      userId: widget.userInfo.userId,

    );
  }

  Future<void> _setFeedbackAndDismiss(BuildContext context) async {
    try {
      final feedback = _feedbackFromState();
      await widget.database.setFeedback(feedback);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }


  @override
  Widget build(BuildContext context) {
//    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          title: Text(widget.tourPackage.tourName),
          actions: <Widget>[
            FlatButton(
              child: Text(
                widget.feedback != null ? 'Update' : 'Submit',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              onPressed: () => _setFeedbackAndDismiss(context),
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
                    width: 250,
                    child: Text(
                      'Feedback',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: 12.0),
//                  _buildUserInfo(user),
                  _buildFeedbackDescription(),
                  SizedBox(height: 12),
                ]),
          ),
        ));
  }



  Widget _buildFeedbackDescription() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 300,
      controller: TextEditingController(text: _feedbackDescription),
      decoration: InputDecoration(
        labelText: 'Feedback Description',
        labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (feedbackDescription) => _feedbackDescription = feedbackDescription,
    );
  }



}
