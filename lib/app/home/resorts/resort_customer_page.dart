import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/resorts/resort_customer_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
class ResortCustomer extends StatelessWidget {
  const ResortCustomer({@required this.database, @required this.resort});
  final Database database;
  final Resort resort;
  static Future<void> show(BuildContext context, Resort resort) async {
    final Database database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,//back button
        builder: (context) =>
            ResortCustomer(database: database, resort: resort),
      ),
    );
  }
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
              ),
            ));
      },
    );
  }
}