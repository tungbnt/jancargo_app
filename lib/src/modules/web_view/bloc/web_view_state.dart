part of 'web_view_cubit.dart';

@immutable
abstract class WebViewState {
   WebViewState({this.isLoading});

   bool? isLoading;
  copy(WebViewState state) {
    isLoading = state.isLoading;
  }

}

class WebViewInitial extends WebViewState {}
class WebViewLoading extends WebViewState {
  WebViewLoading(WebViewState state) {
    super.copy(state);
  }
}
