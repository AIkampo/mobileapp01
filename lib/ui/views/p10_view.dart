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

import '../../core/viewmodels/p02_model.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/shared/route_paths.dart' as routes;
import '../../ui/views/base_view.dart';
import '../shared/app_colors.dart';

class p10View extends StatefulWidget {
  final int type;
  final String url;

  const p10View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p10ViewState createState() => new _p10ViewState();
}

class _p10ViewState extends StateMVC<p10View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p10View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p10ViewState() : super(p02Model()) {
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
                      SizedBox(height: 79.h,),
                      Container(
                        height: 60.w,
                        width: 60.w,
                        margin: EdgeInsets.only(left: 145.w, right: 145.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.okcircle),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      Container(
                        height: 22.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 120.w, right: 120.w),
                        child: AutoSizeText(
                          _model.keyString2("new_done"),
                          style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 65.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_ok:');
                          _model.navigationService.popToRootAndReplace(routes.p21ViewRoute, arguments: [21]);
                        },
                        child: Container(
                          height: 40.h,
                          width: 360.w,
                          margin: EdgeInsets.only(left: 120.w, right: 120.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons.CommonImage.btn_ok),
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
                    "V01-10",
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
