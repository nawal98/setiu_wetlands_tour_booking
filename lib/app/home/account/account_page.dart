import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/home/account/account_list_tile.dart';
import 'package:setiuwetlandstourbooking/app/home/tab_item.dart';
import 'package:setiuwetlandstourbooking/app/home/tour_packages/list_item_builder.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';
import 'package:setiuwetlandstourbooking/common_widget/avatar.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/app/home/account/edit_account_page.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'edit_account_page.dart';

class AccountPage extends StatelessWidget {


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
    final user = Provider.of<User>(context);
    final database = Provider.of<Database>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Account"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: () => EditAccountPage.show(
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(140),
            child: _buildUserInfo(user),
          ),
        ),

        body: _buildContents(context),

        );
  }

  Widget _buildUserInfo( User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoUrl,
          radius: 50,
        ),
//        SizedBox(height: 8),
//        if (user.displayName != null)
//          Text(
//            user.displayName,
//            style: TextStyle(color: Colors.black),
//          ),
        SizedBox(height: 8),
        if (user.email != null)
          Text(
            user.email,
            style: TextStyle(color: Colors.black),
          ),

      ],
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
            onDismissed: (direction) => _delete(context, userInfo),
            child: AccountListTile(
              userInfo: userInfo,
              onTap: () => EditAccountPage.show(context, userInfo: userInfo),
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
