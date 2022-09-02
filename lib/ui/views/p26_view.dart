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


class p26View extends StatefulWidget {
  final int type;
  final String url;

  const p26View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p26ViewState createState() => new _p26ViewState();
}

class _p26ViewState extends StateMVC<p26View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p26View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p26ViewState() : super(p02Model()) {
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
                      SizedBox(height: 24.h,),
                      Container(
                        height: 41.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.nodiag_rect_small),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: AutoSizeText(
                            _model.keyString2("nodiag_heading"),
                            style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      Container(
                        height: 201.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.nodiag_rect),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 96.h,
                              width: 280.w,
                              margin: EdgeInsets.only(left: 13.w, right: 7.w, top:8.h),
                              alignment: Alignment.centerLeft,
                              child: AutoSizeText(
                                _model.keyString2("nodiag_content"),
                                style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.start,
                                maxLines: 6,
                              ),
                            ),
                            SizedBox(height: 16.h,),
                            Container(
                              height: 54.h,
                              width: 280.w,
                              margin: EdgeInsets.only(left: 51.w, right: 63.w,),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 40.h,
                                      width: 40.w,
                                      child: Image.asset(icons.CommonImage.bluetooth, fit: BoxFit.fill,),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 18.h,
                                      width: 116.w,
                                      alignment: Alignment.bottomCenter,
                                      child: Image.asset(icons.CommonImage.dash, fit: BoxFit.fitWidth,),
                                    ),
                                  ),
                                  Container(
                                    height: 54.h,
                                    width: 30.w,
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(icons.CommonImage.myapp, fit: BoxFit.fill,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: close:');
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 47.5.h,
                          width: 360.w,
                          margin: EdgeInsets.only(left: 120.w, right: 120.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons.CommonImage.close),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 137.h,),
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
                    "V01-26",
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
