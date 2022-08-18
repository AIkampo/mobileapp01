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

import '../../core/viewmodels/p120model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p120View extends StatefulWidget {
  final int score;
  final String json;

  const p120View({Key key, this.score, this.json}) : super(key: key);

  @override
  _p120ViewState createState() => new _p120ViewState();
}

class _p120ViewState extends StateMVC<p120View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p120View:";
  p120Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p120ViewState() : super(p120Model()) {
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
                      SizedBox(height: 19.h,),
                      Container(
                        width: 360.w,
                        height: 37.5.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.us_heading),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: AutoSizeText(
                          _model.keyString2('contact_us'),
                          style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 11.5.h,),
                      Container(
                        width: 360.w,
                        height: 36.h,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: AutoSizeText(
                          _model.keyString2('us_details'),
                          maxLines: 2,
                          style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Container(
                        width: 360.w,
                        height: 136.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.us_content),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 72.w,
                              height: 30.h,
                              // alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 11.w,),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.contact_us),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: 260.w,
                              height: 84.h,
                              margin: EdgeInsets.only(left: 11.w,),
                              child: AutoSizeText(
                                _model.keyString2('us_info'),
                                maxLines: 4,
                                style: TextStyle(fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.start,
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
                    "V01-120",
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
