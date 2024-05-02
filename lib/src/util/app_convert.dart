import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import 'package:jancargo_app/src/modules/details_product_auction/screens/details_product_screen.dart';
import 'package:jancargo_app/src/modules/searchs/screens/searchs_screens.dart';

import '../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../domain/dtos/time/time_formatter.dart';

class AppConvert {
  static get getValue => null;

  static TimerDto timeConvert({required Duration duration}) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    String formattedHours = '';
    String formattedDay = '';
    String formattedMinutes = '';
    String formattedSecond = '';
    if (hours < 10) {
      formattedHours = '0$hours';
    } else {
      formattedHours = hours.toString();
    }
    if (days < 10) {
      formattedDay = '${days}N';
    } else {
      formattedDay = days.toString();
    }
    if (minutes < 10) {
      formattedMinutes = '0$minutes';
    } else {
      formattedMinutes = minutes.toString();
    }
    if (seconds < 10) {
      formattedSecond = '0$seconds';
    } else {
      formattedSecond = seconds.toString();
    }
    return TimerDto(
        day: formattedDay,
        hour: formattedHours,
        minutes: formattedMinutes,
        second: formattedSecond);
  }

  static String timeConvertLineTimer({required Duration duration}) {
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    String formattedHours = '';
    String formattedDay = '';
    String formattedMinutes = '';
    String formattedSecond = '';
    if (hours < 10) {
      formattedHours = '0$hours';
    } else {
      formattedHours = hours.toString();
    }
    if (days == 0) {
      formattedDay = "";
    } else if (days < 10) {
      formattedDay = '$days';
    } else {
      formattedDay = days.toString();
    }
    if (minutes < 10) {
      formattedMinutes = '0$minutes';
    } else {
      formattedMinutes = minutes.toString();
    }
    if (seconds < 10) {
      formattedSecond = '0$seconds';
    } else {
      formattedSecond = seconds.toString();
    }
    return formattedDay == ""
        ? " $formattedHours:$formattedMinutes:$formattedSecond "
        : '${formattedDay}d - $formattedHours:$formattedMinutes:$formattedSecond';
  }

  static DateTime convertDateTime({required String dateString}) {
    DateTime originalDateTime =
        DateTime.parse(dateString); // Đối tượng DateTime ban đầu

    // Định dạng thành chuỗi với số 0 đằng trước giờ
    String formattedDateTimeString =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(originalDateTime.toLocal());

    print('Formatted DateTime String: $formattedDateTimeString');

    // Chuyển đổi chuỗi định dạng lại thành DateTime
    DateTime formattedDateTime = DateTime.parse(formattedDateTimeString);

    return formattedDateTime;
  }

  static String convertStringDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  static int convertStringToSecond(String dateString) {
    // Định dạng chuỗi ngày giờ đầu vào
    DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");

// Chuyển đổi chuỗi thành DateTime
    DateTime endTime = format.parse(dateString);

// Thời gian hiện tại
    DateTime now = DateTime.now();

// Tính thời gian còn lại (đơn vị: giây)
    int timeLeftInSeconds = endTime.difference(now).inSeconds;


    return (timeLeftInSeconds / 1000).ceil();
  }
  static String convertStringToTimeandDateTime(String dateString) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    DateFormat outputFormat = DateFormat("HH:mm || dd-MM-yyyy");

    DateTime dateTime = inputFormat.parse(dateString);
    return outputFormat.format(dateTime);
  }

  static String convertAmountVn(int amount) {
    // Định dạng số tiền
    var number = (amount * (AppManager.appSession.exchange ?? 176));
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
    );
    String formattedAmount = currencyFormatter.format(number);
    // Thay đổi '.' thành ','
    formattedAmount = formattedAmount.replaceAll('.', ',');

    return formattedAmount;
  }
  static String convertNumberVn(int amount) {
    // Định dạng số tiền
    var number = amount ;
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
    );
    String formattedAmount = currencyFormatter.format(number);
    // Thay đổi '.' thành ','
    formattedAmount = formattedAmount.replaceAll('.', ',');

    return formattedAmount;
  }
  static String convertNumberJP(int amount) {
    // Định dạng số tiền
    var number = amount ;
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'ja_JP',
      symbol: '¥',
    );
    String formattedAmount = currencyFormatter.format(number);
    // Thay đổi '.' thành ','
    formattedAmount = formattedAmount.replaceAll('.', ',');

    return formattedAmount;
  }

  static String convertAmountJp(int amount) {
    // Định dạng số tiền với ký hiệu tiền tệ JPY (Yên Nhật)
    NumberFormat currencyFormatter =
        NumberFormat.currency(locale: 'ja_JP', symbol: '¥');

    String formattedAmount = currencyFormatter.format(amount);

    return formattedAmount;
  }

  static String convertVnAmountJp(int amount) {
    // Định dạng số tiền với ký hiệu tiền tệ JPY (Yên Nhật)
    NumberFormat currencyFormatter =
    NumberFormat.currency(locale: 'ja_JP', symbol: '¥');
    String formattedAmount = '';
    if(amount/AppManager.appSession.exchange! < 1) {
      formattedAmount = '1';
    }else{
      formattedAmount = currencyFormatter.format(amount/(AppManager.appSession.exchange ?? 176));
    }


    return formattedAmount;
  }

  static String convertVn(int amount) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
    );
    String formattedAmount = currencyFormatter.format(amount);
    // Thay đổi '.' thành ','
    formattedAmount = formattedAmount.replaceAll('.', ',');

    return formattedAmount;
  }

  static String convertNumber(int amount) {
    final formatter = NumberFormat('#,###');
    final formattedString = formatter.format(amount);

    return formattedString;
  }

  static String isSiteCode(String siteName){

    switch(siteName){
      case '0': return '';
      case '1': return 'YAC_JP';
      case '2': return 'YSP_JP';
      case '3': return 'RAK_JP';
      case '4': return'MER_JP';

      default: return '';
    }
  }
  static String isArrangeCode(String siteName){

    switch(siteName){
      case '0': return '';
      case '1': return 'YAC_JP';
      case '2': return 'YSP_JP';
      case '3': return 'RAK_JP';
      case '4': return'MER_JP';

      default: return '';
    }
  }

  static Future<void> regexSearch(BuildContext context,String url)async{
    if(url.contains('https://jancargo.com/') || url.contains('https://m.jancargo.com/')){
     return regexUrlJancargoSearch(context,url);
    }else {
      return regexUrlSiteSearch(context,url);
    }
  }

  static void regexUrlJancargoSearch(BuildContext context,String url){
    // Tách chuỗi thành một danh sách các phần tử dựa trên dấu "/"
    List<String> parts = url.split('/');

    String site = parts[3]; // Phần tử thứ tư
    String id = parts[5];
    switch(site){
     case 'auction': RouteService.routeGoOnePage( ProductDetailsScreen(code: id, source: AppConstants.auctionShoppingSource,),);
     break;
     case 'shopping': RouteService.routeGoOnePage( YShoppingDetailProduct(code: id, source: AppConstants.yShoppingSource,),);
     break;
     case 'mercari': RouteService.routeGoOnePage( MarcariDetailProduct(code: id, source: AppConstants.marcariSource,),);
     break;
     case 'rakuten': RouteService.routeGoOnePage( MarcariDetailProduct(code: id, source: AppConstants.marcariSource,),);
     break;

     default: DialogService.showNotiBannerFailed(
         context,AppColors.white, 'Link sản phẩm chưa được hỗ trợ hoặc chưa đúng!');

     }
  }

  static Future<void> regexUrlSiteSearch(BuildContext context,String url)async{
    var id = await regexIdProductSearch(url);
    if(url.contains('https://item.rakuten.co.jp/')){
     return RouteService.routeGoOnePage(  RakutenDetailProductScreen(code: id, source: AppConstants.rakutenSource,),);
    }else if(url.contains('https://jp.mercari.com/')){
      return RouteService.routeGoOnePage(  MarcariDetailProduct(code: id, source: AppConstants.marcariSource,),);
    }else if(url.contains('https://store.shopping.yahoo.co.jp/')){
      var idYShopping = getIdYShoppingSite(url);
      return RouteService.routeGoOnePage(  MarcariDetailProduct(code: idYShopping, source: AppConstants.yShoppingSource,),);
    }else if(url.contains('https://page.auctions.yahoo.co.jp/jp/auction')){

      return  RouteService.routeGoOnePage(  ProductDetailsScreen(code: id, source: AppConstants.auctionShoppingSource,),);
    }else{
      return await  DialogService.showNotiBannerFailed(
          context,AppColors.white, 'Link sản phẩm chưa được hỗ trợ hoặc chưa đúng!');
    }
  }

  static Future<String> regexIdProductSearch(String url)async{
    // Tìm vị trí của '/' cuối cùng trong URL
    int lastSlashIndex = url.lastIndexOf('/');

    // Lấy phần từ vị trí sau '/' cuối cùng đến hết chuỗi (bao gồm "o1124612470")
    String remainingPart = url.substring(lastSlashIndex + 1);
    return remainingPart;
  }

  static bool regexHasUrl(String text) {
      List<String> extractedUrls = [];
      RegExp regex = RegExp(r'https?://[^\s]+');
      Iterable<Match> matches = regex.allMatches(text);
      for (Match match in matches) {
        extractedUrls.add(match.group(0)!);
      }

      if (extractedUrls.isNotEmpty) {
       return true;
      }
      return false;
    }

  static String regexUrl(String text, String site) {
    if(text.contains('https://jancargo.com/')){
      if(site == AppConstants.yShoppingName){
        return getItemIdFromUrl(text);
      }
      List<String> extractedUrls = [];
      RegExp regex = RegExp(r'https?://[^\s]+');
      Iterable<Match> matches = regex.allMatches(text);
      for (Match match in matches) {
        extractedUrls.add(match.group(0)!);
      }

      if (extractedUrls.isNotEmpty) {
        String id =  regexIdProduct(extractedUrls[0], site);
        return id;
      } else {
        // Trả về một giá trị mặc định hoặc xử lý lỗi ở đây nếu danh sách extractedUrls rỗng
        return '';
      }
    }else{
      if(site == AppConstants.yShoppingName){
        return getIdYShoppingSite(text);
      }
     return getItemIdFromUrl(text);
    }

  }

  static String getIdYShoppingSite(String url) {
    Uri uri = Uri.parse(url);
    List<String> pathSegments = uri.pathSegments;
    String combinedString = pathSegments.join('_');
    return combinedString.replaceAll('.html', '');
  }

  static String getItemIdFromUrl(String url) {
    List<String> parts = url.split('/');
    String lastElement = parts.last;
    return lastElement;
  }

  static String regexIdProduct(String url, String site) {
    RegExp regex = RegExp(r'/' + site + r'/(\w+)');
    Match? match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
    return ''; // Trả về một chuỗi rỗng nếu không tìm thấy mã sản phẩm
  }

  static String pathImg(String source){
    switch(source){
      case 'YAC_JP': return AppImages.imgAuction;
      case 'YSP_JP': return AppImages.imgShopping;
      case 'RAK_JP': return AppImages.imgRakuten;
      case 'MER_JP': return AppImages.imgMercari;
      case 'AMZ_US': return AppImages.imgAmazon;
    }
    return '';
  }

  static List<GroupCartsDto> filterSelectedCountTrue(
      List<GroupCartsDto> groupCartsList) {
    return groupCartsList
        .where((groupCarts) => groupCarts.selectedCount > 0)
        .toList();
  }
}

