// @dart=2.9
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import '../firebase/users_record.dart';
import '../services/navigation_service.dart';
import 'base_model.dart';
import '../../ui/shared/icon_names.dart' as icons;

class p02Model extends BaseModel {
  final TAG = "p02Model:";
  final NavigationService _navigationService = locator<NavigationService>();


  bool bDataReady = true;
  int _type;
  int _url;
  ScrollController scrollController;
  TextEditingController accountCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  String account = '';
  String password = '';
  bool bAgree = true;
  bool bShowOnce = false;
  bool bNoMore = false;
  GroupController groupController = GroupController();
  int selectedAccount = 1;
  int selectedBind = 1;
  int selectedSex = -1;
  int selectedblood = -1;
  int selectedRh = -1;
  String _selectedBG = icons.CommonImage.light_purplecircle;
  ConfirmationResult _webPhoneAuthConfirmationResult;
  String _phoneAuthVerificationCode;
  CarouselController carouseController = CarouselController();
  List<int> physiques = <int>[];
  List<String> physiqueQuestions = <String>[];
  int lengthPhysiques = 50;
  Random random = new Random();

  p02Model() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  int getRandom(){
    Fimber.i('$TAG getRandom:');
    int _rnd = random.nextInt(9);
    Fimber.i('$TAG getRandom: _rnd = $_rnd');
    return _rnd;
  }

  setPhysiques(int _index, int _value){
    physiques[_index] = _value;
    notifyListeners();
  }

