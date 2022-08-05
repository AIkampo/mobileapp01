// @dart=2.9
import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../core/services/global_service.dart';
import '../../locator.dart';

class PageFour extends StatefulWidget {
  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
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
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              initialData: null,
              builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
                if(!snapshot.hasData) {
                  return Container();
                } else {
                  return  Text(
                    globalService.keyString('alliance_clinic'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color:  Colors.black,),
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
          ],
        ),
      );
  }
}
