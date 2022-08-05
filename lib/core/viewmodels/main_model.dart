// @dart=2.9
import 'dart:async';
import 'dart:typed_data';

import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:otp_count_down/otp_count_down.dart';

import '../../vo/deviceversion_response_vo.dart';
import '../../vo/qrcode_response_vo.dart';
import '../../vo/token_response_vo.dart';
import '../models/Constant.dart';
import 'base_model.dart';
import 'package:http/http.dart' as http;
import '../../ui/shared/icon_names.dart' as icons;

enum PageNum{
  WifiSetup, DevicePage, OtaView, PageFour,//0~4
}

class MainModel extends BaseModel {
  final TAG = "MainModel:";
  bool bDataReady = true;
  FocusNode passFocusNode;
  TextEditingController passwordCont = TextEditingController();
  bool bEditPassword = false;
  String _password;
  OTPCountDown _otpCountDown = null;
  int _otpTimeInMS; // = 1000 * 60 * 20; //20 mins
  bool _isOTPing = false;
  BluetoothCharacteristic _characteristicRead;
  BluetoothCharacteristic _characteristicWrite;
  BluetoothCharacteristic _characteristicOTA;
  Duration oneSec = Duration(seconds:1);
  ScrollController scrollController;
  List<int> scores9 = [
    19,
    21,
    52,
    61,
    64,
    68,
    57,
    67,
    77
  ];

  @override
  void initState() async {
    Fimber.i("$TAG initState:");
    super.initState();
    _initialize();
  }

  @override
  dispose() async {
    Fimber.i("$TAG: dispose:");
    super.dispose();
  }

  _initialize() async {
    Fimber.i('$TAG _initialize: bDataReady = $bDataReady');
    passFocusNode = new FocusNode();
    passFocusNode.addListener(() => clickPassword());
    bDataReady = true;
    notifyListeners();
  }

  String getLevelBg(int _index){
    String _level = icons.CommonImage.g_level;
    int _score = scores9[_index];
    if(_score<70){
      if(_score<50) {
        if(_score<20) {
          _level = icons.CommonImage.r_level;
        } else _level = icons.CommonImage.o_level;
      } else _level = icons.CommonImage.y_level;
    }
    return _level;
  }

  clickPassword(){
    if(passFocusNode.hasFocus) {
      Fimber.i('$TAG clickPassword: hasFocus:');
      _password = passwordCont.text.toString();
      bEditPassword = true;
    } else {
      Fimber.i('$TAG clickPassword: !hasFocus:');
      bEditPassword = false;
    }
  }

  gotoDevice(ScanResult _result){
    Fimber.i("$TAG: gotoDevice: _result = ${_result.device.name}");
    showFloatingSnackBar('i am here');
    // WidgetsBinding.instance.addPostFrameCallback((_) => _wifisetup());
  }

  onPageChanged(int index) {
  }


  List<int> _getIntList(String _value){
    Fimber.i('$TAG _getIntList: _value = $_value');
    int _length = _value.length;
    // List<int> _bytes = utf8.encode(_value);
    List<int> _bytes = _value.codeUnits;
    Fimber.i('$TAG _getIntList: _length = $_length, _bytes = ${_bytes}');
    return _bytes;
  }

  checkConnectedDevices() async{
    List<BluetoothDevice> connectedDevices = await FlutterBluePlus.instance.connectedDevices;
    int _length = connectedDevices.length;
    Fimber.i('checkConnectedDevices: _length = $_length');
    for(int i=0; i<_length; i++){
      await connectedDevices[i].disconnect();
    }
    _characteristicRead = _characteristicWrite = _characteristicOTA = null;
    Fimber.i('checkConnectedDevices: done!');
  }

}
