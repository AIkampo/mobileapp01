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

class p05View extends StatefulWidget {
  final int type;
  final String url;

  const p05View({Key key, this.type, this.url}) : super(key: key);

  @override
  _p05ViewState createState() => new _p05ViewState();
}

class _p05ViewState extends StateMVC<p05View> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final TAG = "p05View:";
  p02Model _model;
  BuildContext _myContext;
  RandomColor _randomColor = RandomColor();
  Color _textColor;


  _p05ViewState() : super(p02Model()) {
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
                      SizedBox(height: 19.h,),
                      Container(
                        height: 24.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 85.w),
                        child: AutoSizeText(
                          _model.keyString2("add_account_query"),
                          style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: _model.getFontFamily(), ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      Container(
                        height: 255.h,
                        width: 360.w,
                        margin: EdgeInsets.only(left: 30.w, right: 40.w),
                        child: SimpleGroupedCheckbox<int>(
                            isLeading: true,
                            controller: _model.groupController,
                            //groupTitle:"Basic",
                            onItemSelected: (data) {
                              Fimber.i('$TAG onItemSelected: data = $data');
                              _model.selectedAccount = data;
                            },
                            // disableItems: ["5"],
                            itemsTitle: [_model.keyString2("main_account"), _model.keyString2("child_account"), ],
                            values: [1, 2,],
                            groupStyle: GroupStyle(
                                activeColor: Colors.black,
                                itemTitleStyle: TextStyle(fontSize: 20.sp)),
                            checkFirstElement: true
                        ),

                      ),
                      SizedBox(height: 82.h,),
                      GestureDetector(
                        onTap: (){
                          Fimber.i('$TAG onTap: btn_next_step:');
                          _model.navigationService.push(routes.p0607ViewRoute, arguments: [_model.selectedAccount,]);
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
                    "V01-05",
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
