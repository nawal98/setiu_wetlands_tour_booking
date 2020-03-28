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
      {TourPackage tourPackage}) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      MaterialPageRoute(
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
  int _durationPerHour;
  String _tourDescription;
  int _tourAdultAmount;
  int _tourChildAmount;
  int _tourInfantAmount;
  int _tourDiscount;

  @override
  void initState() {
    super.initState();
    if (widget.tourPackage != null) {
      _tourName = widget.tourPackage.tourName;
      _durationPerHour = widget.tourPackage.durationPerHour;
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
            title: 'Name already used',
            content: 'Please choose a different tour package name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final tourPackageId =
              widget.tourPackage?.tourPackageId ?? documentIdFromCurrentDate();
          final tourPackage = TourPackage(
              tourPackageId: tourPackageId,
              tourName: _tourName,
              durationPerHour: _durationPerHour,
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
        decoration: InputDecoration(labelText: 'Tour Package Name'),
        initialValue: _tourName,
        onSaved: (value) => _tourName = value,
        validator: (value) => value.isNotEmpty ? null : 'Name cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Description'),
        initialValue: _tourDescription,
        onSaved: (value) => _tourDescription = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'Description cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Duration Per Hour'),
        initialValue: _durationPerHour != null ? '$_durationPerHour' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _durationPerHour = int.tryParse(value) ?? 0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Adult Price(RM)'),
        initialValue: _tourAdultAmount != null ? '$_tourAdultAmount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourAdultAmount = int.tryParse(value) ?? 0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Child Price(RM)'),
        initialValue: _tourChildAmount != null ? '$_tourChildAmount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourChildAmount = int.tryParse(value) ?? 0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Infant Price(RM)'),
        initialValue: _tourInfantAmount != null ? '$_tourInfantAmount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourInfantAmount = int.tryParse(value) ?? 0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Discount(%)'),
        initialValue: _tourDiscount != null ? '$_tourDiscount' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _tourDiscount = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
