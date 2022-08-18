// @dart=2.9
import 'dart:async';

import 'package:flutter_i18n/flutter_i18n.dart';
import '../../core/services/i18n_service.dart';
import '../../core/services/navigation_service.dart';
import '../../core/utils/logger.dart';
import '../../locator.dart';
import '../../ui/shared/route_paths.dart' as routes;

import 'base_model.dart';

class SplashModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final I18nService _i18nService = locator<I18nService>();

  bool bVisible = false;

  start() async {
    recordDebug("splash start");
    await Future.delayed(Duration(milliseconds: 10));
    var startTime = DateTime.now();
    _i18nService.currentLang = FlutterI18n.currentLocale(context);
    await _checkWaitTime(startTime, () {
      // _navigationService.replace(routes.LoginViewRoute, arguments: [0, '登入']);
      // _navigationService.replace(routes.MainRoute);
      _navigationService.replace(routes.p02ViewRoute);
    });
  }

  _checkWaitTime(DateTime startTime, Function action) async {
    var waitTime = DateTime.now().difference(startTime);

    if (waitTime < Duration(seconds: 2)) {
      await Future.delayed(
          Duration(milliseconds: 2000 - waitTime.inMilliseconds));
    }
    if (bDestroy == false) action();
  }
}
