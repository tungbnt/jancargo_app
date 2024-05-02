import '../../../general/constants/app_enum.dart';
import 'login_by_social.dart';

class LoginByGoogleRequest  {
  final String? googleId;
  final String? googleToken;
  final String? email;
  final String? typeMode;
  final String? next;
  final String? oAuthEnum;
  final String? url;

  LoginByGoogleRequest( {
    this.url,
    this.googleId,
    this.googleToken,
    this.email,
    this.typeMode,
    this.next,
    this.oAuthEnum,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'provider': oAuthEnum,
      'url_page': url,
      'id_token': googleId,
      'token': googleToken,
      'email': email,
      'type_mode': typeMode,
      'next': next,
    };
    return data;
  }
}
