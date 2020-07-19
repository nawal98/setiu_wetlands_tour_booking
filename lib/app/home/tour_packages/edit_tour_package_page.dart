import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_package.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/services.dart';

class EditTourPackagePage extends StatefulWidget {
  const EditTourPackagePage({
    Key key,
    @required this.database,
    this.tourPackage,
  }) : super(key: key);
  final Database database;
  final TourPackage tourPackage;
  static Future<void> show(BuildContext context,
      {TourPackage tourPackage, Database database}) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) =>
            EditTourPackagePage(database: database, tourPackage: tourPackage),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditTourPackagePageState createState() => _EditTourPackagePageState();
}

class _EditTourPackagePageState extends State<EditTourPackagePage> {
  final _formKey = GlobalKey<FormState>();
  String _tourName;
  String _tourDescription;
  int _tourAdultAmount;
  int _tourChildAmount;
  int _tourInfantAmount;
  List<int> _tourDiscountOption = [
    0,
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    55,
    60,
    65,
    70,
    75,
    80,
    85,
    90,
    95
  ];
  int _tourDiscount;

  @override
  void initState() {
    super.initState();
    if (widget.tourPackage != null) {
      _tourName = widget.tourPackage.tourName;
      _tourDescription = widget.tourPackage.tourDescription;
      _tourAdultAmount = widget.tourPackage.tourAdultAmount;
      _tourChildAmount = widget.tourPackage.tourChildAmount;
      _tourInfantAmount = widget.tourPackage.tourInfantAmount;
      _tourDiscount = widget.tourPackage.tourDiscount;
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
        final tourPackages = await widget.database.tourPackagesStream().first;
        final allTourPackagesNames =
            tourPackages.map((tourPackage) => tourPackage.tourName).toList();
        if (widget.tourPackage != null) {
          allTourPackagesNames.remove(widget.tourPackage.tourName);
        }
        if (allTourPackagesNames.contains(_tourName)) {
          PlatformAlertDialog(
            title: 'Tour Package Name Already Used',
            content: 'Please choose a different tour package name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final tourPackageId =
              widget.tourPackage?.tourPackageId ?? documentIdFromCurrentDate();
          final tourPackage = TourPackage(
              tourPackageId: tourPackageId,
              tourName: _tourName,
              tourDescription: _tourDescription,
              tourAdultAmount: _tourAdultAmount,
              tourChildAmount: _tourChildAmount,
              tourInfantAmount: _tourInfantAmount,
              tourDiscount: _tourDiscount);
          await widget.database.setTourPackage(tourPackage);
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
        title: Text(widget.tourPackage == null
            ? 'New Tour Package'
            : 'Edit Tour Package'),
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
            Text(
              'General Info',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black54),
            ),

            _buildForm()
//        child: Card(
//          child: Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: _buildForm(),
//          ),
//        ),
          ]),
    ));
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
        decoration: InputDecoration(labelText: 'Tour Package Name'),
        initialValue: _tourName,
        onSaved: (value) => _tourName = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Tour package name cant\'t be empty',
      ),
      _buildTourDescription(),
      TextFormField(
        decoration: InputDecoration(labelText: 'Adult Price(RM)'),
        initialValue: _tourAdultAmount != null ? '$_tourAdultAmount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourAdultAmount = int.tryParse(value) ?? 0,
        validator: (value) =>
            value.isNotEmpty ? null : 'Adult price cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Child Price(RM)'),
        initialValue: _tourChildAmount != null ? '$_tourChildAmount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourChildAmount = int.tryParse(value) ?? 0,
        validator: (value) =>
            value.isNotEmpty ? null : 'Child price cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Infant Price(RM)'),
        initialValue: _tourInfantAmount != null ? '$_tourInfantAmount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourInfantAmount = int.tryParse(value) ?? 0,
        validator: (value) =>
            value.isNotEmpty ? null : 'Infant price cant\'t be empty',
      ),
      SizedBox(height: 15),
      Text(
        'Discount(%)',
        style: TextStyle(fontSize: 12.0, color: Colors.black54),
      ),
      _buildtourDiscount(),
    ];
  }

  Widget _buildTourDescription() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 500,
      controller: TextEditingController(text: _tourDescription),
      decoration: InputDecoration(
        labelText: 'Tour Package Description',
        labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      maxLines: null,
      onChanged: (tourDescription) => _tourDescription = tourDescription,
    );
  }

  Widget _buildtourDiscount() {
    return DropdownButton(
//      hint: Text('Please choose a bed type'), // Not necessary for Option 1
      value: _tourDiscount,
      onChanged: (newValue) {
        setState(() {
          _tourDiscount = newValue;
        });
      },
      items: _tourDiscountOption.map((disc) {
        return DropdownMenuItem(
          child: new Text(disc.toString()),
          value: disc,
        );
      }).toList(),
    );
  }
}
