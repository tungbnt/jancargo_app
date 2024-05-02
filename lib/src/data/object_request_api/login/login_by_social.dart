
import '../../../general/constants/app_enum.dart';

class LoginBySocial {
  final String? next;
  final String? url;
  final OAuthEnum? oAuthEnum;
  final int? typeMode;

  LoginBySocial({
    this.next,
    this.oAuthEnum,
    this.typeMode,
    this.url,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'next': next,
      'provider': oAuthEnum?.name,
      'type_mode': typeMode,
      'url_page': "https://jancargo.com/",
    };
    return data;
  }
}
