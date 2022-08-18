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

class p120Model extends BaseModel {
  final TAG = "p120Model:";
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController;

  bool bDataReady = true;
  int _score;
  String _json;



  p120Model() {
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


}
