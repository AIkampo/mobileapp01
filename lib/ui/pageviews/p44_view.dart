// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_color/random_color.dart';

import '../../core/services/global_service.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../ui/shared/route_paths.dart' as routes;

class p44View extends StatefulWidget {
  @override
  State<p44View> createState() => _p44ViewState();
}

class _p44ViewState extends State<p44View> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalService globalService = locator<GlobalService>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TAG = "p44View:";
  bool _INIT = true;
  RandomColor _randomColor = RandomColor();

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
      appBar: globalService.getAppBar(),
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
                SizedBox(height: 20.h,),
                Container(
                  width: 360.w,
                  height: 58.h,
                  margin: EdgeInsets.only(left: 30.w, right: 62.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_vegetable_black),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.all(13.w,),
                        child: Image.asset(icons.CommonImage.vegetable_black, fit: BoxFit.fill,),
                      ),
                      Container(
                        width: 178.w,
                        height: 34.h,
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_grey_rectangle),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12.w, right: 0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              globalService.model.keyString2('health_food_guidelines'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG vegetable_black:');
                                globalService.model.navigationService.push(routes.p45ViewRoute, arguments: [23, globalService.model.jsonFood]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h,),
                Container(
                  width: 360.w,
                  height: 58.h,
                  margin: EdgeInsets.only(left: 30.w, right: 62.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_lab),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.all(13.w,),
                        child: Image.asset(icons.CommonImage.lab, fit: BoxFit.fill,),
                      ),
                      Container(
                        width: 178.w,
                        height: 34.h,
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_grey_rectangle),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12.w,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              globalService.model.keyString2('health_micronutrient_guidelines'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 0.8),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG Micro:');
                                globalService.model.navigationService.push(routes.p46ViewRoute, arguments: [46, globalService.model.jsonMicro]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h,),
                Container(
                  width: 360.w,
                  height: 58.h,
                  margin: EdgeInsets.only(left: 30.w, right: 62.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_colors),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.all(13.w,),
                        child: Image.asset(icons.CommonImage.colors, fit: BoxFit.fill,),
                      ),
                      Container(
                        width: 178.w,
                        height: 34.h,
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_grey_rectangle),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12.w, right: 0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              globalService.model.keyString2('health_energy_guidelines'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 0.8),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG health_energy_guidelines:');
                                globalService.model.navigationService.push(routes.p46ViewRoute, arguments: [47, globalService.model.jsonEnerge]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h,),
                Container(
                  width: 360.w,
                  height: 58.h,
                  margin: EdgeInsets.only(left: 30.w, right: 62.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_acupuncture),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.all(13.w,),
                        child: Image.asset(icons.CommonImage.acupuncture, fit: BoxFit.fill,),
                      ),
                      Container(
                        width: 178.w,
                        height: 34.h,
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_grey_rectangle),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12.w, right: 0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              globalService.model.keyString2('health_acupuncture_guidelines'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG health_acupuncture_guidelines:');
                                globalService.model.navigationService.push(routes.p46ViewRoute, arguments: [48, globalService.model.jsonAcupuncture]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h,),
                Container(
                  width: 360.w,
                  height: 58.h,
                  margin: EdgeInsets.only(left: 30.w, right: 62.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_diamond_black),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding: EdgeInsets.all(13.w,),
                        child: Image.asset(icons.CommonImage.diamond_black, fit: BoxFit.fill,),
                      ),
                      Container(
                        width: 178.w,
                        height: 34.h,
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_grey_rectangle),
                            fit: BoxFit.fill,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 12.w, right: 0.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              globalService.model.keyString2('health_diamond_guidelines'),
                              style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                Fimber.i('$TAG health_diamond_guidelines:');
                                globalService.model.navigationService.push(routes.p46ViewRoute, arguments: [49, globalService.model.jsonDiamond]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 37.h,),
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
                "V01-44",
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
