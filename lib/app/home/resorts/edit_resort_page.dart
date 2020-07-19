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
  int _resortTel;
  List<String> _resortType = [
    'Beach',
    'Spa',
    'Tropical',
    'Historical',
    'Vintage'
  ]; // Option 2
  String _selectedResortType;
  List<String> _postcodeOption = [
    '21010',
    '21450',
    '21500',
    '22100',
    '22107',
    '22109',
    '22110',
    '22120'
  ]; // Option 2
  String _postcode; // Option 2
  @override
  void initState() {
    super.initState();
    if (widget.resort != null) {
      _resortName = widget.resort.resortName;
      _resortDescription = widget.resort.resortDescription;
      _resortAddress = widget.resort.resortAddress;
      _resortTel = widget.resort.resortTel;
      _selectedResortType = widget.resort.resortType;
      _postcode = widget.resort.postcode;
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
            title: 'Resort name already used',
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
            resortType: _selectedResortType,
            postcode: _postcode,
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
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 12.0),
              Text(
                'General Info',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black54),
              ),
              SizedBox(height: 12.0),
              _buildForm(),
              SizedBox(height: 50.0),
            ]),
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
      _buildDescription(),
      _buildResorType(),
      _buildAddrDescription(),
      _buildPostcode(),
      Row(children: <Widget>[
        Expanded(child: Container()),
        Text(
          'Setiu, Terengganu, Malaysia',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
      ]),
      TextFormField(
        decoration: InputDecoration(labelText: 'Resort Telephone No'),
        initialValue: _resortTel != null ? '$_resortTel' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _resortTel = int.tryParse(value) ?? 0,
      ),
    ];
  }

  Widget _buildDescription() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 500,
      controller: TextEditingController(text: _resortDescription),
      decoration: InputDecoration(
        labelText: 'Resort Description',
        labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      maxLines: null,
      onChanged: (resortDescription) => _resortDescription = resortDescription,
    );
  }

  Widget _buildAddrDescription() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 100,
      controller: TextEditingController(text: _resortAddress),
      decoration: InputDecoration(
        labelText: 'Resort Address',
        labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      maxLines: null,
      onChanged: (resortAddress) => _resortAddress = resortAddress,
    );
  }

  Widget _buildResorType() {
    return DropdownButton(
      hint: Text('Please choose a resort type'), // Not necessary for Option 1
      value: _selectedResortType,
      onChanged: (newValue) {
        setState(() {
          _selectedResortType = newValue;
        });
      },
      items: _resortType.map((resType) {
        return DropdownMenuItem(
          child: new Text(resType),
          value: resType,
        );
      }).toList(),
    );
  }

  Widget _buildPostcode() {
    return DropdownButton(
      hint: Text('Please choose a postcode'), // Not necessary for Option 1
      value: _postcode,
      onChanged: (newValue) {
        setState(() {
          _postcode = newValue;
        });
      },
      items: _postcodeOption.map((post) {
        return DropdownMenuItem(
          child: new Text(post),
          value: post,
        );
      }).toList(),
    );
  }
}
