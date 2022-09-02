// @dart=2.9
//flutter build apk --release --no-sound-null-safety

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:random_color/random_color.dart';
import '../../core/services/global_service.dart';
import '../../locator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../core/viewmodels/template_model.dart';
import '../../ui/views/base_view.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../core/viewmodels/p02_model.dart';
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;


class p25View extends StatefulWidget {
  final int type;
  final String url;

  const p25View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p25ViewState createState() => new _p25ViewState();
}

class _p25ViewState extends StateMVC<p25View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p25View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p25ViewState() : super(p02Model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    Fimber.i("$TAG initState: type = ${widget.type}, url = ${widget.url}");
    _model.initData(widget.type, widget.url);
    _textColor = _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5);
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    Fimber.i('$TAG afterFirstLayout:');
  }

  @override
  void dispose() {
    Fimber.i('$TAG dispose:');
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _myContext = context;
    return BaseView(
      model: _model,
      mvcBuilder: (_, __) {
        return _model.bDataReady? Scaffold(
          key: _model.scaffoldKey,
          appBar: AppBar(
            backgroundColor: lightBgColor,
            elevation: 0.5,
            actions: <Widget>[
            ],
          ),
          body: Stack(
            children: [
              Container(
                height: 640.h,
                width: 360.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(icons.CommonImage.bg_app),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              CupertinoScrollbar(
                child: SingleChildScrollView(
                  controller: _model.scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 57.h,
                        width: 360.w,
                        child: Image.asset(icons.CommonImage.buildings, fit: BoxFit.fitHeight,),
                      ),
                      Container(
                        height: 9.h,
                        width: 360.w,
                        child: Image.asset(icons.CommonImage.greybar, fit: BoxFit.fill,),
                      ),
                      SizedBox(height: 15.h,),
                      Container(
                        height: 24.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 29.w,),
                        child: AutoSizeText(
                          _model.keyString2('service_what'),
                          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 22.h,),
                      Container(
                        width: 360.w,
                        height: 43.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 19.w, right: 0.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.service_border),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 23.w,
                              height: 23.h,
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.heart_diag),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: 135.w,
                              height: 19.h,
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                _model.keyString2('service_diag'),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG service_diag:');
                                _model.navigationService.push(routes.p27ViewRoute,);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: 360.w,
                        height: 43.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 19.w, right: 0.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.service_border),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 23.w,
                              height: 23.h,
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.apple_black),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: 135.w,
                              height: 19.h,
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                _model.keyString2('service_guide'),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG service_guide:');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: 360.w,
                        height: 43.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 19.w, right: 0.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.service_border),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 23.w,
                              height: 23.h,
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.report_view),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: 135.w,
                              height: 19.h,
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                _model.keyString2('service_history'),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG service_history:');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: 360.w,
                        height: 43.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 19.w, right: 0.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.service_border),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 23.w,
                              height: 23.h,
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.chain_clinics),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: 135.w,
                              height: 19.h,
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                _model.keyString2('service_clinic'),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG service_clinic:');
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Container(
                        width: 360.w,
                        height: 43.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 19.w, right: 0.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.service_border),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 23.w,
                              height: 23.h,
                              margin: EdgeInsets.only(right: 15.w),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.services),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: 135.w,
                              height: 19.h,
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                _model.keyString2('service_head'),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG service_head:');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              kDebugMode?Align(
                alignment: Alignment.bottomRight,
                child: Container(height: 43,
                  padding: const EdgeInsets.only(right: 10),
                  color: Colors.transparent,
                  alignment: Alignment.bottomRight,
                  child: AutoSizeText(
                    "V01-25",
                    style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                    textAlign: TextAlign.end,
                  ),
                ),
              ):Container(),
            ],
          )
        ):
        _model.globalService.getMyLoading();
      },
    );
  }
}
