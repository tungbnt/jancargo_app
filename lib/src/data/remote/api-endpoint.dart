// ignore_for_file: file_names
import 'package:jancargo_app/src/general/constants/app_environment.dart';

abstract class ApiEndpoint {
  ApiEndpoint({required this.environment});
  AppEnvironment environment;
  String baseUrl();

  /// fetch full path for query server
  /// fullPath  = baseUrl server of environment + path;
  String getUrlQueryApi(String path) => '${baseUrl()}/$path';
}

class AppPath {
  static const session = "api/session";
  static const login = "connect/token";
  static const loginSocial = "api/login/social";
  static const signup = "api/signup";
  static const requestChangePass = "api/security/request-change-password";
  static const resetPass = "api/security/reset-password";
  static const verifyOtp = "api/security/verify-reset-password-otp";

  //dashboard
  static const houseOfSale = "api/topview-shops";
  static const flashSale = "api/rakuten/deal/products";
  static const recentlyViewed = "api/product-recently-viewed";
  static const suggestionRakuten = "api/rakuten/ranking";
  static const toViewCategories = "api/topview-categories";
  static const bannerSlider = "api/sliders";
  static const quick = "api/quicks";
  static const searchYAuction = "api/shopping/search";
  static const searchAll = "api/products/search";
  static const searchRakuten = "api/rakuten/search/popular";
  static const searchPaypay = "api/paypay/home/products";
  static const searchAmazonJs = "api/amazon/jp/deals/details";
  static const searchMercari = "api/mercari/search/popular";
  static const auction = "api/auction/category/products";
  static const brandAuction = "api/auction/search-brand";

  //user
  static const exchangePrice = "api/exchange-price";
  static const cart = "api/cart/user";
  static const favoriteItem = "api/favorite/product";
  static const favorites = "api/favorite/product/user";
  static const favoritesSearch = "api/favorite/products";

  //auction and detail product
  static const infoProductRakuten = "api/rakuten/item/";
  static const infoProductAuction = "api/auction/item/";
  static const infoProductYShopping = "api/shopping/item/";
  static const infoProductMarcari = "api/mercari/item/";
  static const infoProduct = "api/rakuten/item/";
  static const favoriteStore = "api/favorite/store";
  static const favoriteStoreUser = "api/favorite/store/user";
  static const favorite = "api/favorite/product/user";
  static const feeShip = "api/auction/domestic-shipping-fee";
  static const suggestion = "api/auction/relates";
  static const timeAuction = "api/auction/time-left";
  static const warehouse = "api/warehouse?route=JP";
  static const bidding = "api/bidding/user";
  static const biddingNoti = "api/bid/check-last-minute-notif";
  static const breadcrumb = "api/category-by-code";
  static const toggleNotiBid = "api/bid/toogle-last-minute-notif";
  static const history = "api/bid/history";
  static const calculatePrice = "api/calculate-price";
  static const auctionOff = "api/bid/now";
  static const auctionSeller = "api/auction/saller";
  static const mercariSeller = "api/mercari/seller";
  static const deletedMyAccount = "api/user/delete-my-account";

  //user
  static const getTran = "api/transations/user";
  static const getPriceAuction = "api/bid/price";
  static const getAddressUser = "api/user/address/user";
  static const editAddressUser = "api/user/address/edit";
  static const addAddressUser = "api/user/address/add";
  static const getWard = "api/utility/ward";
  static const getDistrict = "api/utility/district";
  static const getProvinces = "api/utility/provinces";
  static const getServiceExtras = "api/service-extras/user";
  static const confirmPaymentOder = "api/quote/user/save";
  //cart
  static const addCart = "api/cart";
  static const itemCart = "api/cart/user";
  static const removeItemCart = "api/cart/remove";
  static const updateItemCart = "api/intended_cart/items/update";
  static const removeFavorite = "favorite/product/delete";

  //coupon
  static const getCoupon = "api/coupons/user";

  //management
  static const oderManagement = "api/quotes/user";
  static const auctionManagement = "api/bid/user";

  //search
  static const searchSuggestion = "api/category/tops";
  static const searchPopular = "api/keyword/tops";
  static const searchMercariWord = "api/mercari/search";
  static const searchRakutenWord = "api/rakuten/search";
  static const objectResolverRakuten = "api/object-resolver";
  static const searchPayPayWord = "api/paypay/search";
  static const searchAmazonJsWord = "api/amazon/jp/search";
  static const searchAmazonUsWord = "api/amazon/us/search";

  //auction
  static const categoryHome = "api/category/home";
  static const auctionSearch = "api/auction/search";
  static const auctionProducts = "api/auction/home/products";
  static const activeVip = "api/user/activate/vip";

  //setting

  static const changePass = "api/security/change-password";

  //flash sale
  static const amazonJsFlashSale = "api/amazon/jp/deals/top";


}
