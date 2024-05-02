import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

abstract class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthState authState) : super(AuthInitial());

  void login();

  void logout();

  void forgotPassword();

  void resetState();

  void register();
}
