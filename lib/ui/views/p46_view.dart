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

import '../../core/viewmodels/p46model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p46View extends StatefulWidget {
  final int page;
  final String json;

  const p46View({Key key, this.page, this.json}) : super(key: key);

  @override
  _p46ViewState createState() => new _p46ViewState();
}

class _p46ViewState extends StateMVC<p46View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p46View:";
  p46Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p46ViewState() : super(p46Model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    // Fimber.i("$TAG initState: type = ${widget.score}, json = ${widget.json}");
    _model.initData(widget.page, widget.json);
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

  Widget _buildAnyGood(){
    List<Widget> _widgets = _buildAnyGoodlist();
    return GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 240.w / 29.h,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 0.w,
        ),
        physics: NeverScrollableScrollPhysics(),
        children: _widgets,
    );

  }

  List<Widget>  _buildAnyGoodlist(){
    List<Widget> _widgets = <Widget>[];
    _widgets.clear();
    int _length = _model.lengthGood;
    for(int i=_length; i>=0; i--){
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
          (_length-(i-1)).toString() + '.' + _model.getGoodName(i),
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
                                  _model.keyString2(_model.title),
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
                                  image: AssetImage(_model.bgTitle),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              padding: EdgeInsets.all(13.w,),
                              child: Image.asset(_model.iconTitle, fit: BoxFit.fill,),
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
                          _model.keyString2(_model.subtitle),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Container(
                        width: 360.w,
                        height: 407.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        // color: Colors.green,
                        child: _buildAnyGood(),
                      ),
                      SizedBox(height: 20.h,),
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
