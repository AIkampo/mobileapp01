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


class p27View extends StatefulWidget {
  final int type;
  final String url;

  const p27View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p27ViewState createState() => new _p27ViewState();
}

class _p27ViewState extends StateMVC<p27View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p27View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p27ViewState() : super(p02Model()) {
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
                      SizedBox(height: 23.h,),
                      Container(
                        height: 307.5.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.border_double),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 73.h,
                              margin: EdgeInsets.only(left: 12.w, right: 9.w, top: 17.h,),
                              child: AutoSizeText(
                                _model.keyString2("diag_before"),
                                style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                                textAlign: TextAlign.start,
                                maxLines: 5,
                              ),
                            ),
                            Container(
                              // width: 307.5.w,
                              height: 78.h,
                              margin: EdgeInsets.only(left: 27.08.w, right: 26.1.w, top: 15.h, bottom: 13.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 78.h,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.border_double),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 29.w,
                                          height: 29.h,
                                          child: Image.asset(icons.CommonImage.pregnate, fit: BoxFit.fitHeight,),
                                        ),
                                        SizedBox(height: 3.h,),
                                        Container(
                                          width: 42.w,
                                          height: 13.5.h,
                                          child: AutoSizeText(
                                            _model.keyString2('diag_pregnate'),
                                            style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 60.w,
                                    height: 78.h,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.border_double),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 22.w,
                                              height: 22.h,
                                              child: Image.asset(icons.CommonImage.no_smoking, fit: BoxFit.fitHeight,),
                                            ),
                                            Container(
                                              width: 22.w,
                                              height: 22.h,
                                              child: Image.asset(icons.CommonImage.no_drink, fit: BoxFit.fitHeight,),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 7.h,),
                                        Container(
                                          width: 42.w,
                                          height: 13.5.h,
                                          child: AutoSizeText(
                                            _model.keyString2('diag_nosmoking'),
                                            style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 60.w,
                                    height: 78.h,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.border_double),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 29.w,
                                          height: 29.h,
                                          child: Image.asset(icons.CommonImage.exercise, fit: BoxFit.fitHeight,),
                                        ),
                                        SizedBox(height: 3.h,),
                                        Container(
                                          width: 42.w,
                                          height: 13.5.h,
                                          child: AutoSizeText(
                                            _model.keyString2('diag_exercise'),
                                            style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // width: 307.5.w,
                              height: 78.h,
                              margin: EdgeInsets.only(left: 27.08.w, right: 26.1.w, top: 15.h, bottom: 13.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 60.w,
                                    height: 78.h,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.border_double),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 29.w,
                                          height: 29.h,
                                          child: Image.asset(icons.CommonImage.icon_24h, fit: BoxFit.fitHeight,),
                                        ),
                                        SizedBox(height: 3.h,),
                                        Container(
                                          width: 42.w,
                                          height: 27.h,
                                          child: AutoSizeText(
                                            _model.keyString2('diag_24h'),
                                            style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: diag_metal:');
                                      _model.navigationService.push(routes.p28ViewRoute,);
                                    },
                                    child: Container(
                                      width: 60.w,
                                      height: 78.h,
                                      decoration: BoxDecoration(
                                        // color: Colors.green,
                                        image: DecorationImage(
                                          image: AssetImage(icons.CommonImage.border_double),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 22.w,
                                                height: 22.h,
                                                child: Image.asset(icons.CommonImage.necklacce_black, fit: BoxFit.fitHeight,),
                                              ),
                                              Container(
                                                width: 22.w,
                                                height: 22.h,
                                                child: Image.asset(icons.CommonImage.bracelet_black, fit: BoxFit.fitHeight,),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.h,),
                                          Container(
                                            width: 42.w,
                                            height: 27.h,
                                            child: AutoSizeText(
                                              _model.keyString2('diag_metal'),
                                              style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: diag_food:');
                                      _model.navigationService.push(routes.p26ViewRoute,);
                                    },
                                    child: Container(
                                      width: 60.w,
                                      height: 78.h,
                                      decoration: BoxDecoration(
                                        // color: Colors.green,
                                        image: DecorationImage(
                                          image: AssetImage(icons.CommonImage.border_double),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 25.w,
                                            height: 25.h,
                                            child: Image.asset(icons.CommonImage.food, fit: BoxFit.fitHeight,),
                                          ),
                                          SizedBox(height: 3.h,),
                                          Container(
                                            width: 42.w,
                                            height: 13.5.h,
                                            child: AutoSizeText(
                                              _model.keyString2('diag_food'),
                                              style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 23.5.h,),
                      Container(
                        height: 47.5.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Fimber.i('$TAG onTap: cancel_rect:');
                              },
                              child: Container(
                                height: 47.5.h,
                                width: 119.5.w,
                                child: Image.asset(icons.CommonImage.cancel_rect, fit: BoxFit.fill,),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Fimber.i('$TAG onTap: start_diag:');
                                _model.navigationService.push(routes.p29ViewRoute,);
                              },
                              child: Container(
                                height: 47.5.h,
                                width: 120.w,
                                child: Image.asset(icons.CommonImage.start_diag, fit: BoxFit.fill,),
                              ),
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
                    "V01-27",
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
