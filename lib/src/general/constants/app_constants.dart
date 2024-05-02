import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../app_manager.dart';

abstract class AppConstants {
  static BuildContext get _context => AppManager.globalKeyRootMaterial.currentContext!;
  static Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);

  static const String APP_NAME_ID = "vn.jancargo";
  static const String ACCESS_TOKEN = "access_token";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String EXCHANGE = "exchange_price";
  static const String IS_FIRST = "is_first";
  static String webPage = 'packages/flutter_gcaptcha_v3/assets/index.html';
  static String readyCaptcha = 'readyCaptcha';
  static String readyJsName = 'Ready';
  static String captchaJsName = 'Captcha';
  static String phone = 'số điện thoại';
  static String email = 'Email';

  static int percent = 99;

  static  var isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);


  //query
  static String sizeApi = '20';
  static String querySearch = 'レディースファッション';
  static String querySearchRakuten = 'レディースファッション';

  //source site
  static String yShoppingSource = 'YSP_JP';
  static String auctionShoppingSource = 'YAC_JP';
  static String rakutenSource = 'RAK_JP';
  static String marcariSource = 'MER_JP';
  static String paypaySource = 'MER_JP';

  //name site
  static String amazonName = "amazon";
  static String auctionName = "auction";
  static String mercariName = "mercari";
  static String rakutenName = "rakuten";
  static String yShoppingName = "auction";
  static String paypayName = "paypay";


  static String facebookId = "658659919674976";



}