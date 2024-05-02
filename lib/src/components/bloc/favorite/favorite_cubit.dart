import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/domain/dtos/favorite/favorite_dto.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/modules/favorite/components/filter_favorite_radio_horizontal.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/filter_search/filter_search_cubit.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/favorite/favorite_request.dart';
import '../../../data/object_request_api/favorite_seller/favorite_seller_request.dart';
import '../../../domain/dtos/seller/favorite_seller/favorite_seller_dto.dart';
import '../../../domain/repositories/components/user/user_repo.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'favorite_state.dart';
class FavoriteFilterModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();

  final FilterRadioHorizontalController conditionsFilterController = FilterRadioHorizontalController(
    AppStorage.favoriteFilterConditions,
    selectedOption: AppStorage.favoriteDefaultFilterConditions,
  );

  final FilterRadioHorizontalController conditionsArrangeController = FilterRadioHorizontalController(
    AppStorage.favoriteArrangeConditions,
    selectedOption: AppStorage.favoriteDefaultArrangeConditions,
  );
}
class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial(state: null));
  UserRepo get = getIt<UserRepo>();

  final FavoriteFilterModel filterModel = FavoriteFilterModel();

  //
  final TextEditingController textSearch = TextEditingController();
  FavoriteDto? favoriteDto = FavoriteDto();



  void favoriteItem(FavoriteRequest request) async {
    final response = await get.favoriteItem(request);
    response.fold((l) {
     emit(FavoritesSearchFailed(state: state));
    }, (r) async {

      emit(FavoriteItemSuccess(state: state));
    });
  }

  void favorites() async {
    emit(FavoriteLoading(state: null));
    final response = await get.favorites();
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(FavoritesSuccess(state: state)..favoriteDto = r);
      //gán data
      favoriteDto = r;
    });
  }

  void favoritesSeller(FavoriteSellerRequest request) async {
    emit(FavoriteLoading(state: state));
    final response = await get.favoritesSeller(request);
    response.fold((l) {
      emit(FavoritesSearchFailed(state: state)..isFavoriteSeller = l.message);
    }, (r) async {
      emit(FavoritesSellerSuccess(state: state)..isFavoriteSeller = r);
    });
  }

  void getFavoritesSeller(String code) async {
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    final token = hiveBox.get(AppConstants.ACCESS_TOKEN);
    if(token == null || token == ""){
     return emit(FavoritesSearchFailed(state: state));
    }
    emit(FavoriteLoading(state: state));
    final response = await get.getFavoritesSeller();
    response.fold((l) {
      emit(FavoritesSearchFailed(state: state)..isFavoriteSeller = l.message);
    }, (r) async {
      if(r.data!.isEmpty){
        return emit(FavoritesSearchEmpty(state: state));
      }
      FavoriteSellerItemDto? item = r.data!.firstWhere((item) => item.name == code, orElse: () => const FavoriteSellerItemDto());

      emit(GetFavoritesSellerSuccess(state: state)..itemFavoriteSeller = item);
    });
  }

  void deletedFavorites() async {
    final response = await get.favorites();
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(DeletedFavoritesSuccess(state: state));
    });
  }

  void search(String? keyword,String siteCode,String arrange) async{
    emit(FavoritesSearchLoading(state: null));
    final response = await get.favoriteSearch(keyword!,siteCode,arrange);
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.results!.isEmpty){
        return emit(FavoritesSearchEmpty(state: state));
      }
      return  emit(FavoritesSearchSuccess(state: state)..data = r.results);
    });
  }


}
