import 'package:aihealer_a01/ui/views/p02_view.dart';
import 'package:aihealer_a01/ui/views/p03_view.dart';
import 'package:aihealer_a01/ui/views/p04_view.dart';
import 'package:aihealer_a01/ui/views/p05_view.dart';
import 'package:aihealer_a01/ui/views/p0607_view.dart';
import 'package:aihealer_a01/ui/views/p08_view.dart';
import 'package:aihealer_a01/ui/views/p09_view.dart';
import 'package:aihealer_a01/ui/views/p10_view.dart';
import 'package:aihealer_a01/ui/views/p11_view.dart';
import 'package:aihealer_a01/ui/views/p120_view.dart';
import 'package:aihealer_a01/ui/views/p12_view.dart';
import 'package:aihealer_a01/ui/views/p13_view.dart';
import 'package:aihealer_a01/ui/views/p15_view.dart';
import 'package:aihealer_a01/ui/views/p16_view.dart';
import 'package:aihealer_a01/ui/views/p18_view.dart';
import 'package:aihealer_a01/ui/views/p20_view.dart';
import 'package:aihealer_a01/ui/views/p21_view.dart';
import 'package:aihealer_a01/ui/views/p22_view.dart';
import 'package:aihealer_a01/ui/views/p23_view.dart';
import 'package:aihealer_a01/ui/views/p25_view.dart';
import 'package:aihealer_a01/ui/views/p26_view.dart';
import 'package:aihealer_a01/ui/views/p27_view.dart';
import 'package:aihealer_a01/ui/views/p28_view.dart';
import 'package:aihealer_a01/ui/views/p28x_view.dart';
import 'package:aihealer_a01/ui/views/p29_view.dart';
import 'package:aihealer_a01/ui/views/p35to43_view.dart';
import 'package:aihealer_a01/ui/views/p45_view.dart';
import 'package:aihealer_a01/ui/views/p46_view.dart';
import 'package:aihealer_a01/ui/views/p51_view.dart';
import 'package:aihealer_a01/ui/views/p54_view.dart';
import 'package:aihealer_a01/ui/views/p62_view.dart';
import 'package:aihealer_a01/ui/views/p63_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/views/main_view.dart';
import 'ui/shared/route_paths.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case routes.p28xViewRoute:
      var list = settings.arguments as List;
      int page = list[0];
      return MaterialPageRoute(
          builder: (context) => p28xView(page: page));

    case routes.p29ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p29View());

    case routes.p28ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p28View());

    case routes.p26ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p26View());

    case routes.p27ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p27View());

    case routes.p25ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p25View());

    case routes.p23ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p23View());

    case routes.p46ViewRoute:
      var list = settings.arguments as List;
      int page = list[0];
      String json = list[1];
      return MaterialPageRoute(
          builder: (context) => p46View(page: page, json: json, ));

    case routes.p120ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p120View());

    case routes.p63ViewRoute:
      var list = settings.arguments as List;
      int program = list[0];
      return MaterialPageRoute(
          builder: (context) => p63View(program: program));

    case routes.p62ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p62View());

    case routes.p54ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p54View());

    case routes.p51ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p51View());

    case routes.p45ViewRoute:
      var list = settings.arguments as List;
      int score = list[0];
      String json = list[1];
      return MaterialPageRoute(
          builder: (context) => p45View(score: score, json: json));

    case routes.p35to43ViewRoute:
      var list = settings.arguments as List;
      int score = list[0];
      String json = list[1];
      int page = list[2];
      return MaterialPageRoute(
          builder: (context) => p35to43View(score: score, json: json, page: page));

    case routes.p22ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p22View());

    case routes.p09ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p09View());

    case routes.p21ViewRoute:
      var list = settings.arguments as List;
      int page = list[0];
      return MaterialPageRoute(
          builder: (context) => p21View(page: page));

    case routes.p20ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p20View());

    case routes.p18ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p18View());

    case routes.p16ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p16View());

    case routes.p15ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p15View());

    case routes.p11ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p11View());

    case routes.p03ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p03View());

    case routes.p10ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p10View());

    case routes.p08ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p08View());

    case routes.p0607ViewRoute:
      var list = settings.arguments as List;
      int type = list[0];
      return MaterialPageRoute(
          builder: (context) => p0607View(type: type));

    case routes.p05ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p05View());

    case routes.p13ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p13View());

    case routes.p12ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p12View());

    case routes.p04ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p04View());

    case routes.p02ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p02View());

    case routes.MainRoute:
      return MaterialPageRoute(
          builder: (context) => MainView());

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
