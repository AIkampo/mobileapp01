import 'package:aihealer_a01/ui/views/p02_view.dart';
import 'package:aihealer_a01/ui/views/p03_view.dart';
import 'package:aihealer_a01/ui/views/p04_view.dart';
import 'package:aihealer_a01/ui/views/p05_view.dart';
import 'package:aihealer_a01/ui/views/p0607_view.dart';
import 'package:aihealer_a01/ui/views/p08_view.dart';
import 'package:aihealer_a01/ui/views/p09_view.dart';
import 'package:aihealer_a01/ui/views/p10_view.dart';
import 'package:aihealer_a01/ui/views/p11_view.dart';
import 'package:aihealer_a01/ui/views/p12_view.dart';
import 'package:aihealer_a01/ui/views/p13_view.dart';
import 'package:aihealer_a01/ui/views/p15_view.dart';
import 'package:aihealer_a01/ui/views/p16_view.dart';
import 'package:aihealer_a01/ui/views/p18_view.dart';
import 'package:aihealer_a01/ui/views/p20_view.dart';
import 'package:aihealer_a01/ui/views/p21_view.dart';
import 'package:aihealer_a01/ui/views/p22_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/views/main_view.dart';
import 'ui/shared/route_paths.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case routes.p22ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p22View());

    case routes.p09ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p09View());

    case routes.p21ViewRoute:
      return MaterialPageRoute(
          builder: (context) => p21View());

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
