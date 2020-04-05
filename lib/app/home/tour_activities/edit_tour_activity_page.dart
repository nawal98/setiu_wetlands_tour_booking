import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/models/tour_activity.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/database.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/services.dart';

class EditTourActivityPage extends StatefulWidget {
  const EditTourActivityPage({
    Key key,
    @required this.database,
    this.tourActivity,
  }) : super(key: key);
  final Database database;
  final TourActivity tourActivity;
  static Future<void> show(BuildContext context,
      {TourActivity tourActivity}) async {
    final database = Provider.of<Database>(context);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) =>
            EditTourActivityPage(database: database, tourActivity: tourActivity),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditTourActivityPageState createState() => _EditTourActivityPageState();
}

class _EditTourActivityPageState extends State<EditTourActivityPage> {
  final _formKey = GlobalKey<FormState>();
  String _activityName;
  String _activityDescription;

  @override
  void initState() {
    super.initState();
    if (widget.tourActivity != null) {
      _activityName = widget.tourActivity.activityName;
      _activityDescription = widget.tourActivity.activityDescription;
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
        final tourActivities = await widget.database.tourActivitiesStream().first;
        final allTourActivitiesNames =
        tourActivities.map((tourActivity) => tourActivity.activityName).toList();
        if (widget.tourActivity != null) {
          allTourActivitiesNames.remove(widget.tourActivity.activityName);
        }
        if (allTourActivitiesNames.contains(_activityName)) {
          PlatformAlertDialog(
            title: 'Name already used',
            content: 'Please choose a different tour activity name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final tourActivityId =
              widget.tourActivity?.tourActivityId ?? documentIdFromCurrentDate();
          final tourActivity = TourActivity(
              tourActivityId: tourActivityId,
              activityName: _activityName,
              activityDescription: _activityDescription);
          await widget.database.setTourActivity(tourActivity);
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
        title: Text(widget.tourActivity == null
            ? 'New Tour Activity'
            : 'Edit Tour Activity'),
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
        decoration: InputDecoration(labelText: 'Tour Activity Name'),
        initialValue: _activityName,
        onSaved: (value) => _activityName = value,
        validator: (value) => value.isNotEmpty ? null : 'Name cant\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Description'),
        initialValue: _activityDescription,
        onSaved: (value) => _activityDescription = value,
        validator: (value) => value.isNotEmpty ? null : 'Description cant\'t be empty',
      ),

    ];
  }
}