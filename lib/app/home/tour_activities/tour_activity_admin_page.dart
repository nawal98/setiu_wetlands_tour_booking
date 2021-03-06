import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/edit_tour_activity_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';


class TourActivityAdmin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Tour Activities"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () => EditTourActivityPage.show(
              context, database: Provider.of<Database>(context),
            ),
          ),
        ],
      ),

      body: _buildContents(context),

    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<TourActivity>>(
      stream: database.tourActivitiesStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<TourActivity>(
          snapshot: snapshot,
          itemBuilder: (context, tourActivity) => Dismissible(
            key: Key('tourActivity-${tourActivity.tourActivityId}'),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Delete"),
                    content: const Text(
                        "Are you sure you wish to delete this tour activity?"),
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
            onDismissed: (direction) => _delete(context, tourActivity),
            child: TourActivityListTile(
              tourActivity: tourActivity,
              onTap: () =>
                  EditTourActivityPage.show(context, tourActivity: tourActivity),
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, TourActivity tourActivity) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteTourActivity(tourActivity);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
