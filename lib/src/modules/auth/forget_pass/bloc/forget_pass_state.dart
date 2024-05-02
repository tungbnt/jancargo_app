part of 'forget_pass_cubit.dart';

@immutable
abstract class ForgetPassState {
  ForgetPassState({required ForgetPassState? state}) {
    dto = state?.dto;
  }
  VerifyOtpDto? dto;

  void copy(ForgetPassState? state) {
    dto = state?.dto;
  }

}

class ForgetPassInitial extends ForgetPassState {
  ForgetPassInitial({required super.state});
}
class ForgetPassLoading extends ForgetPassState {
  ForgetPassLoading({required super.state});
}
class ForgetPassSuccess extends ForgetPassState {
  ForgetPassSuccess({required super.state});
}
class ForgetPassSuccessPassOtpSuccess extends ForgetPassState {
  ForgetPassSuccessPassOtpSuccess({required super.state});
}
class ForgetPassResendOtpSuccess extends ForgetPassState {
  ForgetPassResendOtpSuccess({required super.state});
}
class ForgetPassVerifyOtpSuccess extends ForgetPassState {
  ForgetPassVerifyOtpSuccess({required super.state});
}
class ForgetPassFailed extends ForgetPassState {
  ForgetPassFailed({required super.state});
}
