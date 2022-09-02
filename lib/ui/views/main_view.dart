// @dart=2.9
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/viewmodels/main_model.dart';
import '../../ui/pageviews/pagefour.dart';
import '../../ui/views/base_view.dart';
import '../../ui/widgets/nav_button.dart';
import '../pageviews/p34_view.dart';
import '../pageviews/p44_view.dart';
import '../pageviews/p50_view.dart';
import '../pageviews/p77_view.dart';


class MainView extends StatefulWidget {
  MainView();

  @override
  _MainViewState createState() => new _MainViewState();
}

class _MainViewState extends StateMVC<MainView> with SingleTickerProviderStateMixin, AfterLayoutMixin {
  MainModel _model;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TAG = "_MainViewState:";
  final Color backgroundColor = Colors.white;


  PageController _pageController;
  BuildContext _myContext;
  List<Widget> pages=[p34View(), p44View(), p50View(), PageFour(), p77View(), //0~4
  ];
  bool isNavibarVisible = true;
  bool _INIT = true;

  _MainViewState() : super(MainModel()) {
    _model = controller;
    _model.globalService.model = _model;
  }

  @override
  void initState() {
    Fimber.i('initState:');
    super.initState();
    _model.globalService.vnLoading = new ValueNotifier(_model.globalService.bLoading);
    _pageController = PageController(initialPage: _model.globalService.selectedIndex);
    _model.checkConnectedDevices();
  }

  void afterFirstLayout(BuildContext context) async {
    Fimber.i('$TAG afterFirstLayout:');
    if (_model.globalService.bIsAndroid) {
      // await _model.globalService.getSinglePermissionStatus(Permission.locationWhenInUse);
      await Permission.locationWhenInUse.request();
      var status = await Permission.locationWhenInUse.status;
      if (status.isDenied) {
        _model.showSnackBar2('Location permission is NOT granted.');
      } else {
        Location location = new Location();
        bool enabled = await location.serviceEnabled();
        Fimber.i('$TAG afterFirstLayout: enabled = $enabled,');
        if(!enabled) {
          _model.showSnackBar2('Location switch is NOT enabled.');
        }
      }
      await Permission.bluetooth.request();
      status = await Permission.bluetooth.status;
      if(status.isDenied){
        Fimber.i('$TAG afterFirstLayout: bluetooth status.isDenied!');
      } else {
        Fimber.i('$TAG afterFirstLayout: bluetooth status.isGranted');
      }
      await Permission.bluetoothScan.request();
      status = await Permission.bluetoothScan.status;
      if(status.isDenied){
        Fimber.i('$TAG afterFirstLayout: bluetoothScan.isDenied!');
      } else {
        Fimber.i('$TAG afterFirstLayout: bluetoothScan.isGranted');
      }
      await Permission.bluetoothConnect.request();
      status = await Permission.bluetoothConnect.status;
      if(status.isDenied){
        Fimber.i('$TAG afterFirstLayout: bluetoothConnect.isDenied!');
      } else {
        Fimber.i('$TAG afterFirstLayout: bluetoothConnect.isGranted');
      }
    }
  }

  @override
  void dispose() {
    Fimber.i('dispose:');
    _model.globalService.hideKeyboard(context);
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    Fimber.i('onSelectTab: index = $index');
    // if(_model.globalService.isFirstTimeShelf&&_model.globalService.PageNum==1) return;
    // _model.globalService.vnPageNum.value = _model.globalService.PageNum = index;
    // _model.globalService.vnPageNum.notifyListeners();
    _pageController.jumpToPage(index);
    setState(() {
      _model.globalService.selectedIndex = index;
      isNavibarVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_INIT) {
      _INIT = false;
      _model.globalService.myContext = _myContext = context;
      _model.globalService.doResponsiveCalc(context);
    }
    final mediaQueryData = MediaQuery.of(context);
    return ScreenUtilInit(
      designSize: _model.globalService.defaultScreenSize,
      minTextAdapt: true,
      builder: (_, child) {
        return BaseView(
          model: _model,
          mvcBuilder: (_, __) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: MediaQuery(
              data: mediaQueryData.copyWith(textScaleFactor: 1.0),
              child: Scaffold(
                key: _scaffoldKey,
                body: DoubleBackToCloseApp(
                  snackBar: SnackBar(content: Text(_model.keyString2( "double_click"), )),
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      Fimber.i('PageView: index = $index');
                      _model.onPageChanged(index);
                    },
                    children: pages,
                  ),
                ),
                bottomNavigationBar: Visibility(
                  visible: isNavibarVisible,
                  child: BottomAppBar(
                    // notchMargin: 0,
                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NavButton(
                          icon: ImageIcon(AssetImage("assets/images/icon/nb_0.png"), color: _model.globalService.selectedIndex==0?Colors.black:Colors.black.withOpacity(0.5)),
                          text: _model.keyString2("test_results"),
                          focus: _model.globalService.selectedIndex==0?true:false,
                          onPressed: () => _onItemTapped(0),
                          transform: _model.globalService.selectedIndex==0?-4.w:0,
                        ),
                        NavButton(
                          icon: ImageIcon(AssetImage("assets/images/icon/nb_1.png"), color: _model.globalService.selectedIndex==1?Colors.black:Colors.black.withOpacity(0.5)),
                          text: _model.keyString2('health_guidelines'),
                          focus: _model.globalService.selectedIndex==1?true:false,
                          onPressed: () => _onItemTapped(1),
                          transform: 0,
                        ),
                        NavButton(
                          icon: ImageIcon(AssetImage("assets/images/icon/nb_2.png"), color: _model.globalService.selectedIndex==2?Colors.black:Colors.black.withOpacity(0.5)),
                          text: _model.keyString2('information_centre'),
                          focus: _model.globalService.selectedIndex==2?true:false,
                          onPressed: () => _onItemTapped(2),
                          transform: 0,
                        ),
                        NavButton(
                          icon: ImageIcon(AssetImage("assets/images/icon/nb_3.png"), color: _model.globalService.selectedIndex==3?Colors.black:Colors.black.withOpacity(0.5)),
                          text: _model.keyString2('alliance_clinic'),
                          focus: _model.globalService.selectedIndex==3?true:false,
                          onPressed: () => _onItemTapped(3),
                          transform: 0,
                        ),
                        NavButton(
                          icon: ImageIcon(AssetImage("assets/images/icon/nb_4.png"), color: _model.globalService.selectedIndex==4?Colors.black:Colors.black.withOpacity(0.5)),
                          text: _model.keyString2('setup'),
                          focus: _model.globalService.selectedIndex==4?true:false,
                          onPressed: () => _onItemTapped(4),
                          transform: _model.globalService.selectedIndex==4?4.w:0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
