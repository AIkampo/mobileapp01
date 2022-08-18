// @dart=2.9
import 'dart:async';
import 'dart:typed_data';

import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:otp_count_down/otp_count_down.dart';

import '../../vo/deviceversion_response_vo.dart';
import '../../vo/qrcode_response_vo.dart';
import '../../vo/token_response_vo.dart';
import '../models/Constant.dart';
import 'base_model.dart';
import 'package:http/http.dart' as http;
import '../../ui/shared/icon_names.dart' as icons;

enum PageNum{
  WifiSetup, DevicePage, OtaView, PageFour,//0~4
}

class MainModel extends BaseModel {
  final TAG = "MainModel:";
  bool bDataReady = true;
  FocusNode passFocusNode;
  TextEditingController passwordCont = TextEditingController();
  bool bEditPassword = false;
  String _password;
  OTPCountDown _otpCountDown = null;
  int _otpTimeInMS; // = 1000 * 60 * 20; //20 mins
  bool _isOTPing = false;
  BluetoothCharacteristic _characteristicRead;
  BluetoothCharacteristic _characteristicWrite;
  BluetoothCharacteristic _characteristicOTA;
  Duration oneSec = Duration(seconds:1);
  ScrollController scrollController;


  String jsonCycle = '{"success":true,"data":[{"id":585,"name":"特異性血管高壓性病變","d":0.345,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":326,"name":"心肌收縮不良","d":0.362,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":345,"name":"動脈粥樣硬化","d":0.426,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":350,"name":"心律不整","d":0.511,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":632,"name":"血管阻塞性局部缺血","d":0.553,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":353,"name":"心臟不規律收縮現象","d":0.557,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":348,"name":"狹心症","d":0.622,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":352,"name":"陣發性心跳過速現象","d":0.691,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":340,"name":"心肌炎","d":1.168,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":343,"name":"心肌硬化症","d":1.24,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":341,"name":"類風濕性心臟炎","d":1.281,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":627,"name":"神經性血管病變","d":1.75,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":351,"name":"纖毛型顫動性心律不整","d":4.252,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":339,"name":"主動脈下狹窄","d":15.785,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3036,"name":"皮肌炎","d":15.858,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3054,"name":"緊縮性心肌病變","d":17.512,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":618,"name":"淋巴管炎","d":18.241,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2408,"name":"Still氏症候群","d":18.693,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":641,"name":"過敏性血管炎","d":18.696,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2999,"name":"真性紅血球增多症","d":18.742,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2409,"name":"賴透氏症候群","d":19.187,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3053,"name":"心肌肥大現象","d":19.206,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":338,"name":"鬱滯型緊縮性心肌病變","d":19.462,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":646,"name":"低血壓症","d":19.688,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3063,"name":"心肺衰竭","d":19.713,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3007,"name":"萊姆病","d":19.74,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":635,"name":"偏頭痛","d":19.931,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3021,"name":"高血脂症","d":20.258,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":468,"name":"心內膜炎","d":20.611,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":359,"name":"結節性動脈外層炎","d":20.941,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2410,"name":"貝氏症候群","d":21.378,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":342,"name":"心包炎","d":21.437,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":615,"name":"神經痛","d":21.447,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3059,"name":"主動脈狹窄","d":21.719,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2997,"name":"心動脈瘤","d":22.005,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3002,"name":"大動脈慢性發炎","d":22.043,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":140,"name":"肝-大腦的行為異常","d":22.127,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3102,"name":"僧帽瓣脫垂","d":22.455,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":925,"name":"類肉瘤病","d":22.688,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3120,"name":"肺動脈狹窄","d":22.982,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3111,"name":"馬凡氏症候群","d":23.504,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":924,"name":"紅斑性狼瘡","d":23.642,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":356,"name":"閉塞型血栓性血管炎","d":23.849,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":354,"name":"閉塞性動脈內膜炎","d":24.244,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":647,"name":"痙攣","d":24.539,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":346,"name":"主動脈瘤","d":24.676,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":397,"name":"腦部循環不良現象","d":24.749,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":1754,"name":"癲癇(陣發性大腦功能失常現象)","d":24.827,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3150,"name":"再發性精神狀態異常現象","d":25.336,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3129,"name":"三尖瓣硬化","d":25.341,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":645,"name":"強迫性精神官能症","d":25.557,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3128,"name":"三尖瓣閉鎖不全","d":25.738,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2983,"name":"主動脈瓣閉鎖不全","d":25.842,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3971,"name":"慢性疲勞症候群","d":26.122,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":386,"name":"精神狀態異常現象","d":26.268,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3080,"name":"僧帽瓣閉鎖不全","d":26.358,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":349,"name":"心臟傳導阻斷性病變","d":26.83,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":388,"name":"躁鬱症","d":27.091,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":2984,"name":"主動脈瓣狹窄","d":27.526,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":360,"name":"硬皮病","d":28.445,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3019,"name":"水腦","d":28.646,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3079,"name":"僧帽瓣狹窄","d":29.723,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3114,"name":"脊椎動脈病變","d":29.745,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":347,"name":"心肌梗塞","d":29.788,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":391,"name":"神經退化性衰弱病變","d":30.408,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":389,"name":"反應性精神錯亂","d":30.838,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3049,"name":"臟躁症(精神性神經官能症)","d":31.217,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3152,"name":"遺尿現象","d":31.247,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":361,"name":"血小板減少性微血管病變","d":32.01,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":384,"name":"精神耗弱現象","d":32.262,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3113,"name":"阿丹斯--史妥克斯二氏病","d":32.447,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":392,"name":"腦膜炎","d":33.473,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":512,"name":"腦震盪","d":34.813,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3099,"name":"脊髓灰白質炎","d":34.828,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3003,"name":"巴金森氏症","d":35.693,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":398,"name":"腦動脈瘤","d":37.011,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":396,"name":"出血性損傷現象","d":37.172,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":393,"name":"蜘蛛膜炎","d":38.378,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3132,"name":"苯酮尿症","d":38.593,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":416,"name":"動靜脈瘤","d":38.789,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":411,"name":"腦肉瘤","d":38.995,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":390,"name":"多發性硬化症","d":40.622,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3072,"name":"腦脊髓膜膨出","d":40.936,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":394,"name":"腦炎","d":41.186,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":912,"name":"精神發育不全","d":41.492,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":401,"name":"腦腺瘤","d":42.317,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":666,"name":"小兒腦性麻痺","d":42.814,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":403,"name":"腦室管膜瘤","d":43.11,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":395,"name":"腦島局部缺血現象","d":43.555,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":408,"name":"寡樹突膠質瘤","d":43.677,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":383,"name":"亨丁頓氏舞蹈症","d":44.109,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":404,"name":"腦神經叢乳突瘤","d":44.308,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3076,"name":"心臟黏液瘤","d":44.346,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":1756,"name":"卡波西氏肉瘤","d":44.758,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":406,"name":"腦血管母細胞瘤","d":46.766,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":2996,"name":"心臟澱粉樣變性病變","d":46.849,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3001,"name":"阿茲海默病","d":47.009,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":409,"name":"腦神經膠母細胞瘤","d":47.08,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":402,"name":"腦神經節細胞瘤","d":47.472,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3068,"name":"原子輻射病","d":48.105,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":407,"name":"腦星狀細胞瘤","d":48.151,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":405,"name":"腦海綿體母細胞瘤","d":48.3,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":400,"name":"腦膜瘤","d":48.479,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":382,"name":"肌肉協調不良現象(慢性脊柱關節粘連病)","d":51.048,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":410,"name":"腦神經管胚細胞瘤","d":51.691,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":399,"name":"腦神經鞘瘤","d":53.817,"description":null,"img":null,"orgname":"大腦動脈，俯視面"}]}';
  String jsonFood = '{"success":true,"data":[{"id":2731,"name":"優格","d":0.013,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2754,"name":"白花椰菜","d":0.014,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2794,"name":"香蕉","d":0.015,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2788,"name":"杏桃","d":0.016,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2830,"name":"燕麥","d":0.019,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2820,"name":"燕麥粥","d":0.02,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2812,"name":"黑醋栗","d":0.024,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2752,"name":"球芽甘藍(小捲心菜)","d":0.026,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2725,"name":"克非爾發酵乳","d":0.028,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2693,"name":"鱒魚","d":0.033,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2878,"name":"綠茶","d":0.033,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2860,"name":"蜂蜜","d":0.034,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2753,"name":"紫高麗菜","d":0.035,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2748,"name":"薄葉菜","d":0.035,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2751,"name":"高麗菜","d":0.037,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2776,"name":"南瓜","d":0.042,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2813,"name":"西洋李","d":0.044,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2667,"name":"小牛的肝臟","d":0.051,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2826,"name":"天然米","d":0.052,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2691,"name":"鱘魚","d":0.055,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';

