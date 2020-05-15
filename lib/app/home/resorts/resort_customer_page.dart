import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_customer_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_activities/tour_activity_customer_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/edit_tour_package_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/empty_content.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_Package_customer_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/tour_package_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/app/home/navigationDrawer.dart';
import 'package:setiuwetlandstourbooking/app/home/pageRoute.dart';
import 'package:setiuwetlandstourbooking/app/home/resort_rooms/resort_rooms_page.dart';
class ResortCustomer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resorts"),
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
              background: Container(),
              child: ResortCustomerListTile(
                resort: resort,

//                    onTap: () =>
//                        EditTourPackagePage.show(context, tourPackage: tourPackage),
              ),
            ));
      },
    );
  }
}