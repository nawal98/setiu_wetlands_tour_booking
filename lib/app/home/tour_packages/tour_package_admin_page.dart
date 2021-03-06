 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/edit_tour_package_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';


    class TourPackageAdmin extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text("List of Tour Package"),
    actions: <Widget>[
    IconButton(
    icon: Icon(Icons.add, color: Colors.black),
    onPressed: () => EditTourPackagePage.show(
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
    return StreamBuilder<List<TourPackage>>(
      stream: database.tourPackagesStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<TourPackage>(
          snapshot: snapshot,
          itemBuilder: (context, tourPackage) => Dismissible(
            key: Key('tourPackage-${tourPackage.tourPackageId}'),
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
                        "Are you sure you wish to delete this tour package?"),
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
            onDismissed: (direction) => _delete(context, tourPackage),
            child: TourPackageListTile(
              tourPackage: tourPackage,
              onTap: () =>
                  EditTourPackagePage.show(context, tourPackage: tourPackage),
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, TourPackage tourPackage) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteTourPackage(tourPackage);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
