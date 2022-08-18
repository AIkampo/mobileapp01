// @dart=2.9
import 'dart:convert' as convert;
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/flutter_chart_csx.dart';

import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../vo/groupscore_response_vo.dart';
import 'base_model.dart';

class p51Model extends BaseModel {
  final TAG = "p51Model:";
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController;

  bool bDataReady = true;
  int _score;
  String _json;

  int selected = 1;
  bool _bDay = false;
  bool _bPeriod7 = false;
  bool _bPeriod30 = false;
  bool _bPeriod90 = false;


  p51Model() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
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

  initData(int _score, String _json) {
    // Connecting.show(context: context);
    this._score = _score;
    this._json = _json;
    // Connecting.dismiss();
  }

  setBDay(bool _value){
    _bDay = _value;
    notifyListeners();
  }

  bool getBDay(){
    return _bDay;
  }


  setSelected(int _value) async {
    Fimber.i('$TAG setSelected: _value = $_value');
    selected = _value;
    notifyListeners();
  }

  String getReportDate(){
    var nowTime = DateTime.now();
    const reportDateFormat = 'yyyy年MM月dd日';
    return DateFormat(reportDateFormat).format(nowTime);
  }

  String getReportDate2(int _value){
    var nowTime = DateTime.now();
    var nextTIme = nowTime.subtract(Duration(days: _value));
    const reportDateFormat = 'yyyy年MM月dd日';
    return DateFormat(reportDateFormat).format(nextTIme);
  }

  List<String> getPastReportDates(int _value){
    List<String> _list = <String>[];
    _list.clear();
    const reportDateFormat = 'yyyy年MM月dd日';
    var nowTime = DateTime.now();
    for(int i=0; i<_value; i++){
      var nextTIme = nowTime.subtract(Duration(days: i));
      _list.add(DateFormat(reportDateFormat).format(nextTIme));
    }
    Fimber.i('$TAG getPastReportDates: _list_length = ${_list.length}');
    return _list;
  }

  setPeriod7(bool _value){
    _bPeriod7 = _value;
    Fimber.i('$TAG setPeriod7: _bPeriod7 = $_bPeriod7');
    notifyListeners();
  }

  bool getPeriod7(){
    Fimber.i('$TAG getPeriod7: _bPeriod7 = $_bPeriod7');
    return _bPeriod7;
  }

  setPeriod30(bool _value){
    _bPeriod30 = _value;
    Fimber.i('$TAG setPeriod30: _bPeriod30 = $_bPeriod30');
    notifyListeners();
  }

  bool getPeriod30(){
    Fimber.i('$TAG getPeriod30: _bPeriod30 = $_bPeriod30');
    return _bPeriod30;
  }

  setPeriod90(bool _value){
    _bPeriod90 = _value;
    Fimber.i('$TAG setPeriod90: _bPeriod90 = $_bPeriod90');
    notifyListeners();
  }

  bool getPeriod90(){
    Fimber.i('$TAG getPeriod90: _bPeriod90 = $_bPeriod90');
    return _bPeriod90;
  }

}
