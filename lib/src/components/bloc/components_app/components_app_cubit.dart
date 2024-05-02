import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'components_app_state.dart';

class ComponentsAppCubit extends Cubit<ComponentsAppState> {
  ComponentsAppCubit() : super(ComponentsAppInitial());
}
