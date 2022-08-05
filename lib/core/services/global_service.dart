// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/Constant.dart';
import '../../core/utils/helper.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../viewmodels/main_model.dart';

enum PermissionGroup {
/// Android: Fine and Coarse Location
/// iOS: CoreLocation - Always
locationAlways,
/// Android: Fine and Coarse Location
/// iOS: CoreLocation - WhenInUse
locationWhenInUse
}

class GlobalService {
  Size screenSize, physicalSize;
  double unitHeight, unitWidth;
  double devicePixelRatio, realWidth, realHeight;
  double ratioHeight, ratioWidth;
  double heightRatio;
  double textScaleFactor;
  final double sms7_unitWidth = 0.3333333333333333;
  final double sms7_unitHeight = 0.3333333333333333;
  final double defaultScaleTextFactor = 1.0;
  final double superlargeFont = 32.0;
  final double largeFont = 30.0;
  final double appbarFont = 22.0;
  final double appbarIconSize = 28.0;
  final double myPadding = 60;
  final double iconSize = 24.0;
  final double titleFont = 20.0;
  final double subtitleFont = 18.0;
  final double headingFont = 16.0;
  final double pagePadding = 20.0;
  final double miniFont = 14.0;
  final double tinyFont = 12.0;
  BuildContext myContext;
  var pref;
  String language;
  bool bIsLoggedIn;
  String wifiName;
  bool bDoInfolist = false;
  ValueNotifier vnInfolist;
  bool bDoDeviceRefresh = false;
  ValueNotifier vnDeviceRefresh;
  double bLoading = -1;
  ValueNotifier vnLoading;
  bool bIsAndroid = true;
  MainModel model;
  Size defaultScreenSize = const Size(360, 640);
  int selectedIndex = 0;
  int DeviceType0;
  String DeviceType = "DeviceType";
  String fwDevice = "";
  String wifiSSID = "";
  String deviceSSID = "ssid";
  String Password = "password";
  String WifiMac = "WifiMAC";
  String QRString = "";
  SharedPreferences preferences;
  String fwServer = "";
  String fwUrl = "";
  String accessToken = "";
  String refreshToken = "";
  int expiresIn = 0;
  Directory documentDirectory;
  Directory tempDirectory;
  File fwFile;
  String deviceIP = '';
  String OTA_Progress = '';

  initCacheInfo() async{
    tempDirectory = await getTemporaryDirectory();
    String _stringTempDirectory = tempDirectory.path + CACHE_FOLDER;
    tempDirectory = Directory(_stringTempDirectory);
    Fimber.i('initCacheInfo: _stringTempDirectory = $_stringTempDirectory');
    // String _document_path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS)+ CACHE_FOLDER;
    // documentDirectory = Directory(_document_path);
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes, allowMalformed: false);
  }

  hideKeyboard(BuildContext _myContext){
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(_myContext).unfocus();
  }

  String keyString(String key) {
    // return AppLocalizations.of(myContext).translate(key);
    return tr(key);
  }

  void redirectUrl2(url) async {
    await launch(url);
  }

  Future<bool> isLoggedIn() async {
    return await getBool(IS_LOGGED_IN);
  }

  Future<PermissionStatus> getSinglePermissionStatus(Permission permission) async {
    //adb shell pm reset-permissions
    PermissionStatus permissionStatus = await permission.request();
    Fimber.i('getSinglePermissionStatus: permission = ${permission.value}, permissionStatus = ${permissionStatus.toString()}');
    return permissionStatus;
  }

  double getFontRatio(double fontsize){
    double value = 1;
    if(kIsWeb) value = fontsize * heightRatio * 0.6;
    else value = fontsize * heightRatio;
    Fimber.i('getFontRatio: value = $value');
    return value;
  }

  double getHeightRatio(){
    double value = 1;
    value = screenSize.width / 360;
    // if(kIsWeb) value = value * 0.6;
    Fimber.i('getHeightRatio: value = $value');
    return value;
  }

  double getFixedSize(double textSize) {
    double value;
    value = textScaleFactor != defaultScaleTextFactor ? (textSize / textScaleFactor) * defaultScaleTextFactor : textSize;
    Fimber.i('getFixedSize: textSize = $textSize, value = $value');
    return value;
  }


  double getHeight(double _height){
    return _height * unitHeight;
  }

  double getWidth(double _weight){
    return _weight * unitWidth;
  }


  double getAspecRatio(double _width, double _height){
    double _value = _height / _width;
    // Fimber.i('getAspecRatio: _height = $_height, value = $_value');
    return _value;
  }

  double getImageHeight(Size _size){
    double _ratio = _size.width / screenSize.width;
    double _value = getHeight(_size.height/_ratio);
    // Fimber.i('getImageHeight: _height = $_size.height, _ratio = $_ratio, value = $_value');
    return _value;
  }

  void doResponsiveCalc(BuildContext context){
    Fimber.i('doResponsiveCalc:');
    textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Fimber.i('doResponsiveCalc: textScaleFactor = $textScaleFactor');
    getFixedSize(10.0);
    screenSize = MediaQuery.of(context).size;
    devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    physicalSize =  window.physicalSize;
    ratioWidth = screenSize.width / defaultScreenSize.width;
    ratioHeight = screenSize.height / defaultScreenSize.height;
    Fimber.i('doResponsiveCalc: screenSize = ${screenSize}, ratioHeight = $ratioHeight, ratioWidth = $ratioWidth');
    realWidth = screenSize.width * devicePixelRatio;
    realHeight = screenSize.height * devicePixelRatio;
    Fimber.i('doResponsiveCalc: physicalSize = $physicalSize, devicePixelRatio = $devicePixelRatio, realWidth = $realWidth, realHeight = $realHeight');
    unitWidth = ratioWidth;
    unitHeight = ratioHeight;
    Fimber.i('doResponsiveCalc: final count: unitHeight = $unitHeight, unitWidth = $unitWidth, heightRatio = $heightRatio');
  }

  Widget mySpinner(){
    return Center(
      child: Container(
        height: getHeight(60),
        width: getWidth(60),
        child: new Image(
          image: new ExactAssetImage("assets/loading241.gif"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget getMyLoading(){
    return Container(
      color: Colors.white,
      width: screenSize.width,
      height: screenSize.height,
      child: Center(
        child: Container(
          height: getHeight(60),
          width: getWidth(60),
          child: new Image(
            image: new ExactAssetImage("assets/loading241.gif"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

}