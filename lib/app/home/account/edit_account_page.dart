import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/models/user_info.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/services.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({
    Key key,
    @required this.database,
    this.userInfo,
  }) : super(key: key);
  final Database database;
  final UserInfo userInfo;
  static Future<void> show(BuildContext context,
      {UserInfo userInfo, Database database}) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) => EditAccountPage(database: database, userInfo: userInfo),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _userName;
  String _email;
  String _userGender;
  int _userPhone;

  @override
  void initState() {
    super.initState();
    if (widget.userInfo != null) {
      _userName = widget.userInfo.userName;
      _email = widget.userInfo.email;
      _userGender = widget.userInfo.userGender;
      _userPhone = widget.userInfo.userPhone;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    //TODO : validate and save form
    if (_validateAndSaveForm()) {
      try {
        final userInfos = await widget.database.userInfosStream().first;
        final allUsersNames = userInfos.map((userInfo) => userInfo.userName).toList();
        if (widget.userInfo != null) {
          allUsersNames.remove(widget.userInfo.userName);
        }
        if (allUsersNames.contains(_userName)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different user name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final userId = widget.userInfo?.userId ?? documentIdFromCurrentDate();
          final userInfo = UserInfo(
            userId: userId ,
            userName: _userName,
            email: _email,
            userGender: _userGender,
            userPhone: _userPhone,
          );
          await widget.database.setUserInfo(userInfo);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.userInfo == null ? 'New Account' : 'Edit Account'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            onPressed: _submit,
          )
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding : const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'User Name'),
        initialValue: _userName,
        onSaved: (value) => _userName = value,
        validator: (value) => value.isNotEmpty ? null : 'Name cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        initialValue: _email,
        onSaved: (value) => _email = value,
        validator: (value) => value.isNotEmpty ? null : 'Email cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Gender'),
        initialValue: _userGender,
        onSaved: (value) => _userGender = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Gender cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Phone No.'),
        initialValue: _userPhone != null ? '$_userPhone' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _userPhone = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
