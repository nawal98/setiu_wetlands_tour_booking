import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/email_sign_in_change_model.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/common_widget/form_submit_button.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/staff_sign_in_page.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/staff.dart';

class StaffSignInFormChangeNotifier extends StatefulWidget {
  StaffSignInFormChangeNotifier({@required this.model});
  final StaffSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<StaffSignInChangeModel>(
      create: (context) => StaffSignInChangeModel(auth: auth),
      child: Consumer<StaffSignInChangeModel>(
          builder: (context, model, _) =>
              StaffSignInFormChangeNotifier(model: model)),
    );
  }

  @override
  _StaffSignInFormChangeNotifierState createState() =>
      _StaffSignInFormChangeNotifierState();
}

class _StaffSignInFormChangeNotifierState
    extends State<StaffSignInFormChangeNotifier> {
  List<Staff> staffs;
  Staff selectedStaff;
  int selectedRadio;
  int selectedRadioTile;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  StaffSignInChangeModel get model => widget.model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedRadioTile = 0;
    staffs = Staff.getStaff();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  List<Widget> createRadioListStaffs() {
    List<Widget> widgets = [];
    for (Staff staff in staffs) {
      widgets.add(
        RadioListTile(
          value: staff,
          groupValue: selectedStaff,
          title: Text(staff.staffrole),
          onChanged: (currentStaff) {
            print('Current Staff ${staff.staffrole}');
            setSelectedStaff(currentStaff.staffrole);
          },
          selected: selectedStaff == staff,
          activeColor: Colors.lightGreen,
        ),
      );
    }
    return widgets;
  }

  setSelectedStaff(Staff staff){
    setState(() {
      selectedStaff = staff;
    });

  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    return [

      RadioListTile(
        value: 1,
        groupValue: selectedRadioTile,
        title: Text('Admin'),
        onChanged: (val) {
          print('Radio Tile pressed $val');
          setSelectedRadioTile(val);
        },
      ),
      RadioListTile(
        value: 2,
        groupValue: selectedRadioTile,
        title: Text('Operator'),
        onChanged: (val) {
          print('Radio Tile pressed $val');
          setSelectedRadioTile(val);
        },
      ),
      RadioListTile(
        value: 3,
        groupValue: selectedRadioTile,
        title: Text('Manager'),
        onChanged: (val) {
          print('Radio Tile pressed $val');
          setSelectedRadioTile(val);
        },
      ),
      Divider(
        height: 8,
        color: Colors.black87,
      ),
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: model.updatePassword,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,

        children: _buildChildren(),
      ),

    );
  }
}
