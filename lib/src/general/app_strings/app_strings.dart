import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_locale.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppStrings> {
  @override
  bool isSupported(Locale locale) {
    return AppLocaleEnum.values.where((element) => element.languageCode == locale.languageCode).isNotEmpty;
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    Iterable<AppLocaleEnum> appLocale = AppLocaleEnum.values.where((element) => element.languageCode == locale.languageCode);
    if (appLocale.isNotEmpty) {
      return appLocale.first.getAppString();
    } else {
      return AppLocaleEnum.VN.getAppString();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return true;
  }
}

abstract class AppStrings {
  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }
  //text it all
  String get intro;
  String get error;
  String get login;
  String get or;
  String get signup;

  //text btn
  String get next;
  String get back;
  String get start;

  //onboard
  String get titleOnBoardOne;
  String get descriptionOnBoardOne;
  String get titleOnBoardTwo;
  String get descriptionOnBoardTwo;
  String get titleOnBoardThree;
  String get descriptionOnBoardThree;

  //login
  String get notAccount;
  String get textForgetPass;
  String get hintAccount;
  String get hintPass;

  //register
  String get hintPassAgain;
  String get hintPhone;
  String get hintEmail;
  String get hintName;

  //forget
  String get confirm;
  String get textYourCodeSendEmail;
  String get hasOtp;
  String get resent;
  String get orTryIt;
  String get otherMethod;
  String get newPass;
  String get newPassAgain;
  String get forget;

  //auction
  String get setPriceAuction;
  String get memberVip;
  String get vipPackage;
  String get content;
  String get auctionFee;
  String get serviceCharge;
  String get paymentFees;
  String get domesticShippingFee;
  String get setPrice;
  String get termsAndPolicies;
  String get currentPrice;
  String get auctionTime;
  String get paymentMethods;
  String get topUp;
  String get walletJan;

  //signup
  String get privacyPolicy;
  String get iAgree;
  String get youAgree;
  String get privacyPolicyOf;
  String get termsOfService;

  //cart
  String get cart;
  String get payment;

  //dashboard
  String get home;
  String get favorite;

  //detail
  String get goodsCondition;
  String get quantity;
  String get stocking;
  String get outOfStock;
  String get unlimited;
  String get domesticTaxes;
  String get undefined;
  String get productInformation;
  String get newUnused;
  String get almostNew;
  String get scratchesAndDirtNotAttention;
  String get scratchesAndDirt;
  String get badCondition;
  String get taxIncluded;
  String get sellerBearsTheFee;
  String get startTime;
  String get endTime;
  String get moreMatchTime;
  String get finishSoon;
  String get toReturn;
  String get contractorAuthentication;
  String get ratingRestrictions;
  String get auctionCode;
  String get buyNow;
  String get addToCart;
  String get suggestionToday;
  String get productDetails;
  String get auction;
  String get lastMinuteHunting;
  String get nation;
  String get oneStPayment;
  String get totalProductCost;
  String get paymentOrders;
  String get outstandingSeller;
  String get recentlyViewed;
  String get time;
  String get intoMoney;

}
