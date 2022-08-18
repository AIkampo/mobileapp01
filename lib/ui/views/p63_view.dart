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

import '../../core/viewmodels/p63model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p63View extends StatefulWidget {
  final int program;
  final String json;

  const p63View({Key key, this.program, this.json}) : super(key: key);

  @override
  _p63ViewState createState() => new _p63ViewState();
}

class _p63ViewState extends StateMVC<p63View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p63View:";
  p63Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p63ViewState() : super(p63Model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    // Fimber.i("$TAG initState: type = ${widget.score}, json = ${widget.json}");
    _model.initData(widget.program, widget.json);
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


  Widget _buildPointsWidgets(int _index){
    String _iconString, _pointString;
    Fimber.i('$TAG _buildPointsWidgets: _index = $_index');
    switch(_index){
      case 0:
        _iconString = icons.CommonImage.ae_card;
        _pointString = 'card_credit';
        break;
      case 1:
        _iconString = icons.CommonImage.visa_card;
        _pointString = 'card_bank';
        break;
      case 2:
        _iconString = icons.CommonImage.apple_pay;
        _pointString = 'Apple Pay';
        break;
      case 3:
        _iconString = icons.CommonImage.google_pay;
        _pointString = 'Google Pay';
        break;
      case 4:
        _iconString = icons.CommonImage.line_pay;
        _pointString = 'Line Pay';
        break;
      default:
        _iconString = icons.CommonImage.ae_card;
        _pointString = 'card_credit';
        break;

    }
    Widget _image = Container(
      width: 24.w,
      height: 16.h,
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
      height: 17.h,
      child: AutoSizeText(
        _model.keyString2(_pointString),
        style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
        // textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  List<Widget> _getPointsWidgets(){
    List<Widget> _widgets = <Widget>[];
    Widget _widget;
    _widgets.clear();
    for(int i=0; i<5; i++){
      _widget = Container(
        height: 1.h,
        margin: EdgeInsets.only(left: 2.w, right: 2.w),
        color: greyLineBgColor.withOpacity(0.2),
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
      color: greyLineBgColor.withOpacity(0.2),
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
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black.withOpacity(0.8),),
              onPressed: () => Navigator.pop(context),
            ),
            title: AutoSizeText(
              _model.keyString2('card_title'),
              style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
              textAlign: TextAlign.center,
            ),
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
              GestureDetector(
                onTap: (){
                  Fimber.i('$TAG onTap: confirm:');
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 360.w,
                    height: 37.h,
                    margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 14.h),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(icons.CommonImage.confirm),
                        fit: BoxFit.fill,
                      ),
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
                    "V01-63",
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
