// @dart=2.9
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:otp_count_down/otp_count_down.dart';

import '../../ui/shared/icon_names.dart' as icons;
import 'base_model.dart';

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
  List<int> scores9 = [
    19,
    21,
    52,
    61,
    64,
    68,
    57,
    67,
    77
  ];

  String jsonFood = '{"success":true,"data":[{"id":2731,"name":"優格","d":0.013,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2754,"name":"白花椰菜","d":0.014,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2794,"name":"香蕉","d":0.015,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2788,"name":"杏桃","d":0.016,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2830,"name":"燕麥","d":0.019,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2820,"name":"燕麥粥","d":0.02,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2812,"name":"黑醋栗","d":0.024,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2752,"name":"球芽甘藍(小捲心菜)","d":0.026,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2725,"name":"克非爾發酵乳","d":0.028,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2693,"name":"鱒魚","d":0.033,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2878,"name":"綠茶","d":0.033,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2860,"name":"蜂蜜","d":0.034,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2753,"name":"紫高麗菜","d":0.035,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2748,"name":"薄葉菜","d":0.035,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2751,"name":"高麗菜","d":0.037,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2776,"name":"南瓜","d":0.042,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2813,"name":"西洋李","d":0.044,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2667,"name":"小牛的肝臟","d":0.051,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2826,"name":"天然米","d":0.052,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":2691,"name":"鱘魚","d":0.055,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';
  String jsonMicro = '{"success":true,"data":[{"id":21398,"name":"礦產 - Jod - Mineral","d":0.251,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21390,"name":"鉀礦 - Potassium - Mineral","d":0.253,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21391,"name":"組氨酸 - 氨基酸 Histidin - amino acid","d":0.255,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21402,"name":"磷 - 礦 - Phosphorus - Mineral","d":0.256,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21380,"name":"礦產銅 - Copper - Mineral","d":0.263,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21376,"name":"異亮氨酸的氨基酸 - Isoleucine - amino acid","d":0.264,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21396,"name":"葉酸 Folic acid","d":0.264,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21395,"name":"鈣 - 礦產 - Calcium - Mineral","d":0.27,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21384,"name":"色氨酸的氨基酸 - Tryptophan - amino acid","d":0.271,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":21409,"name":"Q10（維生素） - Q10 (Vitamin)","d":0.273,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';
  String jsonEnerge = '{"success":true,"data":[{"id":20398,"name":"銀白色 Silvery white","d":0.313,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20403,"name":"蘋果綠色 - Apple green","d":0.336,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20389,"name":"灰暗 Gray","d":0.353,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20387,"name":"金的 Gold","d":0.36,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20420,"name":"橙子 Orange","d":0.384,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';
  String jsonAcupuncture = '{"success":true,"data":[{"id":20590,"name":"GV19  後頂","d":0.368,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20567,"name":"ST32  伏兔","d":0.378,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20509,"name":"GB13  本神","d":0.378,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20628,"name":"GB10  浮白","d":0.387,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20682,"name":"BL26   關元俞(第5腰椎棘突下,旁開1.5寸)","d":0.387,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20816,"name":"KI2  然穀(滎穴)","d":0.388,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20625,"name":"ST41   解溪(經穴)","d":0.392,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20640,"name":"ST44  內庭(滎穴)","d":0.399,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20720,"name":"BL46  膈關","d":0.479,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":20692,"name":"ST29  歸來","d":0.521,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';
  String jsonDiamond = '{"success":true,"data":[{"id":4041,"name":"石英","d":0.898,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4033,"name":"玉滴石","d":0.92,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4061,"name":"撒拉弗石","d":0.999,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4038,"name":"蛇紋石","d":1.04,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4024,"name":"天河石","d":1.148,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4053,"name":"黃玉","d":1.207,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4017,"name":"葉臘石","d":1.564,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":4016,"name":"東菱石","d":1.771,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":4055,"name":"薔薇輝石","d":2.252,"description":null,"img":null,"orgname":"眼球；右側"},{"id":4050,"name":"黑瑪瑙","d":2.596,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';

  String jsonCycle = '{"success":true,"data":[{"id":585,"name":"特異性血管高壓性病變","d":0.345,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":326,"name":"心肌收縮不良","d":0.362,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":345,"name":"動脈粥樣硬化","d":0.426,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":350,"name":"心律不整","d":0.511,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":632,"name":"血管阻塞性局部缺血","d":0.553,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":353,"name":"心臟不規律收縮現象","d":0.557,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":348,"name":"狹心症","d":0.622,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":352,"name":"陣發性心跳過速現象","d":0.691,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":340,"name":"心肌炎","d":1.168,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":343,"name":"心肌硬化症","d":1.24,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":341,"name":"類風濕性心臟炎","d":1.281,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":627,"name":"神經性血管病變","d":1.75,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":351,"name":"纖毛型顫動性心律不整","d":4.252,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":339,"name":"主動脈下狹窄","d":15.785,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":3036,"name":"皮肌炎","d":15.858,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":3054,"name":"緊縮性心肌病變","d":17.512,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":618,"name":"淋巴管炎","d":18.241,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2408,"name":"Still氏症候群","d":18.693,"description":null,"img":null,"orgname":"大腦動脈，俯視面"},{"id":641,"name":"過敏性血管炎","d":18.696,"description":null,"img":null,"orgname":"心臟後壁的血管"},{"id":2999,"name":"真性紅血球增多症","d":18.742,"description":null,"img":null,"orgname":"心臟後壁的血管"}]}';
  String jsonDigestion = '{"success":true,"data":[{"id":314,"name":"痙攣性結腸炎","d":0.49,"description":null,"img":null,"orgname":"結腸壁"},{"id":180,"name":"萎縮性胃炎","d":0.581,"description":null,"img":null,"orgname":"胃壁"},{"id":184,"name":"卡他性胃炎","d":0.585,"description":null,"img":null,"orgname":"胃壁"},{"id":3140,"name":"慢性回流性胃炎","d":1.434,"description":null,"img":null,"orgname":"胃壁"},{"id":188,"name":"增殖型萎縮性胃炎","d":1.587,"description":null,"img":null,"orgname":"胃壁"},{"id":611,"name":"腸道菌種不良現象","d":1.692,"description":null,"img":null,"orgname":"十二指腸壁"},{"id":325,"name":"結腸收縮功能不良","d":1.779,"description":null,"img":null,"orgname":"結腸壁"},{"id":179,"name":"肥厚性胃炎","d":1.892,"description":null,"img":null,"orgname":"胃壁"},{"id":195,"name":"糜爛性胃潰瘍","d":2.887,"description":null,"img":null,"orgname":"胃壁"},{"id":538,"name":"膽囊腺瘤","d":2.992,"description":null,"img":null,"orgname":"膽囊"},{"id":204,"name":"十二指腸炎","d":3.257,"description":null,"img":null,"orgname":"法透氏壺腹管"},{"id":3118,"name":"大腸激躁現象","d":3.644,"description":null,"img":null,"orgname":"結腸壁"},{"id":569,"name":"息肉狀胃炎","d":4.043,"description":null,"img":null,"orgname":"胃壁"},{"id":301,"name":"腸炎","d":4.949,"description":null,"img":null,"orgname":"腸道"},{"id":629,"name":"結腸炎","d":5.074,"description":null,"img":null,"orgname":"結腸壁"},{"id":116,"name":"胰臟硬化病變","d":5.091,"description":null,"img":null,"orgname":"法透氏壺腹管"},{"id":3016,"name":"病毒性肝炎","d":6.173,"description":null,"img":null,"orgname":"法透氏壺腹管"},{"id":107,"name":"黏液性膽囊炎","d":7.527,"description":null,"img":null,"orgname":"法透氏壺腹管"},{"id":3071,"name":"間皮腺炎","d":7.705,"description":null,"img":null,"orgname":"結腸壁"},{"id":3040,"name":"長乙狀結腸症","d":8.233,"description":null,"img":null,"orgname":"結腸壁"}]}';
  String jsonUrinary = '{"success":true,"data":[{"id":573,"name":"尿道炎","d":0.469,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":3141,"name":"慢性潛伏性腎絲球腎炎","d":0.588,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":3142,"name":"慢性腎小球腎炎","d":1.162,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":3144,"name":"慢性高血壓性腎絲球腎炎","d":1.218,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":3085,"name":"腎結石現象","d":4.694,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":172,"name":"腎臟淋巴血管瘤","d":5.077,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":3083,"name":"尿崩性病變","d":7.551,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":167,"name":"腎水腫","d":7.914,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":161,"name":"高草酸鹽尿症","d":10.892,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":571,"name":"膀胱腎盂炎","d":11.263,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":162,"name":"高尿酸鹽症","d":12.164,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":585,"name":"特異性血管高壓性病變","d":12.225,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":163,"name":"尿磷酸鹽過多現象","d":14.928,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":2987,"name":"無精蟲症","d":15.164,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":3119,"name":"腎動脈狹窄","d":15.168,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":359,"name":"結節性動脈外層炎","d":15.794,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":920,"name":"腎下垂","d":15.883,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":159,"name":"復發性阻塞型腎盂腎炎","d":16.324,"description":null,"img":null,"orgname":"右腎的後側縱剖面"},{"id":3081,"name":"尿道結石症","d":16.864,"description":null,"img":null,"orgname":"男性膀胱；背面"},{"id":3115,"name":"胡德帕斯協式症","d":17.987,"description":null,"img":null,"orgname":"右腎的後側縱剖面"}]}';
  String jsonEndocrine = '{"success":true,"data":[{"id":122,"name":"慢性復發性胰臟炎","d":0.303,"description":null,"img":null,"orgname":"胰臟組織"},{"id":363,"name":"毒性退化性甲狀腺病變","d":1.361,"description":null,"img":null,"orgname":"甲狀腺；背面圖"},{"id":3020,"name":"醛固醇過多症","d":1.54,"description":null,"img":null,"orgname":"腎上腺"},{"id":585,"name":"特異性血管高壓性病變","d":6.53,"description":null,"img":null,"orgname":"腎上腺"},{"id":646,"name":"低血壓症","d":9.389,"description":null,"img":null,"orgname":"腎上腺"},{"id":3021,"name":"高血脂症","d":9.598,"description":null,"img":null,"orgname":"腎上腺"},{"id":3023,"name":"副甲狀腺功能低下症","d":10.905,"description":null,"img":null,"orgname":"甲狀腺；背面圖"},{"id":3036,"name":"皮肌炎","d":11.735,"description":null,"img":null,"orgname":"腎上腺"},{"id":116,"name":"胰臟硬化病變","d":12.506,"description":null,"img":null,"orgname":"胰臟組織"},{"id":144,"name":"腎上腺瘤","d":12.879,"description":null,"img":null,"orgname":"腎上腺"},{"id":1967,"name":"毒性結狀甲狀腺腫","d":13.468,"description":null,"img":null,"orgname":"甲狀腺；背面圖"},{"id":345,"name":"動脈粥樣硬化","d":13.694,"description":null,"img":null,"orgname":"腎上腺"},{"id":1969,"name":"奎汶氏甲狀腺炎","d":13.838,"description":null,"img":null,"orgname":"甲狀腺；背面圖"},{"id":609,"name":"瀰漫性甲狀腺腫","d":13.909,"description":null,"img":null,"orgname":"甲狀腺；背面圖"},{"id":354,"name":"閉塞性動脈內膜炎","d":14.364,"description":null,"img":null,"orgname":"腎上腺"},{"id":1968,"name":"自體免疫性甲狀腺炎","d":14.466,"description":null,"img":null,"orgname":"甲狀腺；背面圖"},{"id":359,"name":"結節性動脈外層炎","d":14.936,"description":null,"img":null,"orgname":"腎上腺"},{"id":924,"name":"紅斑性狼瘡","d":15.742,"description":null,"img":null,"orgname":"腎上腺"},{"id":143,"name":"缺血性梗塞","d":16.325,"description":null,"img":null,"orgname":"腎上腺"},{"id":627,"name":"神經性血管病變","d":16.478,"description":null,"img":null,"orgname":"腎上腺"}]}';
  String jsonNerve = '{"success":true,"data":[{"id":585,"name":"特異性血管高壓性病變","d":0.356,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":345,"name":"動脈粥樣硬化","d":0.474,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":397,"name":"腦部循環不良現象","d":0.713,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":627,"name":"神經性血管病變","d":1.57,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":390,"name":"多發性硬化症","d":4.105,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":359,"name":"結節性動脈外層炎","d":5.932,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":3007,"name":"萊姆病","d":13.285,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":646,"name":"低血壓症","d":14.098,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":635,"name":"偏頭痛","d":16.04,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":615,"name":"神經痛","d":16.919,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":3036,"name":"皮肌炎","d":17.133,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":925,"name":"類肉瘤病","d":20.053,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":647,"name":"痙攣","d":20.224,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":3150,"name":"再發性精神狀態異常現象","d":20.299,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":1754,"name":"癲癇(陣發性大腦功能失常現象)","d":20.636,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":386,"name":"精神狀態異常現象","d":20.946,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":621,"name":"脊椎神經根病變","d":21.434,"description":null,"img":null,"orgname":"腹部自律神經系統；左側面"},{"id":616,"name":"肋間神經痛","d":21.923,"description":null,"img":null,"orgname":"腹部自律神經系統；左側面"},{"id":3021,"name":"高血脂症","d":22.135,"description":null,"img":null,"orgname":"大腦，俯視圖"},{"id":645,"name":"強迫性精神官能症","d":22.24,"description":null,"img":null,"orgname":"大腦，俯視圖"}]}';
  String jsonLymph = '{"success":true,"data":[{"id":3971,"name":"慢性疲勞症候群","d":0.682,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":3065,"name":"淋巴腺炎症","d":1.495,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":925,"name":"類肉瘤病","d":2.194,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":391,"name":"神經退化性衰弱病變","d":3.126,"description":null,"img":null,"orgname":"胸部自律神經系統；右側面"},{"id":359,"name":"結節性動脈外層炎","d":5.362,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":619,"name":"扁桃體炎","d":6.784,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":626,"name":"腺樣增殖體炎","d":7.387,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":591,"name":"咽炎","d":8.282,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":486,"name":"扁桃腺膿瘍","d":8.876,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":618,"name":"淋巴管炎","d":9.697,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":578,"name":"過敏性反應","d":9.884,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":608,"name":"猩紅熱","d":10.091,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":926,"name":"單核細胞增多症","d":11.838,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":3071,"name":"間皮腺炎","d":12.112,"description":null,"img":null,"orgname":"大腸淋巴管"},{"id":2407,"name":"Felty 氏症狀","d":12.289,"description":null,"img":null,"orgname":"大腸淋巴管"},{"id":3007,"name":"萊姆病","d":12.386,"description":null,"img":null,"orgname":"胸部自律神經系統；右側面"},{"id":2410,"name":"貝氏症候群","d":13.52,"description":null,"img":null,"orgname":"顎扁桃腺"},{"id":1968,"name":"自體免疫性甲狀腺炎","d":13.621,"description":null,"img":null,"orgname":"縱膈腔的淋巴管"},{"id":3021,"name":"高血脂症","d":13.775,"description":null,"img":null,"orgname":"大腸淋巴管"},{"id":635,"name":"偏頭痛","d":13.847,"description":null,"img":null,"orgname":"胸部自律神經系統；右側面"}]}';
  String jsonPerception = '{"success":true,"data":[{"id":1970,"name":"骨質疏鬆","d":1.338,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":3061,"name":"兔眼","d":9.336,"description":null,"img":null,"orgname":"眼球；右側"},{"id":619,"name":"扁桃體炎","d":13.78,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":585,"name":"特異性血管高壓性病變","d":13.814,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":626,"name":"腺樣增殖體炎","d":14.831,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":2407,"name":"Felty 氏症狀","d":15.492,"description":null,"img":null,"orgname":"眼球；右側"},{"id":591,"name":"咽炎","d":15.889,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":593,"name":"神經性皮炎","d":15.907,"description":null,"img":null,"orgname":"眼球；右側"},{"id":3036,"name":"皮肌炎","d":16.367,"description":null,"img":null,"orgname":"眼球；右側"},{"id":3117,"name":"乾性角膜結合膜炎","d":17.134,"description":null,"img":null,"orgname":"眼球；右側"},{"id":3172,"name":"紫質沉著病","d":17.152,"description":null,"img":null,"orgname":"眼球；右側"},{"id":578,"name":"過敏性反應","d":17.406,"description":null,"img":null,"orgname":"眼球；右側"},{"id":650,"name":"腹瀉","d":17.653,"description":null,"img":null,"orgname":"眼球；右側"},{"id":618,"name":"淋巴管炎","d":18.058,"description":null,"img":null,"orgname":"眼球；右側"},{"id":2408,"name":"Still氏症候群","d":18.704,"description":null,"img":null,"orgname":"眼球；右側"},{"id":485,"name":"鼻中膈偏離","d":18.781,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":3100,"name":"花粉症","d":18.998,"description":null,"img":null,"orgname":"額頭的正面的橫截面"},{"id":599,"name":"皮脂漏","d":19.054,"description":null,"img":null,"orgname":"眼球；右側"},{"id":1753,"name":"風濕性紫瘢","d":19.156,"description":null,"img":null,"orgname":"眼球；右側"},{"id":3060,"name":"蕁麻疹","d":19.369,"description":null,"img":null,"orgname":"眼球；右側"}]}';
  String jsonSkeleton = '{"success":true,"data":[{"id":925,"name":"類肉瘤病","d":4.2,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":461,"name":"毒性過敏性關節炎","d":7.355,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":2407,"name":"Felty 氏症狀","d":17.404,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":3007,"name":"萊姆病","d":18.065,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":3117,"name":"乾性角膜結合膜炎","d":19.698,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":2406,"name":"戴門症","d":21.887,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":2408,"name":"Still氏症候群","d":22.068,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":580,"name":"痛風","d":22.917,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":3036,"name":"皮肌炎","d":23.482,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":3088,"name":"骨硬化","d":23.573,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":929,"name":"磷所引起之關節病","d":24.042,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":466,"name":"變形性骨關節退化病","d":25.178,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":587,"name":"類風濕關節炎","d":25.285,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":1970,"name":"骨質疏鬆","d":25.612,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":2409,"name":"賴透氏症候群","d":25.666,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":928,"name":"幹癬性脊椎關節炎","d":25.97,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":3360,"name":"牙周病","d":26.182,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":520,"name":"血小板減少性紫斑","d":26.333,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":467,"name":"脊椎關節黏連性變形","d":26.511,"description":null,"img":null,"orgname":"骨骼； 正面圖"},{"id":3111,"name":"馬凡氏症候群","d":27.371,"description":null,"img":null,"orgname":"骨骼； 正面圖"}]}';
  String jsonBreathe = '{"success":true,"data":[{"id":637,"name":"肺結核","d":1.272,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":502,"name":"囊腫性分化","d":3.76,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":624,"name":"支氣管肺炎","d":7.57,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":589,"name":"喉炎","d":12.026,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":3095,"name":"肺硬化","d":12.769,"description":null,"img":null,"orgname":"右肺"},{"id":594,"name":"氣管炎","d":13.983,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":486,"name":"扁桃腺膿瘍","d":14.473,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":623,"name":"過敏性喉炎","d":15.606,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":625,"name":"胸肋膜炎","d":16.376,"description":null,"img":null,"orgname":"右肺"},{"id":508,"name":"支氣管炎","d":17.101,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":578,"name":"過敏性反應","d":18.44,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":608,"name":"猩紅熱","d":18.512,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":3096,"name":"塵肺症","d":18.913,"description":null,"img":null,"orgname":"右肺"},{"id":3050,"name":"特異性纖維誘發性肺泡炎","d":19.347,"description":null,"img":null,"orgname":"右肺"},{"id":3115,"name":"胡德帕斯協式症","d":20.047,"description":null,"img":null,"orgname":"右肺"},{"id":489,"name":"喉部氣囊","d":21.17,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":910,"name":"支氣管擴張症","d":21.67,"description":null,"img":null,"orgname":"氣管和支氣管"},{"id":604,"name":"呼吸系統感染","d":21.905,"description":null,"img":null,"orgname":"右肺"},{"id":3027,"name":"韋格納氏肉芽腫症","d":23.391,"description":null,"img":null,"orgname":"右肺"},{"id":3156,"name":"慢性支氣管性黏液病變","d":23.978,"description":null,"img":null,"orgname":"氣管和支氣管"}]}';

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
