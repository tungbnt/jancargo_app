class Status {
  static const Map<String, Map<String, dynamic>> STATUS_QUOTE = {
    'REQUEST': {'text': 'Chờ báo giá', 'value': 1},
    'PENDING': {'text': 'Đã báo giá', 'value': 2},
    'TRANSACTING': {'text': 'Đang giao dịch', 'value': 3},
    'TRANSACTED': {'text': 'Giao dịch hoàn thành', 'value': 4},
    'CONFIREMD': {'text': 'Đã xác nhận mua hàng', 'value': 5},
    'BUYING': {'text': 'Đơn hàng đang được mua', 'value': 5.5},
    'BOUGHT': {'text': 'Đơn hàng đã được mua', 'value': 6},
    'WAREHOUSE': {'text': 'Hàng đã về kho nước ngoài', 'value': 7},
    'EXPORT': {'text': 'Xuất kho nước ngoài', 'value': 8},
    'CHECKIN': {'text': 'Đơn hàng đã về Việt Nam', 'value': 9},
    'CHECKED': {'text': 'Khai thác đơn hàng', 'value': 10},
    'CALCULATOR': {'text': 'Tính giá đơn hàng', 'value': 11},
    'BILL_NEW': {'text': 'Phiếu xuất mới tạo', 'value': 12},
    'BILL_CONFIREMD': {'text': 'KD xác nhận', 'value': 13},
    'BILL_APPROVED': {'text': 'Đã duyệt PXK', 'value': 14},
    'BILL_PACKING': {'text': 'Đã đóng hàng', 'value': 14.1},
    'BILL_EXPORT': {'text': 'Xuất hàng', 'value': 15},
    'BILL_DELIVERY': {'text': 'Đang phát hàng', 'value': 16},
    'BILL_COMPLETED': {'text': 'Đã giao hàng', 'value': 17},
    'BILL_INVENTORY': {'text': 'Không giao được', 'value': 18},
    'CANCEL': {'text': 'Đơn hàng đã bị hủy', 'value': 0},
  };

  static String getText(String key) {
    final Map<String, dynamic>? status = STATUS_QUOTE[key];
    return status?['text'] ?? 'Không xác định';
  }

  static dynamic getValue(String key) {
    final Map<String, dynamic>? status = STATUS_QUOTE[key];
    return status?['value'];
  }

  static String getTextByValue(dynamic value) {
    final entry = STATUS_QUOTE.entries.firstWhere(
      (entry) => entry.value['value'] == value,
      orElse: () => const MapEntry<String, Map<String, dynamic>>(
        'Không xác định',
        {'text': 'Không xác định', 'value': null},
      ),
    );

    return entry.value['text'];
  }
}

enum OAuthEnum {
  facebook,
  google,
  apple;

  String get name {
    switch (this) {
      case OAuthEnum.apple:
        return 'apple';
      case OAuthEnum.facebook:
        return 'facebook';
      case OAuthEnum.google:
        return 'google';
      default:
        return '';
    }
  }
}

///sharing platform
enum ShareEnum {
  facebook,
  messenger,
  twitter,
  share_instagram,
}
