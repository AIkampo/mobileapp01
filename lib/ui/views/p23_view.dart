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


class p23View extends StatefulWidget {
  final int type;
  final String url;

  const p23View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p23ViewState createState() => new _p23ViewState();
}

class _p23ViewState extends StateMVC<p23View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p23View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p23ViewState() : super(p02Model()) {
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
                      SizedBox(height: 14.h,),
                      Container(
                        height: 41.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.warning),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: AutoSizeText(
                            _model.keyString2("service_heading"),
                            style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Container(
                        height: 363.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 36.w, right: 39.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              _model.keyString2("service_content1"),
                              maxLines: 6,
                              style: TextStyle(fontSize: 15.5.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                              textAlign: TextAlign.start,
                            ),
                            AutoSizeText(
                              _model.keyString2("service_content2"),
                              maxLines: 3,
                              style: TextStyle(fontSize: 15.5.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                              textAlign: TextAlign.start,
                            ),
                            AutoSizeText(
                              _model.keyString2("service_content3"),
                              maxLines: 3,
                              style: TextStyle(fontSize: 15.5.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                              textAlign: TextAlign.start,
                            ),
                            AutoSizeText(
                              _model.keyString2("service_content4"),
                              maxLines: 4,
                              style: TextStyle(fontSize: 15.5.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h,),
                      Container(
                        height: 17.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 47.w, right: 0.w),
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
                                value: _model.bAgree,
                                onChanged: (bool value) {
                                  Fimber.i("$TAG: bAgree: value = $value");
                                  _model.onCheckAgree(value);
                                },
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Container(
                              width: 146.w,
                              height: 17.h,
                              child: AutoSizeText(
                                _model.keyString2("service_agree"),
                                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Container(
                        height: 17.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 47.w, right: 0.w),
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
                                value: _model.bNoMore,
                                onChanged: (bool value) {
                                  Fimber.i("$TAG: service_nomore: value = $value");
                                  _model.onCheckNoMore(value);
                                },
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Container(
                              width: 146.w,
                              height: 17.h,
                              child: AutoSizeText(
                                _model.keyString2("service_nomore"),
                                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_next_step: _model.bNoMore = ${_model.bNoMore}, _model.bAgree = ${_model.bAgree}');
                          if(!_model.bNoMore&&!_model.bAgree) {
                            _model.navigationService.popToRootAndReplace(routes.MainRoute,);
                          } else
                          if(!_model.bNoMore)
                            _model.navigationService.push(routes.p62ViewRoute,);
                          else
                            _model.navigationService.push(routes.p25ViewRoute,);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 47.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icons.CommonImage.btn_next_step),
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
                    "V01-23",
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
