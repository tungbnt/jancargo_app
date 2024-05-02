import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';

import '../../components/resource/molecules/radio_button.dart';
import '../../domain/models/request/model_widget.dart';
import '../../domain/services/navigator/route_service.dart';
import '../../modules/web_view/screen/web_view.dart';

enum YahooShoppingFilterCondition {
  all(
    displayName: 'Tất cả',
    remoteValue: '' /* it's empty */,
  ),
  byNew(
    displayName: 'Sản phẩm mới',
    remoteValue: 'new',
  ),
  byUsed(
    displayName: 'Đã sử dụng',
    remoteValue: 'used',
  );

  final String displayName;
  final String remoteValue;

  bool get isAll => this == YahooShoppingFilterCondition.all;

  const YahooShoppingFilterCondition({
    required this.displayName,
    required this.remoteValue,
  });
}

enum AuctionFilterCondition {
  all(
    displayName: 'Tất cả',
    remoteValue: '0' /* it's empty */,
  ),
  byNew(
    displayName: 'Sản phẩm mới',
    remoteValue: '1',
  ),
  byUsed(
    displayName: 'Đã sử dụng',
    remoteValue: '2',
  );

  final String displayName;
  final String remoteValue;

  bool get isAll => this == AuctionFilterCondition.all;

  const AuctionFilterCondition({
    required this.displayName,
    required this.remoteValue,
  });
}

enum AuctionFilterStoreCondition {
  all(
    displayName: 'Tất cả',
    remoteValue: '0' /* it's empty */,
  ),
  byNew(
    displayName: 'Cửa hàng',
    remoteValue: '1',
  ),
  byUsed(
    displayName: 'Cá nhân',
    remoteValue: '2',
  );

  final String displayName;
  final String remoteValue;

  bool get isAll => this == AuctionFilterStoreCondition.all;

  const AuctionFilterStoreCondition({
    required this.displayName,
    required this.remoteValue,
  });
}

enum FavoriteFilterCondition {
  all(
    displayName: 'Tất cả',
    remoteValue: '' /* it's empty */,
  ),
  auction(
    displayName: 'Yahoo! Auciton JS',
    remoteValue: 'YAC_JP',
  ),
  yshopping(
    displayName: 'Yahoo! Shopping JP',
    remoteValue: 'YSP_JP',
  ),
  mercari(
    displayName: 'Mercari JS',
    remoteValue: 'MER_JP',
  ),
  rakuten(
  displayName: 'Rakuten JS',
  remoteValue: 'RAK_JP',
  );

  final String displayName;
  final String remoteValue;

  bool get isAll => this == FavoriteFilterCondition.all;

  const FavoriteFilterCondition({
    required this.displayName,
    required this.remoteValue,
  });
}

enum FavoriteArrangeCondition {
  createDesc(
    displayName: 'Thời gian thêm: mới đến cũ',
    remoteValue: 'created_date:desc' /* it's empty */,
  ),
  createAsc(
    displayName: 'Thời gian thêm: cũ đến mới',
    remoteValue: 'created_date:asc',
  ),
  endAsc(
    displayName: 'Thời gian còn lại: ít nhất',
    remoteValue: 'end_time:asc',
  ),
  endDesc(
    displayName: 'Thời gian còn lại: nhiều nhất',
    remoteValue: 'end_time:desc',
  ),;

  final String displayName;
  final String remoteValue;

  bool get isEndAsc => this == FavoriteArrangeCondition.endAsc;

  const FavoriteArrangeCondition({
    required this.displayName,
    required this.remoteValue,
  });
}
enum AuctionManagerArrangeCondition {
  desc(
    displayName: 'Mới đặt giá',
    remoteValue: 'created_date:desc' /* it's empty */,
  ),
  asc(
    displayName: 'Sắp kết thúc',
    remoteValue: 'end_time:asc',
  ),
  priceAsc(
    displayName: 'Giá đấu tăng dần',
    remoteValue: 'price:asc',
  ),
  priceDesc(
    displayName: 'Giá đấu giảm dần',
    remoteValue: 'price:desc',
  ),
  bidsAsc(
    displayName: 'SL đấu tăng dần',
    remoteValue: 'bids:asc',
  ),
  bidsDesc(
    displayName: 'SL đấu giảm dần',
    remoteValue: 'bids:desc',
  );

  final String displayName;
  final String remoteValue;

  bool get isEndAsc => this == AuctionManagerArrangeCondition.asc;

