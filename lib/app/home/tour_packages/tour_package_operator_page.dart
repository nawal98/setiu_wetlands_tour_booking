import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_operator_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';


class TourPackageOperator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour Packages"),
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
              background: Container(),
              child: TourPackageOperatorListTile(
                tourPackage: tourPackage,
              ),
            ));
      },
    );
  }
}
