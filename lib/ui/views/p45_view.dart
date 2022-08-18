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
import '../../core/viewmodels/p45Model.dart';
import '../../locator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../core/viewmodels/template_model.dart';
import '../../ui/views/base_view.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../core/viewmodels/p02_model.dart';
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter_chart_csx/flutter_chart_csx.dart';

class p45View extends StatefulWidget {
  final int score;
  final String json;

  const p45View({Key key, this.score, this.json}) : super(key: key);

  @override
  _p45ViewState createState() => new _p45ViewState();
}

class _p45ViewState extends StateMVC<p45View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p45View:";
  p45Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p45ViewState() : super(p45Model()) {
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

  Widget _buildFoodGood(bool _good){
    List<Widget> _widgets = _buildFoodGoodlist(_good);
    return GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 90.w / 26.h,
          mainAxisSpacing: 9.h,
          crossAxisSpacing: 60.w,
        ),
        physics: NeverScrollableScrollPhysics(),
        children: _widgets,
    );

  }

  List<Widget>  _buildFoodGoodlist(bool _good){
    List<Widget> _widgets = <Widget>[];
    _widgets.clear();
    int _length = 10;
    for(int i=0; i<_length; i++){
      Widget _widget = Container(
        width: 90.w,
        height: 26.h,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage(icons.CommonImage.bg_transparent_rect),
          //   fit: BoxFit.fill,
          // ),
          borderRadius: BorderRadius.circular(5),
          border : Border.all(
            color: btnBgColor,
            width: 1,),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 4.w,),
        child: AutoSizeText(
          (i+1).toString() + '.' + _model.getFoodName(_good?i:i+10),
          maxLines: 1,
          minFontSize: 14.sp,
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
          textAlign: TextAlign.start,
        ),
      );
      _widgets.add(_widget);
    }
    return _widgets;
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
                      SizedBox(height: 22.h,),
                      Container(
                        width: 360.w,
                        height: 58.h,
                        margin: EdgeInsets.only(left: 60.w, right: 62.w),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: 212.w,
                                height: 34.h,
                                // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(icons.CommonImage.bg_grey_rectangle),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 62.w, right: 34.w),
                                child: AutoSizeText(
                                  _model.keyString2('health_food_guidelines'),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              width: 60.w,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.bg_vegetable_black),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              padding: EdgeInsets.all(13.w,),
                              child: Image.asset(icons.CommonImage.vegetable_black, fit: BoxFit.fill,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h,),
                      Container(
                        width: 360.w,
                        height: 34.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_organge_rect),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _model.keyString2('food_good'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Container(
                        width: 360.w,
                        height: 166.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        // color: Colors.green,
                        child: _buildFoodGood(true),
                      ),
                      SizedBox(height: 18.h,),
                      Container(
                        width: 360.w,
                        height: 34.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_organge_rect),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _model.keyString2('food_ng'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Container(
                        width: 360.w,
                        height: 166.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        child: _buildFoodGood(false),
                      ),
                      SizedBox(height: 18.h,),
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
                    "V01-45",
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