  const AuctionManagerArrangeCondition({
    required this.displayName,
    required this.remoteValue,
  });
}
enum MercariShippingFeeFilterCondition {
  all(
    displayName: 'Tất cả',
    remoteValue: null,
  ),
  buyerPays(
    displayName: 'Người mua thanh toán',
    remoteValue: 1,
  ),
  sellerPays(
    displayName: 'Đã sử dụng',
    remoteValue: 2,
  );

  final String displayName;
  final int? remoteValue;

  bool get isAll => this == MercariShippingFeeFilterCondition.all;

  const MercariShippingFeeFilterCondition({
    required this.displayName,
    required this.remoteValue,
  });
}

enum MercariProductsStatusFilterCondition {
  all(
    displayName: 'Tất cả',
    remoteValue: null,
  ),
  avaiable(
    displayName: 'Còn hàng bán',
    remoteValue: 1,
  ),
  outOfStock(
    displayName: 'Hết hàng bán',
    remoteValue: 2,
  );

  final String displayName;
  final int? remoteValue;

  bool get isAll => this == MercariProductsStatusFilterCondition.all;

  const MercariProductsStatusFilterCondition({
    required this.displayName,
    required this.remoteValue,
  });
}

class AppStorage {
  static const List<Map<String, dynamic>> items = [
    {'icon': 'Icons.star', 'text': 'Tất cả'},
    {'icon': AppImages.imgAuction, 'text': 'Yahoo! Auction'},
    {'icon': AppImages.imgShopping, 'text': 'Yahoo! Shopping'},
    {'icon': AppImages.imgRakuten, 'text': 'Rakuten'},
    {'icon': AppImages.imgMercari, 'text': 'Mercari'},
    {'icon': AppImages.imgPaypay, 'text': 'Paypay Fleamarket'},
    {'icon': AppImages.imgAmazon, 'text': 'Amazon JP'},
    // {'icon': 'Icons.bookmark', 'text': 'Rakuma'},
    // {'icon': 'Icons.bookmark', 'text': 'Zozotown'},
    // {'icon': 'Icons.bookmark', 'text': 'Surygaya'},
    // {'icon': 'Icons.bookmark', 'text': 'Ebay'},
    // {'icon': 'Icons.bookmark', 'text': 'Walmart'},
    // {'icon': 'Icons.bookmark', 'text': 'Jomashop'},
    {'icon': AppImages.imgAmazon, 'text': 'Amazon US'},
  ];

  static String nameStore(String codeStore)  {
    var name = switch (codeStore) {
      'RAK_JP' => 'Rakuten',
      'PFL_JP' => 'Paypay Fleamarket',
      'YSP_JP' => 'Y!Shopping',
      'YAC_JP' => 'Y!Yahoo! Auction JP',
      'AMZ_US' => 'Amazon US',
      'AMZ_JP' => 'Amazon JP',
      'MER_JP' => 'Mercari JP',
      _ => 'Đang cập nhật',
    };
    return name;
  }

  static String nameCategoryAuction(String idCategory)  {
    var name = switch (idCategory) {
      '23260' => 'Thế giới đồng hồ',
      '2084044777' => 'Máy ảnh & phụ kiện',
      '2084008364' => 'Đồ điện tử gia dụng',
      '25180' => 'Thiết bị câu Nhật Bản',
      '2084005069' => 'Túi xách hàng hiệu',
      _ => 'Đang cập nhật',
    };
    return name;
  }

  static String icStore(String codeStore) {
    var ic = switch (codeStore) {
      'RAK_JP' => AppImages.imgRakuten,
      'PFL_JP' => AppImages.imgPaypay,
      'YSP_JP' => AppImages.imgShopping,
      'YAC_JP' => AppImages.imgAuction,
      'AMZ_US' => AppImages.imgAmazon,
      'AMZ_JP' => AppImages.imgAmazon,
      'MER_JP' => AppImages.imgMercari,
      _ => AppImages.imgAuction,
    };
    return ic;
  }

  static const List<Map<String, dynamic>> selectedCatPaypay = [
    {'value': '13457', 'title': 'Thời trang', 'home': true},
    {'value': '2501', 'title': 'Mỹ phẩm - Làm đẹp', 'home': true},
    {'value': '2502', 'title': 'Điện thoại, máy tính', 'home': true},
    {'value': '2504', 'title': 'Tivi, âm thanh, camera', 'home': true},
    {'value': '2506', 'title': 'Nội thất', 'home': true},
    {'value': '2511', 'title': 'Đồ chơi', 'home': true},
    {'value': '2497', 'title': 'Mẹ và bé', 'home': true},
    {'value': '2512', 'title': 'Thể thao & dã ngoại', 'home': true},
    {'value': '2517', 'title': 'Phầm mềm, DVD, Video', 'home': true},
    {'value': '10002', 'title': 'Sách, tạp chí, truyện tranh', 'home': false}
  ];

