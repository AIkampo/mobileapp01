// @dart=2.9
//flutter build apk --release --no-sound-null-safety

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/flutter_chart_csx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:random_color/random_color.dart';

import '../../core/viewmodels/p35model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p35to43View extends StatefulWidget {
  final int score;
  final String json;
  final int page;

  const p35to43View({Key key, this.score, this.json, this.page}) : super(key: key);

  @override
  _p35to43ViewState createState() => new _p35to43ViewState();
}

class _p35to43ViewState extends StateMVC<p35to43View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p35to43View:";
  p35model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;
  int _index = 0;


  _p35to43ViewState() : super(p35model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    // Fimber.i("$TAG initState: type = ${widget.score}, json = ${widget.json}");
    _model.initData(widget.score, widget.json, widget.page);
    _index = widget.page - 35;
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

  Widget _buildSingleChartLine(context, _index,) {
    int _length = _model.riskChartLines.length;
    Fimber.i('$TAG _buildSingleChartLine: _index = $_index, _length = $_length');
    if(_length==0) _model.initChart();
    Widget _chartLine = Stack(
      children: [
        ChartLine(
          backgroundColor: Colors.white,
          chartBeanSystems: [_model.riskChartLines[_index]],
          size: Size(265.w, 157.h),
          baseBean: BaseBean(
            // isShowBorderTop: true,
            // isShowBorderRight: true,
            // isLeftYDialSub: true,
            basePadding: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 20.w, right: 0.w),
            isShowX: true,
            isShowYScale: true,
            isShowHintX: true,
            isHintLineImaginary: true,
            xColor: Colors.black,
            yColor: Colors.black,
            rulerWidth: 0,
            yMax: 100,
            xyLineWidth: 0.5,
            yDialValues: [
              DialStyleY(
                title: '0',
                titleStyle: TextStyle(fontSize: 10.0.sp, color: Colors.black),
                positionRetioy: 0 / 100.0,
              ),
              DialStyleY(
                title: '20',
                titleStyle: TextStyle(fontSize: 10.0.sp, color: Colors.black),
                positionRetioy: 20 / 100.0,
              ),
              DialStyleY(
                title: '40',
                titleStyle: TextStyle(fontSize: 10.0.sp, color: Colors.black),
                positionRetioy: 40 / 100.0,
              ),
              DialStyleY(
                title: '60',
                titleStyle: TextStyle(fontSize: 10.0.sp, color: Colors.black),
                positionRetioy: 60 / 100.0,
              ),
              DialStyleY(
                title: '80',
                titleStyle: TextStyle(fontSize: 10.0.sp, color: Colors.black),
                positionRetioy: 80 / 100.0,
              ),
              DialStyleY(
                title: '100',
                titleStyle: TextStyle(fontSize: 10.0.sp, color: Colors.black),
                positionRetioy: 100 / 100.0,
              ),
            ],

          ),
        ),
      ],
    );
    return _chartLine;
  }

  Widget _buildPathology(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 24.h,
          decoration: BoxDecoration(
            color: greyBgColor,
            shape: BoxShape.rectangle,
            // borderRadius: BorderRadius.circular(2),
            border : Border(
              top: BorderSide(width: 1.0.w, color: Colors.black),
              left: BorderSide(width: 1.0.w, color: Colors.black),
              right: BorderSide(width: 1.0.w, color: Colors.black),
              // bottom: BorderSide(width: 1.0.w, color: Colors.black),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 205.w,
                alignment: Alignment.center,
                child: AutoSizeText(
                  _model.keyString2('pathology'),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 1.w,
                color: Colors.black,
              ),
              Container(
                width: 90.w,
                alignment: Alignment.center,
                child: AutoSizeText(
                  _model.keyString2('morbidity_index'),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        Container(
          height: 200.h,
          // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: _get10Rows(),
          ),
        ),
      ],
    );
  }

  List<Widget> _get10Rows(){
    List<Widget> widgets = <Widget>[];
    widgets.clear();
    int _length = _model.lengthPathology;
    for(int i=0; i<_length; i++){
      Widget _widget = Container(
        height: 20.h,
        decoration: BoxDecoration(
          // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(2),
          border : Border(
            top: BorderSide(width: 1.0.w, color: Colors.black),
            left: BorderSide(width: 1.0.w, color: Colors.black),
            right: BorderSide(width: 1.0.w, color: Colors.black),
            bottom: BorderSide(width: i==9?1.0.w:0.w, color: Colors.black),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 205.w,
              alignment: Alignment.center,
              child: AutoSizeText(
                _model.getDescription(i),
                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 1.w,
              color: Colors.black,
            ),
            Container(
              width: 90.w,
              // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
              padding: EdgeInsets.all(2.5.h),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(_model.getDImage(i), fit: BoxFit.fitHeight,),
                  ),
                  Center(
                    child: AutoSizeText(
                      _model.getDChar(i),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
      widgets.add(_widget);
    }
    return widgets;
  }

  String getLevelBg(int _index){
    String _level = icons.CommonImage.bg_g_level;
    int _score = widget.score;
    if(_score<70){
      if(_score<50) {
        if(_score<20) {
          _level = icons.CommonImage.bg_r_level;
        } else _level = icons.CommonImage.bg_o_level;
      } else _level = icons.CommonImage.bg_y_level;
    }
    return _level;
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
                      SizedBox(height: 16.h,),
                      Container(
                        height: 141.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 31.w, right: 31.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getLevelBg(_index)), fit: BoxFit.fill,),),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 24.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 77.w,
                                  height: 92.h,
                                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(_model.getImageString(_index)), fit: BoxFit.fill,),),
                                ),
                                Container(
                                  width: 106.w,
                                  height: 29.h,
                                  child: AutoSizeText(
                                    _model.getSystemString(_index),
                                    style: TextStyle(fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.w,),
                            Container(
                              width: 123.w,
                              height: 110.h,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 74.w,
                                    height: 19.h,
                                    child: AutoSizeText(
                                      _model.keyString2('ref_points'),
                                      style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 95.w,
                                    height: 42.h,
                                    child: AutoSizeText(
                                      widget.score.toString() + _model.keyString2('points'),
                                      style: TextStyle(fontSize: 40.sp, color: minusColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 62.w,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(2),
                                      border : Border.all(
                                        color: cycleBgColorStart,
                                        width: 1,),
                                      ),
                                    child: AutoSizeText(
                                      '-4',
                                      style: TextStyle(fontSize: 14.sp, color: minusColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 31.w,),
                          ],
                        ),
                      ),
                      Container(
                        height: 21.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 31.w, right: 31.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: greyBgColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                          border : Border.all(
                            color: Colors.black,
                            width: 0.6.w,),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 94.w,
                              height: 17.h,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                _model.keyString2('diag_date_now'),
                                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.center,
                              ),),
                            Container(
                              width: 94.w,
                              height: 17.h,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                '2022/2/18',
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.center,
                              ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.h,),
                      Container(
                        height: 38.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 31.w, right: 31.w),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Image.asset(icons.CommonImage.heading, fit: BoxFit.fill,),
                            Center(
                              child: AutoSizeText(
                                _model.keyString2("diag_date_now_report"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 11.h,),
                      Container(
                        height: 224.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 31.w, right: 31.w),
                        alignment: Alignment.center,
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        child: _buildPathology(),
                      ),
                      SizedBox(height: 14.h,),
                      Container(
                        height: 34.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 31.w, right: 31.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.heading),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: AutoSizeText(
                            _model.keyString2("health_trend_chart"),
                            style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Container(
                        height: 157.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 44.w, right: 60.82.w),
                        alignment: Alignment.center,
                        child: _buildSingleChartLine(_myContext, 0),
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
                    "V01-" + widget.page.toString(),
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
