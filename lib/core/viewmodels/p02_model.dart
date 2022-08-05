// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../core/services/navigation_service.dart';
import '../../locator.dart';
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
  bool bShowOnce = true;
  GroupController groupController = GroupController();
  int selectedAccount = 1;
  int selectedBind = 1;
  int selectedSex = -1;
  int selectedblood = -1;
  int selectedRh = -1;
  String _selectedBG = icons.CommonImage.light_purplecircle;

  p02Model() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

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
