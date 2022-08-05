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

class p0607View extends StatefulWidget {
  final int type;
  final String url;

  const p0607View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p0607ViewState createState() => new _p0607ViewState();
}

class _p0607ViewState extends StateMVC<p0607View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p0607View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p0607ViewState() : super(p02Model()) {
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
                      SizedBox(height: 33.h,),
                      Container(
                        height: 24.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 94.w, right: 83.w),
                        child: AutoSizeText(
                          widget.type==1?_model.keyString2("new_main_account"):_model.keyString2("new_child_account"),
                          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 33.79.h,),
                      Container(
                        height: 30.25.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
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
                          controller: _model.accountCont,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                          decoration: InputDecoration(
                            hintText: _model.keyString2('hint_phoneno'),
                            hintStyle: TextStyle(fontSize: 15.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                            filled: false,
                            hoverColor:  _textColor,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16.w, bottom: 14.h),
                          ),
                          onSubmitted:  (value) {
                            _model.globalService.hideKeyboard(_myContext);
                            Fimber.i('$TAG: onSubmitted: value = $value');
                            _model.account = _model.accountCont.text;
                          },
                          onChanged: (value) {
                            Fimber.i('$TAG 0: onChanged: value = $value');
                            _model.account = _model.accountCont.text;
                          },
                          onEditingComplete: () {
                          },
                        ),
                      ),
                      SizedBox(height: 20.25.h,),
                      Container(
                        height: 30.25.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
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
                            hintText: _model.keyString2('hint_password'),
                            hintStyle: TextStyle(fontSize: 15.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                            filled: false,
                            hoverColor:  _textColor,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16.w, bottom: 14.h),
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
                      SizedBox(height: 219.96.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_next_step:');
                          if(widget.type==1) _model.navigationService.push(routes.p08ViewRoute);
                          else _model.navigationService.popToRootAndReplace(routes.p10ViewRoute,);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 47.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icons.CommonImage.btn_next_step),
                                fit: BoxFit.fill,
                              ),
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
                    widget.type==1?"V01-06":"V01-07",
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
