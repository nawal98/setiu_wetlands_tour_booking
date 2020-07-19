import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/tour_feedback_operator.dart';
import 'package:setiuwetlandstourbooking/app/home/feedback/tour_package_feedback_operator_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/feedback.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';


class FeedbackOperator extends StatelessWidget {
  const FeedbackOperator({@required this.database,
    @required this.tourPackage, @required this.feedback,

  });
  final Database database;
  final TourPackage tourPackage;
  final Feedbacks feedback;

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Feedbacks"),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),

      body: _buildContents(context,tourPackage,feedback),

    );
  }
  Widget _buildContents(BuildContext context, TourPackage tourPackage,Feedbacks feedback) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<TourPackage>>(
      stream: database.tourPackagesStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<TourPackage>(
          snapshot: snapshot,
          itemBuilder: (context, tourPackage) => Dismissible(
            key: Key('tourPackage-${tourPackage.tourPackageId}'),
            background: Container(),
            child: TourPackageFeedbackOperatorListTile(
              tourPackage: tourPackage,

              onTap: () =>  TourFeedbackOperator.show(context,tourPackage),

            ),
          ),
        );
      },
    );
  }

}
