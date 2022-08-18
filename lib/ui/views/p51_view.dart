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

import '../../core/viewmodels/p51model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p51View extends StatefulWidget {
  final int score;
  final String json;

  const p51View({Key key, this.score, this.json}) : super(key: key);

  @override
  _p51ViewState createState() => new _p51ViewState();
}

class _p51ViewState extends StateMVC<p51View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p51View:";
  p51Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p51ViewState() : super(p51Model()) {
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

  List<Widget> _getDateWidgets(int _length){
    Fimber.i('$TAG _getDateWidgets: _length = $_length');
    List<Widget> _widgets = <Widget>[];
    Widget _widget;
    List<String> _dateStrings = _model.getPastReportDates(_length);
    _widgets.clear();
    for(int i=0; i<_length; i++){
      _widget = SizedBox(height: 6.h);
      _widgets.add(_widget);
      _widget = Container(
        width: 360.w,
        height: 22.h,
        margin: EdgeInsets.only(left: 60.w, right: 66.w),
        padding: EdgeInsets.only(left: 7.w, right: 20.w, bottom: 0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border : Border.all(
            color: Colors.black,
            width: 1,),
        ),
        child: GestureDetector(
          onTap: () {
            Fimber.i('$TAG _getDateWidgets: chevron_right: i = $i');
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                _dateStrings[i],
                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                '＞',
                style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: _model.getFontFamily(),),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
      _widgets.add(_widget);
    }
    Fimber.i('$TAG _getDateWidgets: _length = ${_widgets.length}');
    return _widgets;
  }

  Widget _getPeriod1(){
    return _model.getBDay()?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getDateWidgets(1),
    ):Container();
  }

  Widget _getPeriod7(){
    return _model.getPeriod7()?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getDateWidgets(7),
    ):Container();
  }

  Widget _getPeriod30(){
    return _model.getPeriod30()?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getDateWidgets(30),
    ):Container();
  }

  Widget _getPeriod90(){
    return _model.getPeriod90()?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _getDateWidgets(90),
    ):Container();
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
                          _model.keyString2('history_report'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 6.h,),
                      Container(
                        width: 360.w,
                        height: 15.h,
                        margin: EdgeInsets.only(left: 264.w, right: 60.w),
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Fimber.i('$TAG onTap: day:');
                                _model.setSelected(1);
                              },
                              child: Container(
                                width: 13.5.w,
                                height: 14.h,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(5),
                                  color: _model.selected==1?lightBgColor:Colors.white,
                                  border : Border.all(
                                    color: Colors.grey,
                                    width: 1,),
                                ),
                                child: AutoSizeText(
                                  _model.keyString2('day'),
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: _model.getFontFamily(),),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                Fimber.i('$TAG onTap: month:');
                                _model.setSelected(2);
                              },
                              child: Container(
                                width: 13.5.w,
                                height: 14.h,
                                decoration: BoxDecoration(
                                  color: _model.selected==2?lightBgColor:Colors.white,
                                  border : Border.all(
                                    color: Colors.grey,
                                    width: 1,),
                                ),
                                child: AutoSizeText(
                                  _model.keyString2('month'),
                                  style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: _model.getFontFamily(),),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13.5.h,),
                      Container(
                        width: 360.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_day),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 7.w, right: 13.w, bottom: 3.5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              _model.keyString2('today'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(_model.getBDay()?Icons.expand_less:Icons.expand_more), //expand_less, expand_more
                              onPressed: () {
                                Fimber.i('$TAG today: expand_less:');
                                bool _value = _model.getBDay();
                                _model.setBDay(!_value);
                              },
                            ),
                          ],
                        ),
                      ),
                      _getPeriod1(),
                      SizedBox(height: 7.h,),
                      Container(
                        width: 360.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_day),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 7.w, right: 13.w, bottom: 3.5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              _model.keyString2('period7'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(_model.getPeriod7()?Icons.expand_less:Icons.expand_more), //expad_less, expand_more
                              onPressed: () {
                                Fimber.i('$TAG period7: expand_less:');
                                bool _value = _model.getPeriod7();
                                _model.setPeriod7(!_value);
                              },
                            ),
                          ],
                        ),
                      ),
                      _getPeriod7(),
                      SizedBox(height: 7.h,),
                      Container(
                        width: 360.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_day),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 7.w, right: 13.w, bottom: 3.5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              _model.keyString2('period30'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(_model.getPeriod30()?Icons.expand_less:Icons.expand_more), //expad_less, expand_more
                              onPressed: () {
                                Fimber.i('$TAG period30: expand_less:');
                                bool _value = _model.getPeriod30();
                                _model.setPeriod30(!_value);
                              },
                            ),
                          ],
                        ),
                      ),
                      _getPeriod30(),
                      SizedBox(height: 7.h,),
                      Container(
                        width: 360.w,
                        height: 31.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_day),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        padding: EdgeInsets.only(left: 7.w, right: 13.w, bottom: 3.5.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              _model.keyString2('period90'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(_model.getPeriod90()?Icons.expand_less:Icons.expand_more), //expad_less, expand_mored_less, expand_more
                              onPressed: () {
                                Fimber.i('$TAG period90: expand_less:');
                                bool _value = _model.getPeriod90();
                                _model.setPeriod90(!_value);
                              },
                            ),
                          ],
                        ),
                      ),
                      _getPeriod90(),
                      SizedBox(height: 7.h,),
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
                    "V01-51",
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
