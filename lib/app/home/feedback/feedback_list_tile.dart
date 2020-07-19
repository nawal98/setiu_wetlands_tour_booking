import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/feedbackDetail.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/RoomDetail.dart';
import 'package:setiuwetlandstourbooking/app/models/feedback.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';

class FeedbackListItem extends StatelessWidget {
  const FeedbackListItem({
    @required this.feedback,
    @required this.tourPackage,
    @required this.onTap,
  });

  final Feedbacks feedback;
  final TourPackage tourPackage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedbackDetail(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: feedback,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[

              _buildContents(context),


          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {


    return Flexible(
        child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
        Expanded(
        child:Text(feedback.feedbackDescription, overflow: TextOverflow.fade,
        maxLines: 3,
        softWrap: false, style: TextStyle(fontSize: 18.0)),

    )],
        ),

      ],
    ));
  }
}

class DismissibleFeedbackListItem extends StatelessWidget {
  const DismissibleFeedbackListItem({
    this.key,
    this.feedback,
    this.tourPackage,
    this.onDismissed,
    this.onTap,
  });

  final Key key;
  final Feedbacks feedback;
  final TourPackage tourPackage;
  final VoidCallback onDismissed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: key,
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Delete"),
              content: const Text("Are you sure you wish to delete this room?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => onDismissed(),
      child: FeedbackListItem(
        feedback: feedback,
        tourPackage: tourPackage,
        onTap: onTap,
      ),
    );
  }
}