  static Future<String> getQuery() async {
    final queryString = selectedCatPaypay
        .where((item) =>
            item['home'] == true) // Lọc ra những mục có thuộc tính home là true
        .map((item) => 'categories=${item['value']}')
        .join('&');
    return queryString;
  }

  // Tạo một bảng ánh xạ giữa value và title
  static final valueToTitleMap = Map.fromEntries(
      selectedCatPaypay.map((item) => MapEntry(item['value'], item['title'])));

  static String gettitlePay(String value) {
    final title = valueToTitleMap[value];
    return title;
  }

  // auction
  static List<RadioBoxModel<AuctionFilterCondition, String>>
      get auctionFilterConditions {
    return AuctionFilterCondition.values
        .map<RadioBoxModel<AuctionFilterCondition, String>>(
          (e) => RadioBoxModel(
            data: e,
            displayName: e.displayName,
            remoteValue: e.remoteValue,
          ),
        )
        .toList();
  }

  // favorite
  // filter
  static List<RadioBoxModel<FavoriteFilterCondition, String>>
  get favoriteFilterConditions {
    return FavoriteFilterCondition.values
        .map<RadioBoxModel<FavoriteFilterCondition, String>>(
          (e) => RadioBoxModel(
        data: e,
        displayName: e.displayName,
        remoteValue: e.remoteValue,
      ),
    )
        .toList();
  }
  static RadioBoxModel<FavoriteFilterCondition, String>
  get favoriteDefaultFilterConditions {
    return RadioBoxModel(
      data: FavoriteFilterCondition.all,
      displayName: FavoriteFilterCondition.all.displayName,
      remoteValue: FavoriteFilterCondition.all.remoteValue,
    );
  }
  // arrage favorite
  static List<RadioBoxModel<FavoriteArrangeCondition, String>>
  get favoriteArrangeConditions {
    return FavoriteArrangeCondition.values
        .map<RadioBoxModel<FavoriteArrangeCondition, String>>(
          (e) => RadioBoxModel(
        data: e,
        displayName: e.displayName,
        remoteValue: e.remoteValue,
      ),
    )
        .toList();
  }
  static RadioBoxModel<FavoriteArrangeCondition, String>
  get favoriteDefaultArrangeConditions {
    return RadioBoxModel(
      data: FavoriteArrangeCondition.endAsc,
      displayName: FavoriteArrangeCondition.endAsc.displayName,
      remoteValue: FavoriteArrangeCondition.endAsc.remoteValue,
    );
  }

  // arrange Auction Manager
  static List<RadioBoxModel<AuctionManagerArrangeCondition, String>>
  get auctionManagerArrangeConditions {
    return AuctionManagerArrangeCondition.values
        .map<RadioBoxModel<AuctionManagerArrangeCondition, String>>(
          (e) => RadioBoxModel(
        data: e,
        displayName: e.displayName,
        remoteValue: e.remoteValue,
      ),
    )
        .toList();
  }
  static RadioBoxModel<AuctionManagerArrangeCondition, String>
  get auctionManagerDefaultArrangeConditions {
    return RadioBoxModel(
      data: AuctionManagerArrangeCondition.asc,
      displayName: AuctionManagerArrangeCondition.asc.displayName,
      remoteValue: AuctionManagerArrangeCondition.asc.remoteValue,
    );
  }



  static RadioBoxModel<AuctionFilterCondition, String>
      get auctionDefaultFilterCondition {
    return RadioBoxModel(
      data: AuctionFilterCondition.all,
      displayName: AuctionFilterCondition.all.displayName,
      remoteValue: AuctionFilterCondition.all.remoteValue,
    );
  }

  static List<RadioBoxModel<AuctionFilterStoreCondition, String>>
      get auctionFilterStoreConditions {
    return AuctionFilterStoreCondition.values
        .map<RadioBoxModel<AuctionFilterStoreCondition, String>>(
          (e) => RadioBoxModel(
            data: e,
            displayName: e.displayName,
            remoteValue: e.remoteValue,
          ),
        )
        .toList();
  }

  static RadioBoxModel<AuctionFilterStoreCondition, String>
      get auctionDefaultFilterStoreCondition {
    return RadioBoxModel(
      data: AuctionFilterStoreCondition.all,
      displayName: AuctionFilterStoreCondition.all.displayName,
      remoteValue: AuctionFilterStoreCondition.all.remoteValue,
    );
  }

  //yahoo
  static RadioBoxModel<YahooShoppingFilterCondition, String>
      get yahooShoppingDefaultFilterCondition {
    return RadioBoxModel(
      data: YahooShoppingFilterCondition.all,
      displayName: YahooShoppingFilterCondition.all.displayName,
      remoteValue: YahooShoppingFilterCondition.all.remoteValue,
    );
  }

