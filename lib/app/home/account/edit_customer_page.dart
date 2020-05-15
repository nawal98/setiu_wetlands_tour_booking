//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:setiuwetlandstourbooking/app/models/user_info.dart';
//import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
//import 'package:setiuwetlandstourbooking/services/database.dart';
//import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
//import 'package:flutter/services.dart';
//
//class EditCustomerPage extends StatefulWidget {
//  const EditCustomerPage({
//    Key key,
//    @required this.database,
//    this.userInfo,
//  }) : super(key: key);
//  final Database database;
//  final UserInfo userInfo;
//  static Future<void> show(BuildContext context,
//      {UserInfo userInfo, Database database}) async {
//    final database = Provider.of<Database>(context);
//    await Navigator.of(context).push(
//      CupertinoPageRoute(
//        builder: (context) =>
//            EditCustomerPage(database: database, userInfo: userInfo),
//        fullscreenDialog: true,
//      ),
//    );
//  }
//
//  @override
//  _EditCustomerPageState createState() => _EditCustomerPageState();
//}
//
//class _EditCustomerPageState extends State<EditCustomerPage> {
//  final _formKey = GlobalKey<FormState>();
//  String _userName;
//  String _email;
//  String _userGender;
//  int _userPhone;
//
//  @override
//  void initState() {
//    super.initState();
//    if (widget.userInfo != null) {
//      _userName = widget.userInfo.userName;
//      _email = widget.userInfo.email;
//      _userGender = widget.userInfo.userGender;
//      _userPhone = widget.userInfo.userPhone;
//    }
//  }
//
//  bool _validateAndSaveForm() {
//    final form = _formKey.currentState;
//    if (form.validate()) {
//      form.save();
//      return true;
//    }
//    return false;
//  }
//
//  Future<void> _submit() async {
//    //TODO : validate and save form
//    if (_validateAndSaveForm()) {
//      try {
//        final userInfos = await widget.database.userInfosStream().first;
//        final allUsersNames =
//            userInfos.map((userInfo) => userInfo.email).toList();
//        if (widget.userInfo != null) {
//          allUsersNames.remove(widget.userInfo.email);
//        }
//        if (allUsersNames.contains(_email)) {
//          PlatformAlertDialog(
//            title: 'Name already used',
//            content: 'Please choose a different tour activity name',
//            defaultActionText: 'OK',
//          ).show(context);
//        } else {
//          final userId =
//              widget.userInfo?.userId ?? documentIdFromCurrentDate();
//          final userInfo = userInfo(
//            userId: userId,
//            userName: _userName,
//            email: _email,
//            userGender: _userGender,
//            userPhone: _userPhone,
//          );
//          await widget.database.setUserInfo(userInfo);
//          Navigator.of(context).pop();
//        }
//      } on PlatformException catch (e) {
//        PlatformExceptionAlertDialog(
//          title: 'Operation failed',
//          exception: e,
//        ).show(context);
//      }
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 2.0,
//        title: Text(widget.userInfo == null
//            ? 'New Customer'
//            : 'Edit Customer'),
//        actions: <Widget>[
//          FlatButton(
//            child: Text(
//              'Save',
//              style: TextStyle(fontSize: 18, color: Colors.black87),
//            ),
//            onPressed: _submit,
//          )
//        ],
//      ),
//      body: _buildContents(),
//      backgroundColor: Colors.grey[200],
//    );
//  }
//
//  Widget _buildContents() {
//    return SingleChildScrollView(
//      child: Padding(
//        padding: const EdgeInsets.all(16.0),
//        child: Card(
//          child: Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: _buildForm(),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildForm() {
//    return Form(
//      key: _formKey,
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: _buildFormChildren(),
//      ),
//    );
//  }
//
//  List<Widget> _buildFormChildren() {
//    return [
//      TextFormField(
//        decoration: InputDecoration(labelText: 'Tour Activity Name'),
//        initialValue: _activityName,
//        onSaved: (value) => _activityName = value,
//        validator: (value) => value.isNotEmpty ? null : 'Name cant\'t be empty',
//      ),
//      TextFormField(
//        decoration: InputDecoration(labelText: 'Description'),
//        initialValue: _activityDescription,
//        onSaved: (value) => _activityDescription = value,
//        validator: (value) =>
//            value.isNotEmpty ? null : 'Description cant\'t be empty',
//      ),
//    ];
//  }
//}
