

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

const double bodySize = 16;

const double littleSize = 12;

const headingblackStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black);
const miniblackStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0, color: Colors.black);
const headingwhiteStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white);

const definefocusBlackStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 22.0, color: defineFocus);
const definenomalBlackStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: defineNormal);

const drawerStyle = TextStyle(fontSize: 16, color: Colors.white);

const greenStyle = TextStyle(fontSize: 16, color: textGreenColor);

const titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: titleBlackColor);
const subtitleBlackStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: titleBlackColor);

const normaltitleStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0, color: titleBlackColor);
const normalBigStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 32.0, color: titleBlackColor);
const normalLargeStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 22.0, color: titleBlackColor);

const bluetitleStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.blue);
const blueminiStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.blue);
const blackminiStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black);
const blackMiniTitleStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 12.5, color: Colors.black);
const greyminiStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.black);
const whiteminiStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.white);

const whitetitleStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: Colors.white);

const subtitleStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0, color: greyTextColor);

const titleButtonStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0, color: titleBlackColor);

const titleButtonStyleGreen = TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0, color: appBarGreenColor);

const subheadStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: greyTextColor, fontFamily: "SF-Pro-Text-Regular");

const buttonRedStyle = TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF3B30), fontFamily: "SF-Pro-Text-Regular");

const amountRedStyle = TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF3B30), fontFamily: "SF-Pro-Text-Regular", fontSize: 32.0, decoration: TextDecoration.underline);

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "SF-Pro-Text-Regular");

const listButtonStyle = TextStyle(color: greyTextColor, fontSize: 20, fontWeight: FontWeight.w500);

TextStyle getTitleStyle({double fontSize = 20.0}) {
  return titleStyle.copyWith(fontSize : fontSize);
}

TextStyle getSubheadStyle({double fontSize = 22.0}) {
  return subheadStyle.copyWith(fontSize: fontSize);
}

TextStyle getButtonStyle({double fontSize = 22.0}) {
  return TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: Color(0xFF01BEDB), fontFamily: "SF-Pro-Text-Regular");
}

TextStyle getBodyStyle({double fontSize = 20.0}) {
  return TextStyle(fontSize: fontSize, color: greyTextColor, fontFamily: "SF-Pro-Text-Regular", fontWeight: FontWeight.w500);
}

TextStyle getTipStyle({double fontSize = 20.0}) {
  return TextStyle(fontSize: fontSize, color: Color(0xFF808F98), height: 1.4, fontFamily: "SF-Pro-Text-Regular");
}



double buttonLetterSpacing = 3.0;