  static List<RadioBoxModel<YahooShoppingFilterCondition, String>>
      get yahooShoppingFilterConditions {
    return YahooShoppingFilterCondition.values
        .map<RadioBoxModel<YahooShoppingFilterCondition, String>>(
          (e) => RadioBoxModel(
            data: e,
            displayName: e.displayName,
            remoteValue: e.remoteValue,
          ),
        )
        .toList();
  }

  /*
  static List<RadioBoxModel<Map<String, dynamic>>> mapToList() {
    List<RadioBoxModel<Map<String, dynamic>>> filterList = [];
    List<String> data = ['Tất cả', 'Sản phẩm mới', 'new', 'Đã sử dụng', 'used'];
    int index = 0;
    for (int i = 0; i < data.length; i += 2) {
      String name = data[i];

      RadioBoxModel<Map<String, dynamic>> radioBoxModel = RadioBoxModel(
        data: {'index': index, 'name': name},
        status: ValueNotifier<bool>(false),
      );
      filterList.add(radioBoxModel);
      index++;
    }

    return filterList;
  }
  */

  static final List<Map<String, dynamic>> itemsVip = [
    {
      'vip': 'VIP 1',
      'content': 'Tối đa 2 phiên đấu giá cùng thời điểm',
      'price': 1000000,
      'isChecked': false
    },
    {
      'vip': 'VIP 2',
      'content': 'Tối đa 2 phiên đấu giá cùng thời điểm',
      'price': 2000000,
      'isChecked': false
    }, // Add more items as needed
  ];

  static RadioBoxModel<MercariShippingFeeFilterCondition, int?>
      get mercariShippingFeeDefaultFilterCondition {
    return RadioBoxModel(
      data: MercariShippingFeeFilterCondition.all,
      displayName: MercariShippingFeeFilterCondition.all.displayName,
      remoteValue: MercariShippingFeeFilterCondition.all.remoteValue,
    );
  }

  static List<RadioBoxModel<MercariShippingFeeFilterCondition, int?>>
      get mercariShippingFeeFilterConditions {
    return MercariShippingFeeFilterCondition.values
        .map<RadioBoxModel<MercariShippingFeeFilterCondition, int?>>(
          (e) => RadioBoxModel(
            data: e,
            displayName: e.displayName,
            remoteValue: e.remoteValue,
          ),
        )
        .toList();
  }

  static RadioBoxModel<MercariProductsStatusFilterCondition, int?>
      get mercariProductsStatusDefaultFilterCondition {
    return RadioBoxModel(
      data: MercariProductsStatusFilterCondition.all,
      displayName: MercariProductsStatusFilterCondition.all.displayName,
      remoteValue: MercariProductsStatusFilterCondition.all.remoteValue,
    );
  }

  static List<RadioBoxModel<MercariProductsStatusFilterCondition, int?>>
      get mercariProductsStatusFilterConditions {
    return MercariProductsStatusFilterCondition.values
        .map<RadioBoxModel<MercariProductsStatusFilterCondition, int?>>(
          (e) => RadioBoxModel(
            data: e,
            displayName: e.displayName,
            remoteValue: e.remoteValue,
          ),
        )
        .toList();
  }

  static List<ModelWidget> myModelList = [
    ModelWidget(
        icon: AppImages.icAdd,
        text: 'Tạo đơn',
        color: AppColors.yellow700Color,
  onTap: ()async {
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
    await RouteService.routeGoOnePage(WebViewScreen(
      url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/quote?view=app",
      title: "Tạo đơn",));
  }
    ),
    ModelWidget(icon: AppImages.icBill, text: 'Phiếu xuất',onTap: ()async{
      Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
      String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
      await RouteService.routeGoOnePage(WebViewScreen(url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/invoices?view=app",title: "Phiếu xuất",));
    }),
    ModelWidget(
      icon: AppImages.icWalletInfo,
      text: 'Ví Jancargo',
      onTap: () {
        Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
        String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
        RouteService.routeGoOnePage(
        WebViewScreen(
          url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/wallet?view=app",
          title: "Ví Jancargo",
        ),
      );
      },
    ),
    ModelWidget(icon: AppImages.icRatings, text: 'Xếp hạng',onTap: (){
      Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
      String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
      RouteService.routeGoOnePage(
        WebViewScreen(
          url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/reward?view=app",
          title: "Xếp hạng",
        ),
      );
    }),
  ];
}

class ItemModel {
  final String icon;
  final String text;

  ItemModel(this.icon, this.text);
}