  @override
  void initState() async {
    Fimber.i("$TAG initState:");
    super.initState();
    _initialize();
  }

  @override
  dispose() async {
    Fimber.i("$TAG: dispose:");
    super.dispose();
  }

  _initialize() async {
    Fimber.i('$TAG _initialize: bDataReady = $bDataReady');
    passFocusNode = new FocusNode();
    passFocusNode.addListener(() => clickPassword());
    bDataReady = true;
    notifyListeners();
  }

  String getLevelBg(int _index){
    String _level = icons.CommonImage.g_level;
    int _score = scores9[_index];
    if(_score<70){
      if(_score<50) {
        if(_score<20) {
          _level = icons.CommonImage.r_level;
        } else _level = icons.CommonImage.o_level;
      } else _level = icons.CommonImage.y_level;
    }
    return _level;
  }

  clickPassword(){
    if(passFocusNode.hasFocus) {
      Fimber.i('$TAG clickPassword: hasFocus:');
      _password = passwordCont.text.toString();
      bEditPassword = true;
    } else {
      Fimber.i('$TAG clickPassword: !hasFocus:');
      bEditPassword = false;
    }
  }

  gotoDevice(ScanResult _result){
    Fimber.i("$TAG: gotoDevice: _result = ${_result.device.name}");
    showFloatingSnackBar('i am here');
    // WidgetsBinding.instance.addPostFrameCallback((_) => _wifisetup());
  }

  onPageChanged(int index) {
  }


  List<int> _getIntList(String _value){
    Fimber.i('$TAG _getIntList: _value = $_value');
    int _length = _value.length;
    // List<int> _bytes = utf8.encode(_value);
    List<int> _bytes = _value.codeUnits;
    Fimber.i('$TAG _getIntList: _length = $_length, _bytes = ${_bytes}');
    return _bytes;
  }

  checkConnectedDevices() async{
    List<BluetoothDevice> connectedDevices = await FlutterBluePlus.instance.connectedDevices;
    int _length = connectedDevices.length;
    Fimber.i('checkConnectedDevices: _length = $_length');
    for(int i=0; i<_length; i++){
      await connectedDevices[i].disconnect();
    }
    _characteristicRead = _characteristicWrite = _characteristicOTA = null;
    Fimber.i('checkConnectedDevices: done!');
  }

}
