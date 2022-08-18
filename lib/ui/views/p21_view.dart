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


class p21View extends StatefulWidget {
  final int page;
  final String url;

  const p21View({Key key, this.page, this.url}) : super(key: key);

  @override
  _p21ViewState createState() => new _p21ViewState();
}

class _p21ViewState extends StateMVC<p21View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p21View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p21ViewState() : super(p02Model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    Fimber.i("$TAG initState: type = ${widget.page}, url = ${widget.url}");
    _model.initData(widget.page, widget.url);
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
                if(widget.page==21) _model.navigationService.popToRootAndReplace(routes.p02ViewRoute,);
                else Navigator.pop(context);
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
                      SizedBox(height: 17.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: profile:');
                        },
                        child: Container(
                          height: 100.h,
                          width: 360.w,
                          margin: EdgeInsets.only(left: 135.w, right: 125.w),
                          // color: Colors.grey,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(icons.CommonImage.profile, fit: BoxFit.fitWidth,),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 16.h,
                                  width: 26.w,
                                  child: Image.asset(icons.CommonImage.btn_camera, fit: BoxFit.fitWidth,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h,),
                      Container(
                        height: 30.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 61.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_title),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: AutoSizeText(
                                _model.keyString2("profile_name"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 30.h,
                              width: 210.w,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_input),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                cursorColor: Colors.black,
                                cursorWidth: 3,
                                controller: _model.accountCont,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                decoration: InputDecoration(
                                  hintText: _model.keyString2('profile_name_hint'),
                                  hintStyle: TextStyle(fontSize: 14.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                  filled: false,
                                  hoverColor:  _textColor,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 16.w, bottom: (16/_model.globalService.ratioHeight).h),
                                ),
                                onSubmitted:  (value) {
                                  _model.globalService.hideKeyboard(_myContext);
                                  Fimber.i('$TAG: onSubmitted: value = $value');
                                  _model.password = _model.accountCont.text;
                                },
                                onChanged: (value) {
                                  Fimber.i('$TAG 0: onChanged: value = $value');
                                  _model.password = _model.accountCont.text;
                                },
                                onEditingComplete: () {
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.h,),
                      Container(
                        height: 30.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 61.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_title),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: AutoSizeText(
                                _model.keyString2("profile_tel"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 30.h,
                              width: 210.w,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_input),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                cursorColor: Colors.black,
                                cursorWidth: 3,
                                controller: _model.accountCont,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                decoration: InputDecoration(
                                  hintText: _model.keyString2('profile_tel_hint'),
                                  hintStyle: TextStyle(fontSize: 14.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                  filled: false,
                                  hoverColor:  _textColor,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 16.w, bottom: (16/_model.globalService.ratioHeight).h),
                                ),
                                onSubmitted:  (value) {
                                  _model.globalService.hideKeyboard(_myContext);
                                  Fimber.i('$TAG: onSubmitted: value = $value');
                                  _model.password = _model.accountCont.text;
                                },
                                onChanged: (value) {
                                  Fimber.i('$TAG 0: onChanged: value = $value');
                                  _model.password = _model.accountCont.text;
                                },
                                onEditingComplete: () {
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.h,),
                      Container(
                        height: 30.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 61.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_title),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: AutoSizeText(
                                _model.keyString2("profile_bdau"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 30.h,
                              width: 210.w,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_input),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                cursorColor: Colors.black,
                                cursorWidth: 3,
                                controller: _model.accountCont,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: ScreenUtil().setSp(22), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                decoration: InputDecoration(
                                  hintText: _model.keyString2('profile_bday_hint'),
                                  hintStyle: TextStyle(fontSize: 14.sp, color: hintColor, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                  filled: false,
                                  hoverColor:  _textColor,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 16.w, bottom: (16/_model.globalService.ratioHeight).h),
                                ),
                                onSubmitted:  (value) {
                                  _model.globalService.hideKeyboard(_myContext);
                                  Fimber.i('$TAG: onSubmitted: value = $value');
                                  _model.password = _model.accountCont.text;
                                },
                                onChanged: (value) {
                                  Fimber.i('$TAG 0: onChanged: value = $value');
                                  _model.password = _model.accountCont.text;
                                },
                                onEditingComplete: () {
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 17.h,),
                      Container(
                        height: 30.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 61.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_title),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: AutoSizeText(
                                _model.keyString2("profile_sex"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 30.h,
                              width: 210.w,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_input),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 60.w, right: 40.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_F:');
                                      _model.setSex(0);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getSexBg(0), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              'F',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_M:');
                                      _model.setSex(1);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getSexBg(1), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              'M',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.h,),
                      Container(
                        height: 30.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 61.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_title),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: AutoSizeText(
                                _model.keyString2("profile_blood"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 30.h,
                              width: 210.w,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_input),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 60.w, right: 40.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_A:');
                                      _model.setBlood(0);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getBloodBg(0), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              'A',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_B:');
                                      _model.setBlood(1);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getBloodBg(1), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              'B',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_O:');
                                      _model.setBlood(2);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getBloodBg(2), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              'O',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_AB:');
                                      _model.setBlood(3);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getBloodBg(3), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              'AB',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17.h,),
                      Container(
                        height: 30.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30.h,
                              width: 61.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_title),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: AutoSizeText(
                                _model.keyString2("profile_rh"),
                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 2.1),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              height: 30.h,
                              width: 210.w,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                image: DecorationImage(
                                  image: AssetImage(icons.CommonImage.img_profile_input),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 60.w, right: 40.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_P:');
                                      _model.setRh(0);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getRhBg(0), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              '+',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_-:');
                                      _model.setRh(1);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getRhBg(1), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              '-',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Fimber.i('$TAG onTap: btn_q:');
                                      _model.setRh(2);
                                    },
                                    child: Container(
                                      height: 20.w,
                                      width: 20.w,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.asset(_model.getRhBg(2), fit: BoxFit.fill,),
                                          Container(
                                            height: 20.w,
                                            width: 20.w,
                                            alignment: Alignment.center,
                                            // margin: EdgeInsets.all(6.w),
                                            child: AutoSizeText(
                                              '?',
                                              style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getArialFontFamily(),),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20.w,
                                    width: 20.w,
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      GestureDetector(
                        onLongPress: (){
                          Fimber.i('$TAG onLongPress: btn_confirm:');
                          // _model.showDialogMessage(_model.keyString2("password_ng2"),);
                        },
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_confirm:');
                          _model.navigationService.popToRootAndReplace(routes.p22ViewRoute,);
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
