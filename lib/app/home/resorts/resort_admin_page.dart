import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/resort_rooms_page.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/edit_resort_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/empty_content.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ResortAdmin extends StatelessWidget {


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
        title: Text("List of Resorts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () => EditResortPage.show(
              context,
              database: Provider.of<Database>(context),
            ),
          ),
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

      body: _buildContents(context),

    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Resort>>(
      stream: database.resortsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Resort>(
          snapshot: snapshot,
          itemBuilder: (context, resort) => Dismissible(
            key: Key('resort-${resort.resortId}'),
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
                        "Are you sure you wish to delete this resort?"),
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
            onDismissed: (direction) => _delete(context, resort),
            child: ResortListTile(
              resort: resort,
              onTap: () => ResortRoomsPage.show(context, resort),
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, Resort resort) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteResort(resort);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
