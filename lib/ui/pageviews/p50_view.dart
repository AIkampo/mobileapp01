// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:package_info/package_info.dart';
import 'package:random_color/random_color.dart';

import '../../core/services/global_service.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;

class p50View extends StatefulWidget {
  @override
  State<p50View> createState() => _p50ViewState();
}

class _p50ViewState extends State<p50View> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalService globalService = locator<GlobalService>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TAG = "p50View:";
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
      appBar: AppBar(
        elevation: 0.5,
        // centerTitle: true,
        backgroundColor: lightBgColor,
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
                SizedBox(height: 24.h,),
                Container(
                  width: 360.w,
                  height: 43.h,
                  margin: EdgeInsets.only(left: 60.w, right: 60.w),
                  padding: EdgeInsets.only(left: 22.w, ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icons.CommonImage.report_menu_rect),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 23.w,
                        height: 23.h,
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.history_report),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('history_report'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG history_report:');
                          globalService.model.navigationService.push(routes.p51ViewRoute,);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h,),
                Container(
                  width: 360.w,
                  height: 43.h,
                  margin: EdgeInsets.only(left: 60.w, right: 60.w),
                  padding: EdgeInsets.only(left: 22.w, ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icons.CommonImage.report_menu_rect),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 23.w,
                        height: 23.h,
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.mypoints),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('mypoints'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG mypoints:');
                          globalService.model.navigationService.push(routes.p54ViewRoute,);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h,),
                Container(
                  width: 360.w,
                  height: 43.h,
                  margin: EdgeInsets.only(left: 60.w, right: 60.w),
                  padding: EdgeInsets.only(left: 22.w, ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icons.CommonImage.report_menu_rect),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 23.w,
                        height: 23.h,
                        margin: EdgeInsets.only(right: 15.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.diamond_black),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('Premium_member'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG Premium_member:');
                          globalService.model.navigationService.push(routes.p62ViewRoute,);                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "目前版本: ${globalService.version}+${globalService.buildNumber}",
                  style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                  textAlign: TextAlign.end,
                ),
                kDebugMode?Text(
                  ", V01-50",
                  style: TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(),),
                  textAlign: TextAlign.end,
                ):Container(),
              ],
            ),
          )
        ],
      ),

    );
  }
}
