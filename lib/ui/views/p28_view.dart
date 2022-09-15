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


class p28View extends StatefulWidget {
  final int type;
  final String url;

  const p28View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p28ViewState createState() => new _p28ViewState();
}

class _p28ViewState extends StateMVC<p28View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p28View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p28ViewState() : super(p02Model()) {
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

  Widget _buildWidget(int _index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 11.h,),
        Container(
          height: 14.h,
          width: 360.w,
          margin: EdgeInsets.only(left: 30.w,),
          child: AutoSizeText(
            _model.physiqueQuestions[_index],
            style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 6.h,),
        Container(
          height: 14.h,
          width: 360.w,
          margin: EdgeInsets.only(left: 30.w,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60.w,
                height: 14.h,
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _model.physiques[_index],
                      onChanged: (val) {
                        Fimber.i('$TAG physique_no: _index = $_index, val = $val');
                        _model.setPhysiques(_index, val);
                      },
                    ),
                    AutoSizeText(
                      _model.keyString2('physique_no'),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _model.physiques[_index],
                      onChanged: (val) {
                        Fimber.i('$TAG physique_few: _index = $_index, val = $val');
                        _model.setPhysiques(_index, val);
                      },
                    ),
                    AutoSizeText(
                      _model.keyString2('physique_few'),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                child: Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _model.physiques[_index],
                      onChanged: (val) {
                        Fimber.i('$TAG physique_fair: _index = $_index, val = $val');
                        _model.setPhysiques(_index, val);
                      },
                    ),
                    AutoSizeText(
                      _model.keyString2('physique_fair'),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 4,
                      groupValue: _model.physiques[_index],
                      onChanged: (val) {
                        Fimber.i('$TAG physique_often: _index = $_index, val = $val');
                        _model.setPhysiques(_index, val);
                      },
                    ),
                    AutoSizeText(
                      _model.keyString2('physique_often'),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                width: 60.w,
                height: 14.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 5,
                      groupValue: _model.physiques[_index],
                      onChanged: (val) {
                        Fimber.i('$TAG physique_always: _index = $_index, val = $val');
                        _model.setPhysiques(_index, val);
                      },
                    ),
                    AutoSizeText(
                      _model.keyString2('physique_always'),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildWidgets() {
    List<Widget> widgets = <Widget>[];
    int _length = _model.lengthPhysiques;
    String _assetString;
    for(int i=0; i<_length; i++){
      widgets.add(_buildWidget(i));
    }
    _length = widgets.length;;
    Fimber.i('$TAG _buildWidgets: _length = $_length');
    return widgets;
  }

  Widget _build50Widgets() {
    Widget _widget;
    _widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildWidgets(),
    );
    return _widget;
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
                            _model.keyString2("physique_heading"),
                            style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h,),
                      Container(
                        height: 28.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 39.w, right: 37.w),
                        child: AutoSizeText(
                          _model.keyString2("physique_hints"),
                          style: TextStyle(fontSize: 11.5.sp, color: Colors.red, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 7.h,),
                      Container(
                        height: 17.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 26.w, right: 24.w),
                        child: AutoSizeText(
                          _model.keyString2("physique_50_heading"),
                          style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      _build50Widgets(),
                      SizedBox(height: 20.h,),
                      GestureDetector(
                        onTap: (){
                          int _page = _model.getRandom() + 1;
                          _page = 1;
                          Fimber.i('$TAG onTap: btn_result: _page = $_page');
                          _model.navigationService.popToRootAndReplace(routes.p28xViewRoute, arguments: [_page]);
                        },
                        child: Container(
                          height: 47.h,
                          width: 360.w,
                          margin: EdgeInsets.only(left: 120.w, right: 120.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons.CommonImage.btn_result),
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
                    "V01-28",
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
