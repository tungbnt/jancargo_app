import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jancargo_app/src/data/object_request_api/auction_manager/auction_manager_request.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/domain/repositories/management/auction_manager_repo.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/filter_search/filter_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/filter_radio_horizontal.dart';
import 'package:meta/meta.dart';

part 'auction_manager_state.dart';
class AuctionManagerModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();


  final FilterRadioHorizontalController conditionsArrangeController = FilterRadioHorizontalController(
    AppStorage.auctionManagerArrangeConditions,
    selectedOption: AppStorage.auctionManagerDefaultArrangeConditions,
  );
}
class AuctionManagerCubit extends Cubit<AuctionManagerState> {
  AuctionManagerCubit() : super(AuctionManagerInitial(state: null));
  final AuctionManagementRepo _repo = getIt<AuctionManagementRepo>();
  final TextEditingController controller = TextEditingController();
  final AuctionManagerModel filterModel = AuctionManagerModel();
  AuctionManagerDto? auctionManagerDto = AuctionManagerDto();

  static final DateTime currentDate = DateTime.now();
  static final DateTime ninetyDaysAgo =
      currentDate.subtract(const Duration(days: 30));

  final formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
  final formattedNinetyDaysAgo = DateFormat('yyyy-MM-dd').format(ninetyDaysAgo);

  void getAll({String? keyword,String? arrange}) async {
    List<String?>? parts = arrange?.split(':');
      String? sort = parts![0] ?? 'end_time';
      String? oder = parts[1]?? 'asc';

    emit(AuctionManagerLoading(state: state));
    final response = await _repo.oderManagement(
      request: AuctionManagementRequest(
          size: AppConstants.sizeApi,
          page: '1',
          sort: sort ,
          type: 'all',
          order: oder ,
          from: formattedNinetyDaysAgo,
          to: formattedCurrentDate),
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionManagerSuccess(state: state)..auctionManagerDto = r);
    });
  }

  void getAuctioningTab({String? keyword,String? arrange}) async {
    emit(AuctionManagerLoading(state: state));

    //
    List<String?>? parts = arrange?.split(':');
    String? sort = parts![0] ?? 'end_time';
    String? oder = parts[1]?? 'asc';

    final response = await _repo.oderManagement(
      request: AuctionManagementRequest(
          size: AppConstants.sizeApi,
          page: '1',
          sort: sort,
          type: 'bidding',
          order: oder,
          from: formattedNinetyDaysAgo,
          to: formattedCurrentDate),
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionManagerSuccess(state: state)..auctionManagerDto = r);
    });
  }

  void getEndOffSession({String? keyword,String? arrange}) async {
    emit(AuctionManagerLoading(state: state));

    //
    List<String?>? parts = arrange?.split(':');
    String? sort = parts![0] ?? 'end_time';
    String? oder = parts[1]?? 'asc';

    final response = await _repo.oderManagement(
      request: AuctionManagementRequest(
          size: AppConstants.sizeApi,
          page: '1',
          sort: sort,
          type: 'finished',
          order: oder,
          from: formattedNinetyDaysAgo,
          to: formattedCurrentDate),
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionManagerSuccess(state: state)..auctionManagerDto = r);
    });
  }

  void getLastHunting({String? keyword,String? arrange}) async {
    emit(AuctionManagerLoading(state: state));

    //
    List<String?>? parts = arrange?.split(':');
    String? sort = parts![0] ?? 'end_time';
    String? oder = parts[1]?? 'asc';

    final response = await _repo.oderManagement(
      request: AuctionManagementRequest(
          size: AppConstants.sizeApi,
          page: '1',
          sort: sort,
          type: 'hunting',
          order: oder,
          from: formattedNinetyDaysAgo,
          to: formattedCurrentDate),
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionManagerSuccess(state: state)..auctionManagerDto = r);
    });
  }

  void getPaymentedTab({String? keyword,String? arrange}) async {
    emit(AuctionManagerLoading(state: state));

    //
    List<String?>? parts = arrange?.split(':');
    String? sort = parts![0] ?? 'end_time';
    String? oder = parts[1]?? 'asc';

    final response = await _repo.oderManagement(
      request: AuctionManagementRequest(
          size: AppConstants.sizeApi,
          page: '1',
          sort: sort,
          type: 'paid',
          order: oder,
          from: formattedNinetyDaysAgo,
          to: formattedCurrentDate),
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionManagerSuccess(state: state)..auctionManagerDto = r);
    });
  }

  void getSuccessAuction({String? keyword,String? arrange}) async {
    emit(AuctionManagerLoading(state: state));

    //
    List<String?>? parts = arrange?.split(':');
    String? sort = parts![0] ?? 'end_time';
    String? oder = parts[1]?? 'asc';

    final response = await _repo.oderManagement(
      request: AuctionManagementRequest(
          size: AppConstants.sizeApi,
          page: '1',
          sort: sort,
          type: 'successed',
          order: oder,
          from: formattedNinetyDaysAgo,
          to: formattedCurrentDate),
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionManagerSuccess(state: state)..auctionManagerDto = r);
    });
  }

  void updateDataItem(String code) async {
    emit(LoadingItemAuctionManagerSuccess(state: state));
    final response = await _repo.updateItemAuction(
      code: code,
    );

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(
          ReloadItemAuctionManagerSuccess(state: state)..updateInfoAuction = r);
    });
  }
}
