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


class p12View extends StatefulWidget {
  final int type;
  final String url;

  const p12View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p12ViewState createState() => new _p12ViewState();
}

class _p12ViewState extends StateMVC<p12View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p12View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p12ViewState() : super(p02Model()) {
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
            title: GestureDetector(
              onTap: (){
                Fimber.i('$TAG onTap: title:');
              },
              child: Container(
                height: 40.h,
                // margin: EdgeInsets.all(10.h),
                alignment: Alignment.centerLeft,
                child: Image.asset(icons.CommonImage.logo, fit: BoxFit.fitHeight,),
              ),
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
                        height: 55.44.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 61.w, right: 92.65.w),
                        child: Image.asset(icons.CommonImage.welcomeback, fit: BoxFit.fill,),
                      ),
                      SizedBox(height: 17.56.h,),
                      Container(
                        height: 229.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.account_login),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h,),
                              Container(
                                height: 24.h,
                                // color: Colors.green,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Fimber.i('$TAG onTap: change_account:');
                                        _model.navigationService.replace(routes.p02ViewRoute);
                                      },
                                      child: Container(
                                        height: 24.h,
                                        width: 82.w,
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          _model.keyString2("change_account"),
                                          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 76.w),
                                    GestureDetector(
                                      onTap: (){
                                        Fimber.i('$TAG onTap: login_account:');
                                      },
                                      child: Container(
                                        height: 24.h,
                                        width: 82.w,
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          _model.keyString2("login_account"),
                                          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 26.79.h,),
                              Container(
                                height: 30.h,
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
                              SizedBox(height: 19.21.h,),
                              Container(
                                height: 30.h,
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
                              SizedBox(height: 23.h,),
                              GestureDetector(
                                onLongPress: (){
                                  Fimber.i('$TAG onLongPress: login:');
                                  _model.showDialogMessage(_model.keyString2("login_error"),);
                                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                                  //   CommonUI.showDialogMessage(context, null, _model.keyString2("login_error"),);
                                  // });
                                },
                                onTap: (){
                                  Fimber.i('$TAG onTap: login:');
                                  // _model.navigationService.push(routes.p13ViewRoute);
                                  _model.navigationService.replace(routes.MainRoute);
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 26.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.btn_login),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 12.h,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 20.h,
                                  width: 79.w,
                                  child: GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: forgot:');
                                      _model.navigationService.push(routes.p15ViewRoute,);
                                    },
                                    child: AutoSizeText(
                                      _model.keyString2("forgot"),
                                      style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily2(),),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 53.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_registration:');
                          _model.navigationService.push(routes.p13ViewRoute,);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 47.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(icons.CommonImage.btn_registration),
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
                    "V01-12",
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
