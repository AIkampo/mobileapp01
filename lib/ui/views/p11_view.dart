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
import 'package:checkbox_grouped/checkbox_grouped.dart';

class p11View extends StatefulWidget {
  final int type;
  final String url;

  const p11View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p11ViewState createState() => new _p11ViewState();
}

class _p11ViewState extends StateMVC<p11View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p11View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p11ViewState() : super(p02Model()) {
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
                      SizedBox(height: 79.h,),
                      Container(
                        height: 29.w,
                        width: 168.w,
                        margin: EdgeInsets.only(left: 98.w, right: 96.w),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _model.keyString2("query_delete"),
                          style: TextStyle(fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 79.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_ok_long_c:');
                          _model.navigationService.popToRootAndReplace(routes.p02ViewRoute,);
                        },
                        child: Container(
                          height: 34.w,
                          width: 180.w,
                          margin: EdgeInsets.only(left: 90.w, right: 90.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons.CommonImage.btn_ok_long_c),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 11.22.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_cancel_long_c:');
                          _model.navigationService.popToRootAndReplace(routes.p03ViewRoute,);
                        },
                        child: Container(
                          height: 34.w,
                          width: 180.w,
                          margin: EdgeInsets.only(left: 90.w, right: 90.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons.CommonImage.btn_cancel_long_c),
                              fit: BoxFit.fill,
                            ),
                          ),
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
                    "V01-11",
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
