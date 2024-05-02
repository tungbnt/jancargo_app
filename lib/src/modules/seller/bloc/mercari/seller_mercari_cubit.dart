import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../domain/dtos/seller/seller_mercari/seller_mercari_dto.dart';
import '../../../../domain/repositories/seller/seller_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'seller_mercari_state.dart';

class SellerMercariCubit extends Cubit<SellerMercariState> {
  SellerMercariCubit() : super(SellerDetailProductInitial(state: null));

  SellerDetailProductRepo get = getIt<SellerDetailProductRepo>();
  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());

  //auction
  Future<void> getSellerMercari(String code,String name) async {
    Future.delayed(Duration(seconds: 1));
    emit(SellerDetailProductLoading(state: state));
    final response = await get.sellerMercari(code,name);
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SellerSuccessProduct(state: state)..sellerDetailMercariDto = r);

    });
  }
}
