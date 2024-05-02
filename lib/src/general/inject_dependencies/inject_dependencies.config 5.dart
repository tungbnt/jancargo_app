// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../components/resource/molecules/app_loading.dart' as _i4;
import '../../data/datasource/auction/auction_datasource.dart' as _i5;
import '../../data/datasource/auth/auth_source.dart' as _i10;
import '../../data/datasource/cart/cart_datasource.dart' as _i11;
import '../../data/datasource/components/user/user_datasource.dart' as _i36;
import '../../data/datasource/dashboard/home_data_source.dart' as _i22;
import '../../data/datasource/details_product/detail_product_datasource.dart'
    as _i16;
import '../../data/datasource/favorite/favorite_datasource.dart' as _i18;
import '../../data/datasource/management/auction_manager/auction_manager_datasource.dart'
    as _i7;
import '../../data/datasource/management/oder_management/oder_management_datasource.dart'
    as _i25;
import '../../data/datasource/search/search_auction_datasource.dart' as _i28;
import '../../data/datasource/seller/seller_datasource.dart' as _i30;
import '../../data/datasource/setting/setting_datasource.dart' as _i33;
import '../../data/remote/app-client.dart' as _i3;
import '../../domain/dtos/auth/get-local-access-token.dart' as _i20;
import '../../domain/repositories/auction/auction_repo.dart' as _i8;
import '../../domain/repositories/auth/delete-local-access-token.dart' as _i14;
import '../../domain/repositories/auth/login/base_user_res/base_user.dart'
    as _i9;
import '../../domain/repositories/auth/save-access-token.dart' as _i27;
import '../../domain/repositories/cart/cart_repo.dart' as _i12;
import '../../domain/repositories/components/user/user_repo.dart' as _i35;
import '../../domain/repositories/dashboard/dashboard_repo.dart' as _i13;
import '../../domain/repositories/detail_product/detail_product_repo.dart'
    as _i15;
import '../../domain/repositories/management/auction_manager_repo.dart' as _i6;
import '../../domain/repositories/management/oder_management_repo.dart' as _i24;
import '../../domain/repositories/search/search_repo.dart' as _i29;
import '../../domain/repositories/seller/seller_repo.dart' as _i31;
import '../../domain/repositories/setting/setting_repo.dart' as _i32;
import '../../domain/services/dialog/dialog_service.dart' as _i17;
import '../../domain/services/navigator/route_service.dart' as _i26;
import '../../modules/auth/forget_pass/bloc/forget_pass_cubit.dart' as _i19;
import '../../modules/auth/login/bloc/login_cubit.dart' as _i23;
import '../../modules/auth/sign_up/bloc/sign_u_cubit.dart' as _i34;
import '../../modules/home/bloc/home_cubit.dart' as _i21;
import '../../modules/web_view/bloc/web_view_cubit.dart' as _i37;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppClient>(() => _i3.AppClient());
    gh.singleton<_i4.AppLoading>(() => _i4.AppLoading());
    gh.singleton<_i5.AuctionDataSource>(() => _i5.AuctionDataSource());
    gh.singleton<_i6.AuctionManagementRepo>(() => _i6.AuctionManagementRepo());
    gh.singleton<_i7.AuctionManagementSource>(
        () => _i7.AuctionManagementSource());
    gh.singleton<_i8.AuctionRepo>(() => _i8.AuctionRepo());
    gh.singleton<_i9.AuthRepo>(() => _i9.AuthRepo());
    gh.singleton<_i10.AuthSource>(() => _i10.AuthSource());
    gh.singleton<_i11.CartDataSource>(() => _i11.CartDataSource());
    gh.singleton<_i12.CartRepo>(() => _i12.CartRepo());
    gh.singleton<_i13.DashBoardRepo>(() => _i13.DashBoardRepo());
    gh.singleton<_i14.DeleteLocalAccessToken>(
        () => _i14.DeleteLocalAccessToken());
    gh.singleton<_i15.DetailProductRepo>(() => _i15.DetailProductRepo());
    gh.singleton<_i16.DetailProductSource>(() => _i16.DetailProductSource());
    gh.singleton<_i17.DialogService>(() => _i17.DialogService());
    gh.singleton<_i18.FavoriteSource>(() => _i18.FavoriteSource());
    gh.singleton<_i19.ForgetPassCubit>(() => _i19.ForgetPassCubit());
    gh.singleton<_i20.GetLocalAccessToken>(() => _i20.GetLocalAccessToken());
    gh.factory<_i21.HomeCubit>(() => _i21.HomeCubit());
    gh.singleton<_i22.HomeSource>(() => _i22.HomeSource());
    gh.singleton<_i23.LoginCubit>(() => _i23.LoginCubit());
    gh.singleton<_i24.OderManagementRepo>(() => _i24.OderManagementRepo());
    gh.singleton<_i25.OderManagementSource>(() => _i25.OderManagementSource());
    gh.singleton<_i26.RouteService>(() => _i26.RouteService());
    gh.singleton<_i27.SaveAccessToken>(() => _i27.SaveAccessToken());
    gh.singleton<_i28.SearchDatasource>(() => _i28.SearchDatasource());
    gh.singleton<_i29.SearchRepo>(() => _i29.SearchRepo());
    gh.singleton<_i30.SellerDataSource>(() => _i30.SellerDataSource());
    gh.singleton<_i31.SellerDetailProductRepo>(
        () => _i31.SellerDetailProductRepo());
    gh.singleton<_i32.SettingRepo>(() => _i32.SettingRepo());
    gh.singleton<_i33.SettingSource>(() => _i33.SettingSource());
    gh.singleton<_i34.SignUpCubit>(() => _i34.SignUpCubit());
    gh.singleton<_i35.UserRepo>(() => _i35.UserRepo());
    gh.singleton<_i36.UserSource>(() => _i36.UserSource());
    gh.singleton<_i37.WebViewCubit>(() => _i37.WebViewCubit());
    return this;
  }
}
