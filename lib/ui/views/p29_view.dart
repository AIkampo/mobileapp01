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
import 'package:sprintf/sprintf.dart';
import '../../core/services/global_service.dart';
import '../../locator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../core/viewmodels/template_model.dart';
import '../../ui/views/base_view.dart';
import '../../ui/shared/icon_names.dart' as icons;
import '../../core/viewmodels/p02_model.dart';
import '../shared/app_colors.dart';
import '../../ui/shared/route_paths.dart' as routes;
import 'package:carousel_slider/carousel_slider.dart';
import '../../ui/shared/icon_names.dart' as icons;
import 'dart:math' as math;



class p29View extends StatefulWidget {
  final int type;
  final String url;

  const p29View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p29ViewState createState() => new _p29ViewState();
}

class _p29ViewState extends StateMVC<p29View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p29View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p29ViewState() : super(p02Model()) {
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

  List<Widget> _buildWidgets() {
    List<Widget> widgets = <Widget>[];
    int _length = 4;
    String _assetString;
    for(int i=0; i<_length; i++){
      switch(i){
        case 0:
          _assetString = icons.CommonImage.loading_1;
          break;
        case 1:
          _assetString = icons.CommonImage.loading_2;
          break;
        case 2:
          _assetString = icons.CommonImage.loading_3;
          break;
        case 3:
          _assetString = icons.CommonImage.loading_4;
          break;
      };
      widgets.add(
        Container(
          width: 240.w,
          height: 156.h,
          alignment: Alignment.center,
          // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
          child: Image.asset(_assetString, fit: BoxFit.fill,),
        ),
      );
    }
    _length = widgets.length;;
    Fimber.i('$TAG _buildWidgets: _length = $_length');
    return widgets;
  }

  Widget _buildCarousel(){
    Fimber.i('$TAG _buildCarousel:');
    return CarouselSlider(
      carouselController: _model.carouseController,
      options: CarouselOptions(
        autoPlay: true,
        height: 156.h,
        reverse: false,
        viewportFraction: 1.0,
        autoPlayInterval: Duration(seconds: 1),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        onPageChanged: (int nextPage, CarouselPageChangedReasoncarouselPageChangedReason) {
          Fimber.i('_buildCarousel: nextPage = $nextPage');
        },
      ),
      items: _buildWidgets(),
    );
  }


  @override
  Widget build(BuildContext context) {
    _myContext = context;
    return BaseView(
      model: _model,
      mvcBuilder: (_, __) {
        return _model.bDataReady? Scaffold(
          key: _model.scaffoldKey,
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
                      SizedBox(height: 5.h,),
                      Container(
                        height: 42.h,
                        margin: EdgeInsets.only(left: 5.w),
                        alignment: Alignment.centerLeft,
                        child: Image.asset(icons.CommonImage.logo, fit: BoxFit.fitHeight,),
                      ),
                      SizedBox(height: 32.h,),
                      Container(
                        height: 158.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        child: _buildCarousel(),
                      ),
                      SizedBox(height: 73.h,),
                      Container(
                        height: 69.h,
                        margin: EdgeInsets.only(left: 48.w, right: 60.w),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.tips_rect),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.rotate(
                                  angle: -math.pi / 8,
                                  child: Container(
                                    width: 55.6.w,
                                    height: 21.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(icons.CommonImage.tips),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 22.w,
                                  height: 23.h,
                                  transform: Matrix4.translationValues(-5.w, -5.h, 0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(icons.CommonImage.thinking),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Container(
                              height: 14.h,
                              margin: EdgeInsets.only(left: 14.w,),
                              child: AutoSizeText(
                                _model.keyString2('loading_q'),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              height: 14.h,
                              margin: EdgeInsets.only(left: 14.w,),
                              child: AutoSizeText(
                                _model.keyString2('loading_8'),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 94.h,),
                      Container(
                        height: 10.h,
                        margin: EdgeInsets.only(left: 158.w, right: 58.w),
                        // color: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 10.w,
                              backgroundColor: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                            ),
                            CircleAvatar(
                              radius: 10.w,
                              backgroundColor: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                            ),
                            CircleAvatar(
                              radius: 10.w,
                              backgroundColor: _randomColor.randomColor(colorBrightness:ColorBrightness.light).withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Container(
                        height: 14.h,
                        margin: EdgeInsets.only(left: 60.w, right: 100.w),
                        child: AutoSizeText(
                          sprintf(_model.keyString2('loading_percentage'), [65]),
                          style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(),),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Container(
                        height: 23.h,
                        margin: EdgeInsets.only(left: 60.w, right: 60.w),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(icons.CommonImage.bg_elipse),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Image.asset(icons.CommonImage.loading_65, fit: BoxFit.fitHeight,),
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
                    "V01-29",
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
