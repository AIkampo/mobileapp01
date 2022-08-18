// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../core/services/global_service.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;

class p34View extends StatefulWidget {
  @override
  State<p34View> createState() => _p34ViewState();
}

class _p34ViewState extends State<p34View> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalService globalService = locator<GlobalService>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TAG = "p34View:";
  bool _INIT = true;

  @override
  void initState() {
    Fimber.i('initState:');
    super.initState();
  }

  @override
  void dispose() {
    Fimber.i('dispose:');
    // if(mounted)
    // globalService.hideKeyboard(context);
    super.dispose();
  }

  String _getTitle(){
    String _value = 'P34';
    Fimber.i('$TAG _getTitle: _value = $_value');
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    if(_INIT){
      _INIT = false;
      if(mounted) globalService.hideKeyboard(context);
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: lightBgColor,
        elevation: 0.5,
        // centerTitle: true,
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
          IconButton(
            icon: ImageIcon(AssetImage(icons.CommonImage.icon_scan), color: Colors.black,),
            onPressed: (){
              Fimber.i('$TAG onTap: icon_scan:');
            },
          ),
          GestureDetector(
            onTap: (){
              Fimber.i('$TAG onTap: icon_acc:');
            },
            child: CircleAvatar(
              radius: 15.w,
              backgroundColor: accBgColor,
              child: AutoSizeText(
                'ACC',
                style: TextStyle(fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 640.h,
            width: 360.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(icons.CommonImage.bg_app),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                SizedBox(height: 14.h,),
                Container(
                  height: 38.h,
                  width: 360.w,
                  margin: EdgeInsets.only(left: 28.w, right: 30.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icons.CommonImage.heading),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: AutoSizeText(
                      globalService.model.keyString2("result_heading"),
                      style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                SizedBox(height: 7.h,),
                Container(
                  height: 14.h,
                  width: 360.w,
                  margin: EdgeInsets.only(left: 68.w, right: 69.w),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    globalService.model.keyString2("result_notice"),
                    style: TextStyle(fontSize: 14.sp, color: noticeFgColor, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 12.h,),
                Container(
                  height: 90.w,
                  width: 360.w,
                  margin: EdgeInsets.only(left: 26.w, right: 28.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_cycle:');
                          globalService.model.navigationService.push(routes.p35ViewRoute, arguments: [globalService.model.scores9[0], globalService.model.jsonCycle]);
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(0)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, right: 11.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 53.w,
                                      width: 34.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_cycle), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[0].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_cycle"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_digestion:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(1)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, right: 11.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 53.w,
                                      width: 34.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_digestion), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[1].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_digestion"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_urinary:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(2)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, right: 11.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 53.w,
                                      width: 34.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_urinary), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[2].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_urinary"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
                Container(
                  height: 90.w,
                  width: 360.w,
                  margin: EdgeInsets.only(left: 26.w, right: 28.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_endocrine:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(3)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 72.w,
                                margin: EdgeInsets.only(left: 12.w, top: 3.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 44.w,
                                      width: 45.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_endocrine), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 27.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[3].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, ),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_endocrine"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_nerve:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(3)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 72.w,
                                margin: EdgeInsets.only(left: 12.w, top: 3.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 44.w,
                                      width: 45.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_nerve), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 27.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[4].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, ),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_nerve"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_lymph:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(5)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, right: 11.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 53.w,
                                      width: 34.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_lymph), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[5].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_lymph"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
                Container(
                  height: 90.w,
                  width: 360.w,
                  margin: EdgeInsets.only(left: 26.w, right: 28.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_perception:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(6)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 72.w,
                                margin: EdgeInsets.only(left: 10.w,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 26.w,
                                      width: 48.w,
                                      margin: EdgeInsets.only(top: 12.h,),
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_perception), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[6].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_perception"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_skeleton:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(7)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, right: 11.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 53.w,
                                      width: 34.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_skeleton), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[7].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_skeleton"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: organ_breathe:');
                        },
                        child: Container(
                          height: 90.w,
                          width: 90.w,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(globalService.model.getLevelBg(8)), fit: BoxFit.fill,),),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 7.h,),
                              Container(
                                height: 53.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 12.w, right: 11.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 53.w,
                                      width: 34.w,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icons.CommonImage.organ_breathe), fit: BoxFit.fill,),),
                                    ),
                                    Container(
                                      height: 53.w,
                                      width: 23.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            globalService.model.scores9[8].toString(),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                            textAlign: TextAlign.center,
                                          ),
                                          AutoSizeText(
                                            globalService.model.keyString2("points"),
                                            style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Container(
                                height: 19.w,
                                width: 67.w,
                                margin: EdgeInsets.only(left: 15.w, right: 11.w),
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  globalService.model.keyString2("organ_breathe"),
                                  style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21.h,),
                Container(
                  height: 170.h,
                  width: 360.w,
                  margin: EdgeInsets.only(left: 11.w, right: 12.w),
                  decoration: BoxDecoration(
                    // color: Colors.yellow,
                    image: DecorationImage(
                      image: AssetImage(icons.CommonImage.explains_border),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 19.h,),
                      Container(
                        height: 35.h,
                        width: 337.w,
                        margin: EdgeInsets.only(left: 56.w, right: 56.w),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          globalService.model.keyString2("result_explains"),
                          style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 9.h,),
                      Container(
                        height: 14.h,
                        width: 337.w,
                        margin: EdgeInsets.only(left: 23.w,),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             CircleAvatar(
                               radius: 14.w,
                               backgroundColor: gBgColor,
                               child: AutoSizeText(
                                 'G',
                                 style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                 textAlign: TextAlign.center,
                               ),
                             ),
                            Container(
                              height: 14.h,
                              width: 90.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_70_100_1"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 168.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_70_100_2"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Container(
                        height: 14.h,
                        width: 337.w,
                        margin: EdgeInsets.only(left: 23.w,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 14.w,
                              backgroundColor: yBgColor,
                              child: AutoSizeText(
                                'Y',
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 90.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_50_69_1"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 168.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_50_69_2"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Container(
                        height: 14.h,
                        width: 337.w,
                        margin: EdgeInsets.only(left: 23.w,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 14.w,
                              backgroundColor: oBgColor,
                              child: AutoSizeText(
                                'O',
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 90.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_20_49_1"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 168.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_20_49_2"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      Container(
                        height: 14.h,
                        width: 337.w,
                        margin: EdgeInsets.only(left: 23.w,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 14.w,
                              backgroundColor: rBgColor,
                              child: AutoSizeText(
                                'R',
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 90.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_0_19_1"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              width: 168.w,
                              child: AutoSizeText(
                                globalService.model.keyString2("result_0_19_2"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 1.8),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
              ],
            ),
          ),
          kDebugMode?Align(
            alignment: Alignment.bottomRight,
            child: Container(height: 43,
              padding: const EdgeInsets.only(right: 10),
              color: Colors.transparent,
              alignment: Alignment.bottomRight,
              child: AutoSizeText(
                "V01-34",
                style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                textAlign: TextAlign.end,
              ),
            ),
          ):Container(),
        ],
      ),

    );
  }
}
