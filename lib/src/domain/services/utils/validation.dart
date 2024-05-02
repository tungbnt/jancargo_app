class Validation {

  static String? validate({String? value}) {
    if (value == null || value.isEmpty) {
      return 'Bạn vui lòng không để trống';
    }
  }
  static String? validateEmail({String? email}) {
    late final RegExp _emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email == null || email.isEmpty) {
      return 'Bạn vui lòng nhập Email';
    }

    if (!_emailRegex.hasMatch(email) ) {
      return 'Email không hợp lệ!';
    }
    return null;
  }

  static String? validatorPhone(String? number) {

    late final RegExp _sdtRegex = RegExp(
        r'^(0|84)(\s|\.|-)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.|-)?(\d{3})(\s|\.|-)?(\d{3})$');

    if (number == null || number.isEmpty) {
      return 'Bạn vui lòng không để trống!';
    }
    if (!_sdtRegex.hasMatch(number)) {
      return 'Số điện thoại không hợp lệ!';
    }
    return null;
  }
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Bạn vui lòng nhập họ tên';
    }
    if (RegExp(r' {2,}').hasMatch(value.trim())) {
      return 'Họ tên không chứa khoảng trắng';
    }
    if (RegExp(r'[.,!@#\$&*~^%()+x=/_€£¥₩÷`|•√π×∆°{}℅?¢<>;:"]')
        .hasMatch(value.trim())) {
      return 'Họ tên không chứa kí tự đặc biệt';
    }
    if (RegExp(r'[0-9]').hasMatch(value.trim()) && value.trim().isNotEmpty) {
      return 'Họ và tên không  được chứa số';
    }

    return null;
  }

  static String? validatorPass(String? number) {
    late final RegExp _sdtRegex = RegExp(
        r'^(?=.*[A-Za-z0])(?!.*\s).{8,}$');

    if (number == null || number.isEmpty) {
      return 'Bạn vui lòng nhập mật khẩu';
    }
    if (number.length < 6) {
      return 'Mật khẩu phải từ 6 kí tự!';
    }
    return null;
  }

  static String? validatorPassAgain(String? number,String pass) {
    if (number == null || number.isEmpty) {
      return 'Bạn vui lòng nhập mật khẩu';
    }
    if (pass != number) {
      return 'Mật khẩu không trùng khớp!';
    }
    return null;
  }
}