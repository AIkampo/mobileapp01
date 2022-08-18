// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:random_color/random_color.dart';

import '../../core/services/global_service.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;

class p77View extends StatefulWidget {
  @override
  State<p77View> createState() => _p77ViewState();
}

class _p77ViewState extends State<p77View> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalService globalService = locator<GlobalService>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TAG = "p77View:";
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
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.profile2),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('profile'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG profile:');
                          globalService.model.navigationService.push(routes.p21ViewRoute, arguments: [89]);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.lock),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('lock'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG lock:');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.question),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('question'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG question:');
                          // globalService.model.navigationService.push(routes.p45ViewRoute, arguments: [23, globalService.model.jsonFood]);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.book),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('book'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG book:');
                          // globalService.model.navigationService.push(routes.p45ViewRoute, arguments: [23, globalService.model.jsonFood]);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.phone_call),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('phone_call'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG phone_call:');
                          globalService.model.navigationService.push(routes.p120ViewRoute,);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.service),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('service'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG service:');
                          // globalService.model.navigationService.push(routes.p45ViewRoute, arguments: [23, globalService.model.jsonFood]);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.language),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('language'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG language:');
                          // globalService.model.navigationService.push(routes.p45ViewRoute, arguments: [23, globalService.model.jsonFood]);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                            image: AssetImage(icons.CommonImage.logout),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 132.w,
                        height: 23.h,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          globalService.model.keyString2('logout'),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: globalService.model.getFontFamily(), letterSpacing: 2.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          Fimber.i('$TAG logout:');
                          // globalService.model.navigationService.push(routes.p45ViewRoute, arguments: [23, globalService.model.jsonFood]);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h,),
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
                "V01-77",
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
