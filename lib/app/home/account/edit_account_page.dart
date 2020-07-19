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
  String _lastName;
  String _firstName;
  String _email;
  int _userPhone;
  List<String> _gender = ['Male','Female']; // Option 2
  String _selectedGender; // Option 2
  @override
  void initState() {
    super.initState();
    if (widget.userInfo != null) {
      _firstName = widget.userInfo.firstName;
      _lastName = widget.userInfo.lastName;
      _selectedGender = widget.userInfo.userGender;
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
        final allUsersNames = userInfos.map((userInfo) => userInfo.firstName).toList();
        if (widget.userInfo != null) {
          allUsersNames.remove(widget.userInfo.firstName);
        }if (allUsersNames.contains(_firstName)) {
          PlatformAlertDialog(
            title: 'Tour Package Name Already Used',
            content: 'Please choose a different tour package name',
            defaultActionText: 'OK',
          ).show(context);
        }else {
          final userId = widget.userInfo?.userId ?? documentIdFromCurrentDate();
          final userInfo = UserInfo(
            userId: userId ,
            firstName: _firstName,
            lastName: _lastName,
            userGender: _selectedGender,
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
        title: Text(widget.userInfo == null ? 'Account' : 'Account'),
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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        SizedBox(height: 12.0),
          _buildForm(),
            SizedBox(height: 12.0),
            Row(children: <Widget>[
              SizedBox(
                width: 120,
                child: Text(
                  'Gender',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15.0,color: Colors.black54),
                ),
              ),
              SizedBox(
                width: 200,
                child:     DropdownButton(
                  hint: Text('Please choose a gender'), // Not necessary for Option 1
                  value: _selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  items: _gender.map((gen) {
                    return DropdownMenuItem(
                      child: new Text(gen),
                      value: gen,
                    );
                  }).toList(),
                ),
              ),
            ]),

          ] ),
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
        decoration: InputDecoration(labelText: 'First Name'),
        initialValue: _firstName,
        onSaved: (value) => _firstName = value,
        validator: (value) => value.isNotEmpty ? null : 'First Name cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Last Name'),
        initialValue: _lastName,
        onSaved: (value) => _lastName = value,
        validator: (value) => value.isNotEmpty ? null : 'Last Name cant\'t be empty',
      ),

      TextFormField(
        decoration: InputDecoration(labelText: 'Phone No.'),
        initialValue: _userPhone != null ? '$_userPhone' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        validator: (value) => value.isNotEmpty ? null : 'Phone Number cant\'t be empty',
        onSaved: (value) => _userPhone = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
