import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/home/account/edit_customer_page.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/empty_content.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_list_tile_operator.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';

class AccountPageOperator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Customers"),
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.add, color: Colors.black),
//            onPressed: () => EditCustomerPage.show(
//              context, database: Provider.of<Database>(context),
//            ),
//          ),
        ],
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<UserInfo>>(
      stream: database.userInfosStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<UserInfo>(
          snapshot: snapshot,
          itemBuilder: (context, userInfo) => Dismissible(
            key: Key('userInfo-${userInfo.userId}'),
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
                        "Are you sure you wish to delete this customer?"),
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
            onDismissed: (direction) => _delete(context, userInfo),
            child: AccountListTileOperator(
              userInfo: userInfo,
//              onTap: () =>
//                  EditCustomerPage.show(context, userInfo: userInfo),
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, UserInfo userInfo) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteAccount(userInfo);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}