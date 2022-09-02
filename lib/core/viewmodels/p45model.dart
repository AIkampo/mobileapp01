// @dart=2.9
import 'dart:convert' as convert;
import 'dart:math';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/flutter_chart_csx.dart';

import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import '../../vo/groupscore_response_vo.dart';
import 'base_model.dart';

class p45Model extends BaseModel {
  final TAG = "p45Model:";
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController;

  bool bDataReady = true;
  int _score;
  String _json;
  groupscore_response_vo _groupscore_responseVo;
  List<ChartBeanSystem> riskChartLines = <ChartBeanSystem>[];
  int _lengthRiskChartLines = 9;
  Random random = new Random();
  List<double> _dScores = <double>[];
  List<String> _descriptions = <String>[];
  int lengthPathology = 10;

  p45Model() {
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
    var _jsonResponse;
    _jsonResponse = convert.jsonDecode(_json);
    _groupscore_responseVo = groupscore_response_vo.fromJson(_jsonResponse);
    int _length = _groupscore_responseVo.data.length;
    Fimber.i('$TAG initData: _groupscore_responseVo _length = $_length');
    // Connecting.dismiss();
  }

  String getDescription(int _index){
    String _value = _descriptions[_index];
    Fimber.i('$TAG getDescription: _descriptions = $_descriptions');
    return _value;
  }

  String getFoodName(int _index){
    String _value = _groupscore_responseVo.data[_index].name;
    Fimber.i('$TAG getFoodName: _index = $_index, _value = $_value');
    return _value;
  }

}
