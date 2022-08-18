// @dart=2.9
//flutter build apk --release --no-sound-null-safety

import 'package:aihealer_a01/core/models/Constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:random_color/random_color.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/viewmodels/p62model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;

class p62View extends StatefulWidget {
  final int score;
  final String json;

  const p62View({Key key, this.score, this.json}) : super(key: key);

  @override
  _p62ViewState createState() => new _p62ViewState();
}

class _p62ViewState extends StateMVC<p62View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p62View:";
  p62Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p62ViewState() : super(p62Model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    // Fimber.i("$TAG initState: type = ${widget.score}, json = ${widget.json}");
    _model.initData(widget.score, widget.json);
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
          body: Stack(
            children: [
              CupertinoScrollbar(
                child: SingleChildScrollView(
                  controller: _model.scrollController,
                  child: Container(
                    width: 360.w,
                    height: 640.h,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            premiumBeginLineBgColor,
                            premiumEndLineBgColor,
                          ],
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 9.h,),
                        Container(
                          height: 105.h,
                          // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: exit:');
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 16.w,
                                      height: 16.h,
                                      margin: EdgeInsets.all(10.w,),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(icons.CommonImage.icon_x),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                              Container(
                                width: 360.w,
                                height: 105.h,
                                margin: EdgeInsets.only(left: 60.w, right: 60.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 183.w,
                                      height: 87.h,
                                      margin: EdgeInsets.only(left: 25.w, right: 25.w),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(icons.CommonImage.premium_heading),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 242.w,
                                      height: 18.h,
                                      alignment: Alignment.center,
                                      child: AutoSizeText(
                                        _model.keyString2('premium_heading1'),
                                        style: TextStyle(fontSize: 15.sp, color: Colors.white, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.1),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h,),
                        Container(
                          height: 41.h,
                          margin: EdgeInsets.only(left: 30.w, right: 30.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons.CommonImage.premium_heading2),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h,),
                        GestureDetector(
                          onTap: (){
                            Fimber.i('$TAG onTap: month:');
                            _model.setSelected(0);
                          },
                          child: Container(
                            height: 70.h,
                            margin: EdgeInsets.only(left: 30.w, right: 30.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_model.selected==0?icons.CommonImage.premium_content:icons.CommonImage.premium_content_no),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 66.w,
                                      height: 26.h,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10.w,),
                                      child: AutoSizeText(
                                        _model.keyString2('month_program'),
                                        style: TextStyle(fontSize: 22.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      width: 257.w,
                                      height: 35.h,
                                      margin: EdgeInsets.only(left: 10.w,),
                                      child: AutoSizeText(
                                        _model.keyString2('month_program2'),
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child:  Container(
                                    width: 90.w,
                                    height: 19.h,
                                    // margin: EdgeInsets.only(right: 10.w,),
                                    transform: Matrix4.translationValues(0, -2.h, 0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.premium_orange),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    child: AutoSizeText(
                                      _model.keyString2('month_bonus'),
                                      style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h,),
                        GestureDetector(
                          onTap: (){
                            Fimber.i('$TAG onTap: quater:');
                            _model.setSelected(1);
                          },
                          child: Container(
                            height: 70.h,
                            margin: EdgeInsets.only(left: 30.w, right: 30.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_model.selected==1?icons.CommonImage.premium_content:icons.CommonImage.premium_content_no),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 66.w,
                                      height: 26.h,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10.w,),
                                      child: AutoSizeText(
                                        _model.keyString2('quater_program'),
                                        style: TextStyle(fontSize: 22.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      width: 257.w,
                                      height: 35.h,
                                      margin: EdgeInsets.only(left: 10.w,),
                                      child: AutoSizeText(
                                        _model.keyString2('quater_program2'),
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child:  Container(
                                    width: 90.w,
                                    height: 19.h,
                                    // margin: EdgeInsets.only(right: 10.w,),
                                    transform: Matrix4.translationValues(0, -2.h, 0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.premium_orange),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    child: AutoSizeText(
                                      _model.keyString2('quater_bonus'),
                                      style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h,),
                        GestureDetector(
                          onTap: (){
                            Fimber.i('$TAG onTap: annual:');
                            _model.setSelected(2);
                          },
                          child: Container(
                            height: 70.h,
                            margin: EdgeInsets.only(left: 30.w, right: 30.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(_model.selected==2?icons.CommonImage.premium_content:icons.CommonImage.premium_content_no),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 66.w,
                                      height: 26.h,
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10.w,),
                                      child: AutoSizeText(
                                        _model.keyString2('annual_program'),
                                        style: TextStyle(fontSize: 22.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      width: 257.w,
                                      height: 35.h,
                                      margin: EdgeInsets.only(left: 10.w,),
                                      child: AutoSizeText(
                                        _model.keyString2('annual_program2'),
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child:  Container(
                                    width: 90.w,
                                    height: 19.h,
                                    // margin: EdgeInsets.only(right: 10.w,),
                                    transform: Matrix4.translationValues(0, -2.h, 0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.premium_orange),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    child: AutoSizeText(
                                      _model.keyString2('annual_bonus'),
                                      style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 17.h,),
                        Container(height: 7.h, color: premiumMidLineBgColor,),
                        SizedBox(height: 10.h,),
                        Container(
                          height: 25.h,
                          margin: EdgeInsets.only(left: 30.w,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 18.w,
                                height: 15.h,
                                margin: EdgeInsets.only(right: 2.w,),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(icons.CommonImage.icon_check),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: 130.w,
                                height: 25.h,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  _model.keyString2('full_diagnostic'),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Container(
                          height: 25.h,
                          margin: EdgeInsets.only(left: 30.w,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 18.w,
                                height: 15.h,
                                margin: EdgeInsets.only(right: 2.w,),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(icons.CommonImage.icon_check),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: 130.w,
                                height: 25.h,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  _model.keyString2('unlimited_family'),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Container(
                          height: 25.h,
                          margin: EdgeInsets.only(left: 30.w,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 18.w,
                                height: 15.h,
                                margin: EdgeInsets.only(right: 2.w,),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(icons.CommonImage.icon_check),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                width: 130.w,
                                height: 25.h,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  _model.keyString2('chain_clinics'),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 11.h,),
                        GestureDetector(
                          onTap: (){
                            Fimber.i('$TAG onTap: subscribe_now:');
                            _model.navigationService.push(routes.p63ViewRoute, arguments: [_model.selected]);
                          },
                          child: Container(
                            width: 360.w,
                            height: 38.h,
                            margin: EdgeInsets.only(left: 60.w, right: 60.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icons.CommonImage.premium_orange),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: AutoSizeText(
                              _model.keyString2('subscribe_now'),
                              style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        Center(
                          child: Container(
                            width: 84.w,
                            height: 14.h,
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              _model.keyString2('service_terms'),
                              style: TextStyle(fontSize: 12.sp, color: Colors.black, decoration: TextDecoration.underline, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 1.8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                      ],
                    ),
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
                    "V01-62",
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
