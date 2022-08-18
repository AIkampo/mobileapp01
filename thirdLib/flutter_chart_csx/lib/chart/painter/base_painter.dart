// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/chart/bean/chart_bean.dart';
import 'package:flutter_chart_csx/chart/enum/painter_const.dart';

class BasePainter extends CustomPainter {
  //基础设置
  BaseBean baseBean;

  @override
  void paint(Canvas canvas, Size size) {
    baseBean ??= BaseBean();
    baseBean
      ..xyLineWidth ??= 2
      ..xColor ??= defaultColor
      ..yColor ??= defaultColor
      ..isShowBorderTop ??= false
      ..isShowBorderRight ??= false
      ..isLeftYDialSub ??= true
      ..isShowX ??= true
      ..yMax ??= 100.0
      ..basePadding ??= defaultBasePadding
      ..isShowHintX ??= false
      ..isShowHintY ??= false
      ..hintLineColor ??= defaultColor
      ..hintLineWidth ??= 1.0
      ..isHintLineImaginary ??= false
      ..isShowXScale ??= false
      ..isShowYScale ??= false
      ..rulerWidth ??= 4.0;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
