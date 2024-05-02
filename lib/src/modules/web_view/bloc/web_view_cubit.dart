import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'web_view_state.dart';

@singleton
class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit() : super(WebViewInitial());

  void initEvent({bool? isLoading = false}) {

    emit(
      WebViewInitial()
        ..isLoading = isLoading,
    );
  }

  void stopLoading() {
    initEvent(isLoading: false);
  }
}