class OptionItemExt {
  static String labelGetter(OptionItem? item) => item?.name ?? '';

  static bool Function(OptionItem) equalIdTester(int id) {
    return (OptionItem item) {
      return item.id == id;
    };
  }
}

class OptionItem {
  final int id;
  final String name;

  OptionItem({required this.id, required this.name});

  bool get available => id != -1 && name.isNotEmpty;

  bool get unavailable => available == false;

  factory OptionItem.unavailable() => SelectableItem(id: -1, name: '');



  factory OptionItem.fromLocalJson(Map<String, dynamic> map) {
    return OptionItem(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class SelectableItem extends OptionItem {
  late final ValueNotifier<bool> isSelected = ValueNotifier<bool>(false);
  final String? title;

  SelectableItem({required super.id, required super.name, this.title});

  factory SelectableItem.fromOptionItem(OptionItem item) {
    return SelectableItem(id: item.id, name: item.name);
  }

  factory SelectableItem.fromJson(Map<String, dynamic> map) {
    return SelectableItem(id: map['id'], name: map['name']);
  }

  factory SelectableItem.fromServiceJson(Map<String, dynamic> map) {
    return SelectableItem(id: map['key'], name: map['value']);
  }

  SelectableItem clone() =>
      SelectableItem(id: id, name: name)..isSelected.value = isSelected.value;
}

class SelectableItemExt {
  static String labelGetter(SelectableItem? item) => item?.name ?? '';

  static bool Function(SelectableItem) equalIdTester(int id) {
    return (SelectableItem item) {
      return item.id == id;
    };
  }
}
