// @dart=2.9
//flutter build apk --release --no-sound-null-safety
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared/app_colors.dart';

class NavButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool focus;
  final Function onPressed;
  final double transform;

  NavButton({Key key, this.icon, this.text, this.focus, this.onPressed, this.transform})
      : super(key: key);

  TextStyle _normalStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5));
  TextStyle _focusStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black);


  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: transform!=0?1.1:1.0,
      child: Container(
        transform: Matrix4.translationValues(transform, 0, 0.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: focus?[
                deepBgColor,
                lightBgColor,
              ]:[
                Colors.white,
                Colors.white,
              ],
            )
        ),
        child: IconButton(
          iconSize: 48.w,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                // transform: Matrix4.translationValues(-6, -6, 0.0),
                width: 24.w,
                height: 24.h,
                // margin: EdgeInsets.all(4),
                child: icon,
              ),
              // SizedBox(height: 3,),
              Container(
                // transform: Matrix4.translationValues(0.0, 2, 0.0),
                // margin: EdgeInsets.only(top: 4),
                alignment: Alignment.center,
                child: AutoSizeText(
                  text,
                  style: focus? _focusStyle:_normalStyle,
                  minFontSize: 12.sp,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
          onPressed: onPressed as void Function(),
        ),
      ),
    );
  }
}
