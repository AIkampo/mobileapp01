// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../core/viewmodels/splash_model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';

class SplashView extends StatefulWidget {
  SplashView();

  @override
  _SplashViewState createState() => new _SplashViewState();
}

class _SplashViewState extends StateMVC<SplashView>
    with SingleTickerProviderStateMixin {
  SplashModel _model;

  _SplashViewState() : super(SplashModel()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    _model.start();
    _model.bVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 0.66;
    return BaseView(
      model: _model,
      mvcBuilder: (_, __) =>
        Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(icons.CommonImage.bg_app),
                fit: BoxFit.fill,
              ),
            ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: size,
                    height: size,
                    alignment: Alignment.center,
                    child: Image.asset(
                      icons.CommonImage.logo,
                    ),
                  ),
              ),
              kDebugMode?Align(
                alignment: Alignment.bottomRight,
                child: Container(height: 43.h,
                  padding:  EdgeInsets.only(right: 10.w),
                  color: Colors.transparent,
                  alignment: Alignment.bottomRight,
                  child: AutoSizeText(
                    "V01-01",
                    style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                    textAlign: TextAlign.end,
                  ),
                ),
              ):Container(),
            ],
          ),
        )
      );
  }
}
