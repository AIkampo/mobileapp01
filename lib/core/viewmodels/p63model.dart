// @dart=2.9
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import 'base_model.dart';

class p63Model extends BaseModel {
  final TAG = "p63Model:";
  final NavigationService _navigationService = locator<NavigationService>();
  ScrollController scrollController;

  bool bDataReady = true;
  int _program;
  String _json;


  p63Model() {
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

  initData(int _program, String _json) {
    // Connecting.show(context: context);
    this._program = _program;
    this._json = _json;
    // Connecting.dismiss();
  }

}
