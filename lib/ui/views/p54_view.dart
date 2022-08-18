// @dart=2.9
//flutter build apk --release --no-sound-null-safety

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

import '../../core/viewmodels/p51model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p54View extends StatefulWidget {
  final int score;
  final String json;

  const p54View({Key key, this.score, this.json}) : super(key: key);

  @override
  _p54ViewState createState() => new _p54ViewState();
}

class _p54ViewState extends StateMVC<p54View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p54View:";
  p51Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p54ViewState() : super(p51Model()) {
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

  Widget _buildNowDuePoints(int _points){
    var nowTime = DateTime.now();
    String _year = nowTime.year.toString();
    StringBuffer _sb = StringBuffer();
    _sb.write(_year);
    _sb.write('/12/31');
    String _due_point = sprintf(_model.keyString2('points_due'), [_points.toString()]);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          _sb.toString(),
          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), ),
          textAlign: TextAlign.center,
        ),
        AutoSizeText(
          _due_point,
          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNextDuePoints(int _points){
    var nowTime = DateTime.now();
    String _year = (nowTime.year+1).toString();
    StringBuffer _sb = StringBuffer();
    _sb.write(_year);
    _sb.write('/12/31');
    String _due_point = sprintf(_model.keyString2('points_due'), [_points.toString()]);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          _sb.toString(),
          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), ),
          textAlign: TextAlign.center,
        ),
        AutoSizeText(
          _due_point,
          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPointsWidgets(int _index){
    String _iconString, _pointString, _actionString;
    Fimber.i('$TAG _buildPointsWidgets: _index = $_index');
    switch(_index){
      case 0:
        _iconString = icons.CommonImage.history;
        _pointString = 'points_record';
        _actionString = icons.CommonImage.icon_right;
        break;
      case 1:
        _iconString = icons.CommonImage.point;
        _pointString = 'points_changes';
        _actionString = icons.CommonImage.support;
        break;
      case 2:
        _iconString = icons.CommonImage.report;
        _pointString = 'points_changes_record';
        _actionString = icons.CommonImage.support;
        break;
      case 3:
        _iconString = icons.CommonImage.gift;
        _pointString = 'points_donate';
        _actionString = icons.CommonImage.icon_right;
        break;
      case 4:
        _iconString = icons.CommonImage.shop;
        _pointString = 'shop_mall';
        _actionString = icons.CommonImage.support;
        break;
      case 5:
        _iconString = icons.CommonImage.email;
        _pointString = 'invite_friend';
        _actionString = icons.CommonImage.icon_right;
        break;
      default:
        _iconString = icons.CommonImage.history;
        _pointString = 'points_record';
        _actionString = icons.CommonImage.icon_right;
        break;

    }
    Widget _image = Container(
      width: 22.w,
      height: 22.h,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_iconString),
          fit: BoxFit.fill,
        ),
      ),
    );
    Widget _text = Container(
      width: 270.w,
      height: 22.h,
      child: AutoSizeText(
        _model.keyString2(_pointString),
        style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
        // textAlign: TextAlign.center,
      ),
    );
    Widget _icon = Container(
      width: 18.w,
      height: 20.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_actionString),
          fit: BoxFit.fill,
        ),
      ),
    );
    return Container(
      width: 360.w,
      height: 22.h,
      // color: Colors.green,
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _image,
          _text,
          _icon,
        ],
      ),
    );
  }

  List<Widget> _getPointsWidgets(){
    List<Widget> _widgets = <Widget>[];
    Widget _widget;
    _widgets.clear();
    for(int i=0; i<6; i++){
      _widget = Container(
        height: 1.h,
        margin: EdgeInsets.only(left: 2.w, right: 2.w),
        color: greyLineBgColor,
      );
      _widgets.add(_widget);
      _widget = SizedBox(height: 6.h,);
      _widgets.add(_widget);
      _widget = _buildPointsWidgets(i);
      _widgets.add(_widget);
      _widget = SizedBox(height: 4.h,);
      _widgets.add(_widget);
    }
    _widget = Container(
      height: 1.h,
      margin: EdgeInsets.only(left: 2.w, right: 2.w),
      color: greyLineBgColor,
    );
    _widgets.add(_widget);
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
                        height: 39.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.report_heading),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        child: AutoSizeText(
                          _model.keyString2('mypoints'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      Container(
                        width: 360.w,
                        height: 150.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.circle_outer),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 105.w, right: 105.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 18.h,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                _model.keyString2('points_now'),
                                style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 28.h,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    '1888',
                                    style: TextStyle(fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.circle_p),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 84.w,
                              height: 1.h,
                              color: greyLineBgColor,
                            ),
                            Container(
                              height: 12.h,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Total 1,888P',
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h,),
                      Container(
                        width: 360.w,
                        height: 21.h,
                        // color: Colors.green,
                        margin: EdgeInsets.only(left: 92.w, right: 89.w),
                        child: _buildNowDuePoints(888),
                      ),
                      Container(
                        width: 360.w,
                        height: 21.h,
                        // color: Colors.yellow,
                        margin: EdgeInsets.only(left: 92.w, right: 89.w),
                        child: _buildNextDuePoints(1000),
                      ),
                      SizedBox(height: 17.h,),
                      Container(
                        width: 360.w,
                        height: 200.h,
                        alignment: Alignment.center,
                        // color: Colors.green,
                        child: Column(
                          children: _getPointsWidgets(),
                        ),
                      )
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
                    "V01-54",
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
