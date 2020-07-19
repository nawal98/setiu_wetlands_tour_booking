import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/edit_feedback_page.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/feedback_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/feedback.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';

class TourFeedbackOperator extends StatelessWidget {
  const TourFeedbackOperator({@required this.database, @required this.tourPackage});
  final Database database;
  final TourPackage tourPackage;

  static Future<void> show(BuildContext context, TourPackage tourPackage) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,//back button
        builder: (context) =>
            TourFeedbackOperator(database: database, tourPackage: tourPackage),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TourPackage>(
        stream: database.tourPackageStream(tourPackageId: tourPackage.tourPackageId),
        builder: (context, snapshot) {
          final tourPackage =snapshot.data;
          final tourName= tourPackage ?.tourName?? '';
          return Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              title: Text(tourName),
              centerTitle: true,

            ),
            body: _buildContent(context, tourPackage),
          );
        }
    );
  }

  Widget _buildContent(BuildContext context, TourPackage tourPackage) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Feedbacks>>(
      stream: database.feedbacksstream(tourPackage: tourPackage),
      builder: (context, snapshot) {
        return ListItemBuilder<Feedbacks>(
          snapshot: snapshot,
          itemBuilder: (context, feedback) {
            return DismissibleFeedbackListItem(
              key: Key('feedback-${feedback.feedbackId}'),
              feedback: feedback,
              tourPackage: tourPackage,
//              onDismissed: () => _deleteFeedback(context, feedback),
              onTap: () => EditFeedback.show(
                context: context,
                database: database,
                tourPackage: tourPackage,
                feedback: feedback,
              ),
            );
          },
        );
      },
    );
  }

}
