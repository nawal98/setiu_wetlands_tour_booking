import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/models/resort.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/services.dart';

class EditResortPage extends StatefulWidget {
  const EditResortPage({
    Key key,
    @required this.database,
    this.resort,
  }) : super(key: key);
  final Database database;
  final Resort resort;
  static Future<void> show(
    BuildContext context, {
    Database database,
    Resort resort,
  }) async {
    await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) =>
            EditResortPage(database: database, resort: resort),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditResortPageState createState() => _EditResortPageState();
}

class _EditResortPageState extends State<EditResortPage> {
  final _formKey = GlobalKey<FormState>();

  String _resortName;
  String _resortDescription;
  String _resortAddress;
//  int _resortTel;
  String _resortTel;
  String _resortType;

  @override
  void initState() {
    super.initState();
    if (widget.resort != null) {
      _resortName = widget.resort.resortName;
      _resortDescription = widget.resort.resortDescription;
      _resortAddress = widget.resort.resortAddress;
      _resortTel = widget.resort.resortTel;
      _resortType = widget.resort.resortType;

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
        final resorts = await widget.database.resortsStream().first;
        final allResortsNames =
            resorts.map((resort) => resort.resortName).toList();
        if (widget.resort != null) {
          allResortsNames.remove(widget.resort.resortName);
        }
        if (allResortsNames.contains(_resortName)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different resort name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final resortId =
              widget.resort?.resortId ?? documentIdFromCurrentDate();
          final resort = Resort(
            resortId: resortId,
            resortName: _resortName,
            resortDescription: _resortDescription,
            resortAddress: _resortAddress,
            resortTel: _resortTel,
            resortType: _resortType,

          );
          await widget.database.setResort(resort);
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
        title: Text(widget.resort == null ? 'New Resort' : 'Edit Resort'),
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
        padding: const EdgeInsets.all(16.0),
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
        decoration: InputDecoration(labelText: 'Resort Name'),
        initialValue: _resortName,
        onSaved: (value) => _resortName = value,
        validator: (value) => value.isNotEmpty ? null : 'Name cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Resort Description'),
        initialValue: _resortDescription,
        onSaved: (value) => _resortDescription = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Description cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Resort Address'),
        initialValue: _resortAddress,
        onSaved: (value) => _resortAddress = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Address cant\'t be empty',
      ),
//      TextFormField(
//        decoration: InputDecoration(labelText: 'Resort Telephone No'),
//        initialValue: _resortTel != null ? '$_resortTel' : null,
//        keyboardType: TextInputType.numberWithOptions(
//          signed: false,
//          decimal: false,
//        ),
//        onSaved: (value) => _resortTel = int.tryParse(value) ?? 0,
//      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Resort Telephone'),
        initialValue: _resortTel,
        onSaved: (value) => _resortTel = value,
        validator: (value) => value.isNotEmpty ? null : 'Type cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Resort Type'),
        initialValue: _resortType,
        onSaved: (value) => _resortType = value,
        validator: (value) => value.isNotEmpty ? null : 'Type cant\'t be empty',
      ),

    ];
  }
}
