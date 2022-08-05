import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

import '../../core/services/global_service.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';

class PageOne extends StatefulWidget {
  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final NavigationService _navigationService = locator<NavigationService>();
  final GlobalService globalService = locator<GlobalService>();

  @override
  void initState() {
    Fimber.i('initState:');
    super.initState();
  }

  @override
  void dispose() {
    Fimber.i('dispose:');
    super.dispose();
  }

  _go2Login(){
    // _navigationService.replace(routes.LoginViewRoute, arguments: [0, '登入']);
  }

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () => _go2Login(),
              child: Text(
                globalService.keyString('test_results'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color:  Colors.black,),
              ),
            ),
          ],
        ),
      );
  }
}
