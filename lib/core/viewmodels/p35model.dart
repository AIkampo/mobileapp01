// @dart=2.9
import 'dart:convert' as convert;
import 'dart:math';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/flutter_chart_csx.dart';

import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../vo/groupscore_response_vo.dart';
import 'base_model.dart';

class p35model extends BaseModel {
  final TAG = "p35model:";
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController;

  bool bDataReady = true;

  int get score => _score;
  int _score;
  String _json;
  int _page;
  groupscore_response_vo _groupscore_responseVo;
  List<ChartBeanSystem> riskChartLines = <ChartBeanSystem>[];
  int _lengthRiskChartLines = 9;
  Random random = new Random();
  List<double> _dScores = <double>[];
  List<String> _descriptions = <String>[];
  int lengthPathology = 10;

  p35model() {
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

  initData(int _score, String _json, int _page) {
    // Connecting.show(context: context);
    this._score = _score;
    this._json = _json;
    var _jsonResponse;
    _jsonResponse = convert.jsonDecode(_json);
    _groupscore_responseVo = groupscore_response_vo.fromJson(_jsonResponse);
    int _length = _groupscore_responseVo.data.length;
    Fimber.i('$TAG initData: _groupscore_responseVo _length = $_length');
    _dScores.clear();
    _descriptions.clear();
    //ToDo: sort here
    for(int i=0; i<lengthPathology; i++){
      _dScores.add(_groupscore_responseVo.data[i].d);
      _descriptions.add(_groupscore_responseVo.data[i].name);
    }
    _length = _dScores.length;
    Fimber.i('$TAG initData: dScores _length = $_length');
    // Connecting.dismiss();
  }

  String getDescription(int _index){
    String _value = _descriptions[_index];
    Fimber.i('$TAG getDescription: _descriptions = $_descriptions');
    return _value;
  }

  String getImageString(int _index){
    String _value = '';
    switch(_index){
      case 0:
        _value = icons.CommonImage.organ_cycle;
        break;
      case 1:
        _value = icons.CommonImage.organ_digestion;
        break;
      case 2:
        _value = icons.CommonImage.organ_urinary;
        break;
      case 3:
        _value = icons.CommonImage.organ_endocrine;
        break;
      case 4:
        _value = icons.CommonImage.organ_nerve;
        break;
      case 5:
        _value = icons.CommonImage.organ_lymph;
        break;
      case 6:
        _value = icons.CommonImage.organ_perception;
        break;
      case 7:
        _value = icons.CommonImage.organ_skeleton;
        break;
      case 8:
        _value = icons.CommonImage.organ_breathe;
        break;
    }
    Fimber.i('$TAG getImageString: _index = $_index, _value = $_value');
    return _value;
  }

  String getSystemString(int _index){
    String _value = '';
    switch(_index){
      case 0:
        _value = keyString2('organ_cycle');
        break;
      case 1:
        _value = keyString2('organ_digestion');
        break;
      case 2:
        _value = keyString2('organ_urinary');
        break;
      case 3:
        _value = keyString2('organ_endocrine');
        break;
      case 4:
        _value = keyString2('organ_nerve');
        break;
      case 5:
        _value = keyString2('organ_lymph');
        break;
      case 6:
        _value = keyString2('organ_perception');
        break;
      case 7:
        _value = keyString2('organ_skeleton');
        break;
      case 8:
        _value = keyString2('organ_breathe');
        break;
    }
    Fimber.i('$TAG getSystemString: _value = $_value');
    return _value;
  }

/*
d 值判斷:
if (item.d <= 0.425) templist2.Add("em-worried");
else if (item.d <= 0.75) templist2.Add("em-open_mouth");
else if (item.d <= 1.0) templist2.Add("em-neutral_face");
else templist2.Add("em-smiley");
*/
  String getDChar(int _index){
    double _d = _dScores[_index];
    String _value = 'G';
    if(_d>0.425) {
      if(_d>0.75) {
        if(_d<=1.0) {
          _value = 'Y';
        }
      } else _value = 'O';
    } else _value = 'R';
    Fimber.i('$TAG getDChar: _d = $_d, _value = $_value');
    return _value;
  }

  String getDImage(int _index){
    double _d = _dScores[_index];
    String _value = icons.CommonImage.g_level;
    if(_d>0.425) {
      if(_d>0.75) {
        if(_d<=1.0) {
          _value = icons.CommonImage.y_level;
        }
      } else _value = icons.CommonImage.o_level;
    } else _value = icons.CommonImage.r_level;
    Fimber.i('$TAG getDImage: _d = $_d, _value = $_value');
    return _value;
  }

  List<double> _get10Rnd(){
    Fimber.i('$TAG _get10Rnd:');
    List<double> _rndRisk = <double>[];
    int _lengthRisk = 10;
    _rndRisk.clear();
    for(int i=0; i<_lengthRisk; i++) {
      double _rnd = random.nextDouble()*100;
      Fimber.i('$TAG _get10Rnd: i = $i, _rnd = $_rnd');
      _rndRisk.add(_rnd);
    }
    return _rndRisk;
  }

  initChart(){
    Fimber.i('$TAG _initChart:');
    riskChartLines.clear();
    for(int i=0; i<_lengthRiskChartLines; i++) {
      List<double> _rndRisk = _get10Rnd();
      ChartBeanSystem _chartLineBeanSystem = ChartBeanSystem(
        xTitleStyle: TextStyle(color: Colors.black, fontSize: 12),
        isDrawX: true,
        lineWidth: 2,
        pointRadius: 4,
        pointType: PointType.Circle,
        pointShaderColors: [Colors.blue.withOpacity(0.3), Colors.blue],
        isCurve: false,
        chartBeans: [
          ChartLineBean(x: '', y: 0, isShowPlaceImage: true),
          ChartLineBean(x: '2020/02/10', y: _rndRisk[0], isShowPlaceImage: false,),
          ChartLineBean(x: '', y: _rndRisk[1]),
          ChartLineBean(x: '', y: _rndRisk[2]),
          ChartLineBean(x: '', y: _rndRisk[3], isShowPlaceImage: false),
          ChartLineBean(x: '2020/02/18', y: _rndRisk[4], isShowPlaceImage: false),
/*
          ChartLineBean(x: '6', y: _rndRisk[5], isShowPlaceImage: false),
          ChartLineBean(x: '7', y: _rndRisk[6]),
          ChartLineBean(x: '8', y: _rndRisk[7], isShowPlaceImage: false),
          ChartLineBean(x: '9', y: _rndRisk[8]),
          ChartLineBean(x: '10', y: _rndRisk[9], isShowPlaceImage: false),

 */
        ],
        shaderColors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.1)],
        lineColor: Colors.blue,
        placehoderImageBreak: true,
      );
      riskChartLines.add(_chartLineBeanSystem);
    }
    int _length = riskChartLines.length;
    Fimber.i('$TAG _initChart: _length = $_length');
  }


  navi_home() async {
    Fimber.i('$TAG navi_home:');
  }

  _goback2Dash(){
    Fimber.i("$TAG _goback2Dash:");
    goBack();
  }

  navi_shelf() async {
    Fimber.i('$TAG navi_shelf:');
    // _navigationService.popAndPush(routes.xdShelfViewRoute,);
  }

  navi_member() async {
    Fimber.i('$TAG navi_member:');
    // globalService.currentPage = 2;
    _goback2Dash();
  }

  navi_bar() async {
    Fimber.i('$TAG navi_bar:');
  }

  int get page => _page;
}