  Future beginPhoneAuth({
    String phoneNumber,
    VoidCallback onCodeSent,
  }) async {
    Fimber.i('$TAG beginPhoneAuth: phoneNumber = $phoneNumber');
    if (kIsWeb) {
      _webPhoneAuthConfirmationResult =
      await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
      onCodeSent();
      return;
    }
    // If you'd like auto-verification, without the user having to enter the SMS
    // code manually. Follow these instructions:
    // * For Android: https://firebase.google.com/docs/auth/android/phone-auth?authuser=0#enable-app-verification (SafetyNet set up)
    // * For iOS: https://firebase.google.com/docs/auth/ios/phone-auth?authuser=0#start-receiving-silent-notifications
    // * Finally modify verificationCompleted below as instructed.
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: (phoneAuthCredential) async {
        Fimber.i('$TAG beginPhoneAuth: verificationCompleted: honeNumber = ${phoneAuthCredential.smsCode}');
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        // If you've implemented auto-verification, navigate to home page or
        // onboarding page here manually. Uncomment the lines below and replace
        // DestinationPage() with the desired widget.
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) => DestinationPage()),
        // );
      },
      verificationFailed: (e) {
        Fimber.i('$TAG beginPhoneAuth: verificationFailed: e.message = $e.message');
        showSnackBar2(e.message);
      },
      codeSent: (verificationId, _) {
        _phoneAuthVerificationCode = verificationId;
        Fimber.i('$TAG beginPhoneAuth: codeSent: verificationId = $verificationId');
        onCodeSent();
      },
      codeAutoRetrievalTimeout: (_) {
        Fimber.i('$TAG beginPhoneAuth: codeAutoRetrievalTimeout:');
      },
    );
  }

  Future verifySmsCode({String smsCode,}) async {
    Fimber.i('$TAG verifySmsCode: smsCode = $smsCode');
    if (kIsWeb) {
      return signInOrCreateAccount(
          context, () => _webPhoneAuthConfirmationResult.confirm(smsCode));
    } else {
      final authCredential = PhoneAuthProvider.credential(
          verificationId: _phoneAuthVerificationCode, smsCode: smsCode);
      return signInOrCreateAccount(
        context,
            () => FirebaseAuth.instance.signInWithCredential(authCredential),
      );
    }
  }

  /// Tries to sign in or create an account using Firebase Auth.
  /// Returns the User object if sign in was successful.
  Future<User> signInOrCreateAccount(
      BuildContext context, Future<UserCredential> Function() signInFunc) async {
    try {
      final userCredential = await signInFunc();
      if (userCredential?.user != null) {
        await maybeCreateUser(userCredential.user);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
      return null;
    }
  }

  // Creates a Firestore document representing the logged in user if it doesn't yet exist
  Future maybeCreateUser(User user) async {
    final userRecord = UsersRecord.collection.doc(user.uid);
    final userExists = await userRecord.get().then((u) => u.exists);
    if (userExists) {
      return;
    }

    final userData = createUsersRecordData(
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      createdTime: getCurrentTimestamp,
    );

    await userRecord.set(userData);
  }

  DateTime get getCurrentTimestamp => DateTime.now();

  setSex(int _value){
    selectedSex = _value;
    notifyListeners();
  }

  String getSexBg(int _index){
    String _value = icons.CommonImage.greycircle;
    if(selectedSex==_index) _value = _selectedBG;
    return _value;
  }

  setBlood(int _value){
    selectedblood = _value;
    notifyListeners();
  }

  String getBloodBg(int _index){
    String _value = icons.CommonImage.greycircle;
    if(selectedblood==_index) _value = _selectedBG;
    return _value;
  }

  setRh(int _value){
    selectedRh = _value;
    notifyListeners();
  }

  String getRhBg(int _index){
    String _value = icons.CommonImage.greycircle;
    if(selectedRh==_index) _value = _selectedBG;
    return _value;
  }

  @override
  void initState() async {
    Fimber.i("$TAG initState:");
    super.initState();
    _initialize();
  }

  @override
  dispose() async {
    Fimber.i("$TAG dispose:");
    super.dispose();
  }

  _initialize() async {
    Fimber.i('$TAG _initialize:');
    physiques = List.generate(lengthPhysiques, (i) => 0, growable: false);
    physiqueQuestions = List.generate(lengthPhysiques, (i) => null, growable: false);
    for(int i=0; i<lengthPhysiques; i++){
      physiqueQuestions[i] = keyString2('physique_${(i+1).toString()}');
    }
  }

  onCheckAgree(bool _value){
    bAgree = _value;
    Fimber.i('$TAG bAgree = $bAgree');
    notifyListeners();
  }

  onCheckNoMore(bool _value){
    bNoMore = _value;
    Fimber.i('$TAG bNoMore = $bNoMore');
    notifyListeners();
  }

  onCheck(bool _value){
    bShowOnce = _value;
    Fimber.i('$TAG bShowOnce = $bShowOnce');
    notifyListeners();
  }

  initData(int type, String url) {
    // Connecting.show(context: context);
    passwordCont.text = accountCont.text = '';
    this._type = type;
    this._url;
    // Connecting.dismiss();
  }

  show_verify_error() async {
    Fimber.i("$TAG show_verify_error: ");
    SmartDialog.show(builder: (_) {
      return Container(
        height: 105.h,
        width: 130.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.h,),
            Container(
              width: 76.w,
              height: 16.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 39.w, right: 37.w),
              child: AutoSizeText(
                keyString2("verify_error"),
                style: TextStyle(fontSize: 13.sp, color: Colors.red, fontWeight: FontWeight.normal, fontFamily: getFontFamily(),),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              width: 76.w,
              height: 14.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.w, right: 6.w),
              child: AutoSizeText(
                keyString2("verify_again"),
                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: getFontFamily(), letterSpacing: 2.1),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h,),
            Container(
              width: 130.w,
              height: 1.h,
              color: Colors.grey.withOpacity(0.5),
            ),
            GestureDetector(
              onTap: (){
                Fimber.i('$TAG onTap: confirm:');
                SmartDialog.dismiss();
              },
              child: Text(
                keyString2( "confirm"),
                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: getFontFamily(),),
              ),
            ),
          ],
        ),
      );
    });
  }

  showDialogMessage(String _message) async {
    Fimber.i("$TAG show_login_error: ");
    SmartDialog.show(builder: (_) {
      return Container(
        height: 105.h,
        width: 133.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 26.h,),
            Container(
              width: 140.w,
              height: 32.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10.w, right: 6.w),
              child: AutoSizeText(
                keyString2("login_error"),
                style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: getFontFamily(),),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h,),
            Container(
              width: 140.w,
              height: 1.h,
              color: Colors.grey.withOpacity(0.5),
            ),
            GestureDetector(
              onTap: (){
                Fimber.i('$TAG onTap: confirm:');
                SmartDialog.dismiss();
              },
              child: Text(
                keyString2( "confirm"),
                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: getFontFamily(),),
              ),
            ),
          ],
        ),
      );
    });
  }

}
