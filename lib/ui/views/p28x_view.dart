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


class p28xView extends StatefulWidget {
  final int page;
  final String url;

  const p28xView({Key key, this.page, this.url}) : super(key: key);

  @override
  _p28xViewState createState() => new _p28xViewState();
}

class _p28xViewState extends StateMVC<p28xView> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p28xView:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;

  _p28xViewState() : super(p02Model()) {
    _model = controller;
  }

  @override
  void initState() {
    super.initState();
    Fimber.i("$TAG initState: type = ${widget.page}, url = ${widget.url}");
    _model.globalService.model = _model;
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
            appBar: _model.globalService.getAppBarDownload(),
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
                      SizedBox(height: 29.h,),
                      GestureDetector(
                        onTap: (){
                          int _page = widget.page + 1;
                          if(_page==10) _page = 1;
                          Fimber.i('$TAG onTap: btn_result: _page = $_page');
                          _model.navigationService.popToRootAndReplace(routes.p28xViewRoute, arguments: [_page]);
                        },
                        child: Container(
                          height: 180.h,
                          width: 360.w,
                          margin: EdgeInsets.only(left: 90.w, right: 90.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(_model.getPhysiquesImage(widget.page)),
                              fit: BoxFit.fill,
                            ),
                          ),
                          // child: Image.asset(_model.getPhysiquesImage(widget.page), fit: BoxFit.fitHeight,),
                        ),
                      ),
                      SizedBox(height: 31.h,),
                      Container(
                        height: 24.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 70.w, right: 70.w),
                        child: AutoSizeText(
                          _model.keyString2("result_title"),
                          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Container(
                        height: 58.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 84.w, right: 84.w),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _model.getPhysiquesTitle(widget.page),
                          style: TextStyle(fontSize: 48.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 36.h,),
                      Container(
                        height: 87.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 30.w),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          _model.getPhysiquesDetails(widget.page),
                          style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), letterSpacing: 3.0),
                          textAlign: TextAlign.start,
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
                    "V01-28." + widget.page.toString(),
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
