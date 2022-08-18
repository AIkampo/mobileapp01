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


class p18View extends StatefulWidget {
  final int type;
  final String url;

  const p18View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p18ViewState createState() => new _p18ViewState();
}

class _p18ViewState extends StateMVC<p18View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p18View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p18ViewState() : super(p02Model()) {
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _model.navigationService.popAndPush(routes.p15ViewRoute,);
              },
            ),
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
                      SizedBox(height: 15.h,),
                      Container(
                        height: 44.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 95.w, right: 92.w),
                        child: Image.asset(icons.CommonImage.new_password, fit: BoxFit.fill,),
                      ),
                      SizedBox(height: 44.h,),
                      Container(
                        height: 40.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 56.w, right: 80.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40.h,
                              width: 49.w,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                _model.keyString2("password_new"),
                                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.input_border),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: TextField(
                                // textAlign: TextAlign.start,
                                cursorColor: Colors.black,
                                cursorWidth: 3,
                                controller: _model.passwordCont,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                decoration: InputDecoration(
                                  hintText: _model.keyString2('password_hint1'),
                                  hintStyle: TextStyle(fontSize: 15.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                  filled: false,
                                  hoverColor:  _textColor,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 16.w, bottom: 5.h),
                                ),
                                onSubmitted:  (value) {
                                  _model.globalService.hideKeyboard(_myContext);
                                  Fimber.i('$TAG: onSubmitted: value = $value');
                                  _model.password = _model.passwordCont.text;
                                },
                                onChanged: (value) {
                                  Fimber.i('$TAG 0: onChanged: value = $value');
                                  _model.password = _model.passwordCont.text;
                                },
                                onEditingComplete: () {
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Container(
                        height: 15.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 90.w, ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _model.keyString2("password_notice"),
                          style: TextStyle(fontSize: 9.sp, color: Colors.red, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(height: 7.h,),
                      Container(
                        height: 40.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 40.w, right: 80.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40.h,
                              width: 70.w,
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                _model.keyString2("password_again"),
                                style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.input_border),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: TextField(
                                // textAlign: TextAlign.start,
                                cursorColor: Colors.black,
                                cursorWidth: 3,
                                controller: _model.passwordCont,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                decoration: InputDecoration(
                                  hintText: _model.keyString2('password_hint2'),
                                  hintStyle: TextStyle(fontSize: 15.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                  filled: false,
                                  hoverColor:  _textColor,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 16.w, bottom: 5.h),
                                ),
                                onSubmitted:  (value) {
                                  _model.globalService.hideKeyboard(_myContext);
                                  Fimber.i('$TAG: onSubmitted: value = $value');
                                  _model.password = _model.passwordCont.text;
                                },
                                onChanged: (value) {
                                  Fimber.i('$TAG 0: onChanged: value = $value');
                                  _model.password = _model.passwordCont.text;
                                },
                                onEditingComplete: () {
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 38.h,),
                      GestureDetector(
                        onLongPress: (){
                          Fimber.i('$TAG onLongPress: btn_confirm:');
                          _model.showDialogMessage(_model.keyString2("password_ng2"),);
                        },
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_confirm:');
                          _model.navigationService.popToRootAndReplace(routes.p20ViewRoute,);
                        },
                        child: Container(
                          height: 30.h,
                          width: 360.w,
                          margin: EdgeInsets.only(left: 150.w, right: 150.w),
                          child: Image.asset(icons.CommonImage.btn_confirm, fit: BoxFit.fitHeight,),
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
                    "V01-18",
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
