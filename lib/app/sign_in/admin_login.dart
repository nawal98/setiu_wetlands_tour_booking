import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/sign_in_manager.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/sign_in_button.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/sign_in_page.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/social_sign_in_button.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/staff_page.dart';
import 'package:setiuwetlandstourbooking/common_widget/platform_exception_alert_dialog.dart';
import 'package:setiuwetlandstourbooking/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/staff_sign_in_page.dart';
import 'package:setiuwetlandstourbooking/app/sign_in/email_sign_in_page.dart';


class AdminLogin extends StatelessWidget {
   const AdminLogin({Key key, @required this.manager, @required this.isLoading})
      : super(key: key);
  final SignInManager manager;
  final bool isLoading;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }


//  final Database database;
//  final TourActivity tourActivity;
//  final GlobalKey<ScaffoldState> globalKey;
//  static Future<void> show(BuildContext context,
//      {TourActivity tourActivity, Database database}) async {
//    final database = Provider.of<Database>(context);
//    await Navigator.of(context).push(
//      CupertinoPageRoute(
//        builder: (context) => AdminLogin(),
//        fullscreenDialog: true,
//      ),
//    );
//  }





//  final _formKey = GlobalKey<FormState>();
  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }
//  String _activityName;
//  String _activityDescription;
//  File _image;
//  String _uploadedFileURL;
//  List<NetworkImage> listOfImage= <NetworkImage>[];
//  bool clicked = false;
//  List<String> listOfStr = List();
//  final Firestore fb = Firestore.instance;
//  bool isLoading = false;
//  var storage = FirebaseStorage.instance;

//  List<NetworkImage> _listOfImages = <NetworkImage>[];
//  @override
//  void initState() {
//    super.initState();
//    if (widget.tourActivity != null) {
//      _activityName = widget.tourActivity.activityName;
//      _activityDescription = widget.tourActivity.activityDescription;
//      _uploadedFileURL = widget.tourActivity.url;
//    }
//  }

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
//        final tourActivities =
//        await widget.database.tourActivitiesStream().first;
//        final allTourActivitiesNames = tourActivities
//            .map((tourActivity) => tourActivity.activityName)
//            .toList();
//        if (widget.tourActivity != null) {
//          allTourActivitiesNames.remove(widget.tourActivity.activityName);
//        }
//        if (allTourActivitiesNames.contains(_activityName)) {
//          PlatformAlertDialog(
//            title: 'Name already used',
//            content: 'Please choose a different tour activity name',
//            defaultActionText: 'OK',
//          ).show(context);
//        } else {
//          final tourActivityId = widget.tourActivity?.tourActivityId ??
//              documentIdFromCurrentDate();
//          final tourActivity = TourActivity(
//            tourActivityId: tourActivityId,
//            activityName: _activityName,
//            activityDescription: _activityDescription,
//            url: _uploadedFileURL,
//          );
//          await widget.database.setTourActivity(tourActivity);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Admin Login'),
      ),
      body: _buildContents(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(BuildContext context) {
    return SingleChildScrollView(

        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildForm(),

              SizedBox(height: 12),
              SignInButton(
                text: 'Go anonymous',
                textColor: Colors.black,
                color: Colors.lime[300],
                onPressed: isLoading ? null : () => _signInAnonymously(context),
              ),
            ],
          ),

        ));
  }


  Widget _buildForm() {
    return Form(
//      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
//        initialValue: _activityName,
//        onSaved: (value) => _activityName = value,
//        validator: (value) => value.isNotEmpty ? null : 'Name cant\'t be empty',
      ),
//      TextFormField(
//        decoration: InputDecoration(labelText: 'Description'),
//        initialValue: _activityDescription,
//        onSaved: (value) => _activityDescription = value,
//        validator: (value) =>
//            value.isNotEmpty ? null : 'Description cant\'t be empty',
//      ),
    ];
  }

//  Future chooseFile() async {
//    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
//      setState(() {
//        _image = image;
//      });
//    });
//  }
//
//  Future uploadFile() async {
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('tourActivities/${Path.basename(_image.path)}}');
//    StorageUploadTask uploadTask = storageReference.putFile(_image);
//    await uploadTask.onComplete;
//    print('File Uploaded');
//    storageReference.getDownloadURL().then((fileURL) {
//      Firestore.instance
//          .collection("tourActivities")
//          .add({"url": _uploadedFileURL, 'activityName':_activityName,'activityDescription':_activityDescription});
//
//      setState(() {
//        _uploadedFileURL = fileURL;
//      });
//    });


//    if (_image != null) {
//      StorageReference ref = FirebaseStorage.instance.ref();
//      StorageTaskSnapshot addImg =
//      await ref.child("tourActivities/url").putFile(_image).onComplete;
//      if (addImg.error == null) {
//        print("added to Firebase Storage");
//      }
//    }
//  }
//  Future<void> deleteImage() async {
////    var fileUrl = Uri.decodeFull('tourActivities/${Path.basename(_image.path)}}').replaceAll(new RegExp(r'(\?alt).*'), '');
////
////    StorageReference storageReference = FirebaseStorage.instance
////        .ref()
////        .child('tourActivities/${Path.basename(_image.path)}}');
//
//
//    final StorageReference firebaseStorageRef =
//    FirebaseStorage.instance.ref().child('tourActivities/$_uploadedFileURL');
//    await firebaseStorageRef.delete();
//  }
//
//  void clearSelection() {
//    setState(() {
//      _image = null;
//      _uploadedFileURL = null;
//    });
//  }
//
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = image;
//    });
//  }
//
//  Future<QuerySnapshot> getImages() {
//
//    return fb.collection("tourActivities").document('').getDocuments();
//  }
}
// Get a reference to our posts
//final FirebaseDatabase database = FirebaseDatabase.getInstance();
//DatabaseReference ref = database.getReference("server/saving-data/fireblog/posts");
//
//// Attach a listener to read the data at our posts reference
//ref.addValueEventListener(new ValueEventListener() {
//  @Override
//  public void onDataChange(DataSnapshot dataSnapshot) {
//  Post post = dataSnapshot.getValue(Post.class);
//  System.out.println(post);
//  }
//
//  @Override
//  public void onCancelled(DatabaseError databaseError) {
//  System.out.println("The read failed: " + databaseError.getCode());
//  }
//});

//final ref = FirebaseStorage.instance
//    .ref()
//    .child('users')
//    .child('tourActivities')
//    .child('url');
//
//ref.putFile(_image);
//// or ref.putData(Uint8List.fromList(imageData));
//
//var url = await ref.getDownloadURL() as String;
