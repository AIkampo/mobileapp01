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

class p46Model extends BaseModel {
  final TAG = "p46Model:";
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController;

  bool bDataReady = false;
  int _page;
  String _json;
  groupscore_response_vo _groupscore_responseVo;
  List<ChartBeanSystem> riskChartLines = <ChartBeanSystem>[];
  Random random = new Random();
  int lengthGood = 10;
  String title, subtitle, iconTitle, bgTitle;

  p46Model() {
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

  initData(int _page, String _json) {
    // Connecting.show(context: context);
    this._page = _page;
    this._json = _json;
    var _jsonResponse;
    _jsonResponse = convert.jsonDecode(_json);
    _groupscore_responseVo = groupscore_response_vo.fromJson(_jsonResponse);
    lengthGood = _groupscore_responseVo.data.length;
    Fimber.i('$TAG initData: _groupscore_responseVo lengthGood = $lengthGood');
    switch(_page){
      case 46:
        lengthGood = 9;
        title = 'health_micronutrient_guidelines';
        subtitle = 'micronutrient_good';
        bgTitle = icons.CommonImage.bg_lab;
        iconTitle = icons.CommonImage.lab;
        break;
      case 47:
        lengthGood = 4;
        title = 'health_energy_guidelines';
        subtitle = 'energy_good';
        bgTitle = icons.CommonImage.bg_colors;
        iconTitle = icons.CommonImage.colors;
        break;
      case 48:
        lengthGood = 9;
        title = 'health_acupuncture_guidelines';
        subtitle = 'acupuncture_good';
        bgTitle = icons.CommonImage.bg_acupuncture;
        iconTitle = icons.CommonImage.acupuncture;
        break;
      case 49:
        lengthGood = 9;
        title = 'health_diamond_guidelines';
        subtitle = 'diamond_good';
        bgTitle = icons.CommonImage.bg_diamond_black;
        iconTitle = icons.CommonImage.diamond_black;
        break;

    }
    bDataReady = true;
    notifyListeners();
    // Connecting.dismiss();
  }


  String getGoodName(int _index){
    String _value = _groupscore_responseVo.data[_index].name;
    Fimber.i('$TAG getFoodName: _index = $_index, _value = $_value');
    return _value;
  }



}
