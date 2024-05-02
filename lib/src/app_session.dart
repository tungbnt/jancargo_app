

class AppSession {
  static String? _account;
  String? get account => _account;
  void saveAccount(String? account) {
    _account = account;
  }
  static String? _type;
  String? get type => _type;
  void saveType(String? type) {
    _type = type;
  }

  static int? _exchange;
  int? get exchange => _exchange;
  void saveExchange(int? exchange) {
    _exchange = exchange ?? 176;
  }


  static String? _codeShop;
  String? get codeShop => _codeShop;
  void saveCodeShop(String? codeShop) {
    _codeShop = codeShop;
  }

  static String? _codeCategory;
  String? get codeCategory => _codeCategory;
  void saveCodeCategory(String? codeCategory) {
    _codeCategory = codeCategory;
  }

  static String? _nameCategory;
  String? get nameCategory => _nameCategory;
  void saveNameCategory(String? nameCategory) {
    _nameCategory = nameCategory;
  }

  static DateTime? _isPauseApp;
  DateTime? get isPauseApp => _isPauseApp;
  void saveTimePause(DateTime? isPauseApp) {
    _isPauseApp = isPauseApp;
  }

}
