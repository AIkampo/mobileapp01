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


class p04View extends StatefulWidget {
  final int type;
  final String url;

  const p04View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p04ViewState createState() => new _p04ViewState();
}

class _p04ViewState extends StateMVC<p04View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p04View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p04ViewState() : super(p02Model()) {
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
                      SizedBox(height: 20.h,),
                      Container(
                        height: 41.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Stack(
                          children: [
                            Image.asset(icons.CommonImage.warning, fit: BoxFit.fill,),
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20.h,
                                    width: 25.w,
                                    alignment: Alignment.center,
                                    child: Image.asset(icons.CommonImage.rectangle_371, fit: BoxFit.fitHeight,),
                                  ),
                                  SizedBox(width: 4.w,),
                                  Container(
                                    height: 24.h,
                                    width: 80.w,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      _model.keyString2("warnings"),
                                      style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 229.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 32.92.w, right: 33.9.w),
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.waring_details),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 12.08.w, right: 11.1.w, top: 13.44.h, bottom: 13.76.h),
                          child: AutoSizeText(
                            _model.keyString2("warnings_content"),
                            style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Arial', height: 2.1),
                            textAlign: TextAlign.start,

                            maxLines: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 17.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 47.w, right: 230.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 12.w,
                              height: 12.h,
                              child: Checkbox(
                                focusColor: Colors.blue,
                                activeColor: Colors.blue,
                                value: _model.bShowOnce,
                                onChanged: (bool value) {
                                  Fimber.i("$TAG: bShowOnce: value = $value");
                                  _model.onCheck(value);
                                },
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Container(
                              width: 56.w,
                              height: 17.h,
                              child: AutoSizeText(
                                _model.keyString2("show_once"),
                                style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 80.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_has_read:');
                          _model.navigationService.push(routes.p05ViewRoute);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 47.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icons.CommonImage.btn_has_read),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
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
                    "V01-04",
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
