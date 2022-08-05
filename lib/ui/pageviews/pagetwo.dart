import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';

import '../../core/services/global_service.dart';
import '../../locator.dart';

class PageTwo extends StatefulWidget {
  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
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

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              globalService.keyString('health_guidelines'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color:  Colors.black,),
            ),
          ],
        ),
      );
  }
}
