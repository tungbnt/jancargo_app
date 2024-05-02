import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/widget/widget_object_resolver.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/address/widgets/text_drop_down.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/screens/searchs_screens.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class WidgetFieldHome extends StatefulWidget {
  const WidgetFieldHome({super.key, required this.callback});

  final VoidCallback callback;

  @override
  State<WidgetFieldHome> createState() => _WidgetFieldHomeState();
}

class _WidgetFieldHomeState extends State<WidgetFieldHome> {
  // ValueNotifier<String> _selectedItem = ValueNotifier("1");
  final ValueNotifier<DropdownMenuEntry?> _selectedItem = ValueNotifier(null);
  final TextEditingController _controller = TextEditingController(text: null);

  final RakutenSearchCubit _cubit = RakutenSearchCubit();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppImages.icLogoHome,
          height: 30.h,
          width: 35.w,
        ),
        AppGap.sbW8,
        Container(
          width: 265.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(AppGap.r8),
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppGap.sbW8,
              ValueListenableBuilder(
                  valueListenable: _selectedItem,
                  builder: (context, selectedItem, __) {
                    return DropdownFormField(
                      selectedItem: selectedItem,
                      searchTextStyle:
                          AppStyles.text4014(color: AppColors.neutral800Color),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      enableSearch: false,
                      width: 30.w,
                      dropdownWidth: 180.w,
                      dropdownDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.neutral300Color),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      findFn: (keywords) async => [
                        _buildDropDownItem(
                          value: '0',
                          icon: AppImages.imgJan,
                          siteName: 'Jancargo hub',
                        ),
                        _buildDropDownItem(
                          value: '1',
                          icon: AppImages.imgAuction,
                          siteName: 'Yahoo! Auction',
                        ),
                        _buildDropDownItem(
                          value: '2',
                          icon: AppImages.imgShopping,
                          siteName: 'Yahoo! Shopping',
                        ),
                        _buildDropDownItem(
                          value: '3',
                          icon: AppImages.imgRakuten,
                          siteName: 'Rakuten',
                        ),
                        _buildDropDownItem(
                          value: '4',
                          icon: AppImages.imgMercari,
                          siteName: 'Mercari',
                        ),
                        _buildDropDownItem(
                          value: '5',
                          icon: AppImages.imgPaypay,
                          siteName: 'Paypay Fleamarket',
                        ),
                        _buildDropDownItem(
                          value: '6',
                          icon: AppImages.imgAmazon,
                          siteName: 'Amazon JP',
                        ),
                      ],
                      selectedItemBuilder: (item) {
                        if (item == null) {
                          return Image.asset(
                            AppImages.imgJan,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '0') {
                          return Image.asset(
                            AppImages.imgJan,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '1') {
                          return Image.asset(
                            AppImages.imgAuction,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '2') {
                          return Image.asset(
                            AppImages.imgShopping,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '3') {
                          return Image.asset(
                            AppImages.imgRakuten,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '4') {
                          return Image.asset(
                            AppImages.imgMercari,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '5') {
                          return Image.asset(
                            AppImages.imgPaypay,
                            height: 24.h,
                            width: 24.w,
                          );
                        } else if (item.value == '6') {
                          return Image.asset(
                            AppImages.imgAmazon,
                            height: 24.h,
                            width: 24.w,
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: item.leadingIcon,
                        );
                      },
                      onChanged: (value) {
                        _selectedItem.value = value!;
                      },
                      emptyText: 'Không có dữ liệu',
                      dropdownItemFn:
                          (item, position, focused, selected, onTap) {
                        return InkWell(
                          onTap: onTap,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, bottom: 8.w),
                            child: Row(
                              children: [
                                item.leadingIcon!,
                                Text(item.label),
                              ],
                            ),
                          ),
                        );
                      },
                      hintTextBuilder:
                          (DropdownMenuEntry<dynamic>? selectedItem) {
                        return '';
                      },
                    );
                  }),
              AppGap.sbW8,
              SvgPicture.asset(AppImages.icLine),
              Container(
                width: 16.w,
                height: 16.h,
                margin: EdgeInsets.symmetric(horizontal: AppGap.w8),
                child: SvgPicture.asset(
                  AppImages.icSearchSmall,
                  width: 20.w,
                  height: 20.h,
                  color: AppColors.neutral400Color,
                ),
              ),
              BlocListener<RakutenSearchCubit, RakutenSearchState>(
                bloc: _cubit,
                listenWhen: (prv, state) =>
                    state is RakutenObjectResolverLoading ||
                    state is RakutenObjectResolverSuccess,
                listener: (context, state) async{
                  print('state :  $state');
                  if (state is RakutenObjectResolverLoading) {
                    openDialogBox(
                      context,
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellow800Color,
                        ),
                      ),
                    );
                  } else if (state is RakutenObjectResolverSuccess) {
                   await  RouteService.pop();
                   await RouteService.routeGoOnePage(
                      RakutenDetailProductScreen(
                        code:
                            '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                        source: AppConstants.rakutenSource,
                      ),
                    );
                  }else if(state is RakutenSearchFailed){
                    await  RouteService.pop();
                    await DialogService.showNotiBannerFailed(context, AppColors.white, 'Link sản phẩm không có hoặc chưa được hỗ trợ');
                  }
                },
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.justify,
                      // cursorHeight: 1.4,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral800Color),
                      decoration: InputDecoration(
                          hintText: 'Hôm nay mua gì',
                          hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.neutral400Color),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 6.0, 8.0)),
                      onSubmitted: (value) async {
                        bool hasUrl = AppConvert.regexHasUrl(
                          value,
                        );
                        if (value.contains('https://item.rakuten.co.jp/')) {
                          await _cubit.objectResolverRakuten(value);
                        } else if (hasUrl) {
                          await AppConvert.regexSearch(context, value);
                        } else {
                          await RouteService.routeGoOnePage(SearchsScreens(
                            category: "",
                            keyWord: value,
                            indexTab: int.parse(
                                _selectedItem.value?.value.toString() ?? '0'),
                            title:
                                'Tìm kiếm ${AppStorage.items[int.parse((_selectedItem.value?.value ?? 0).toString())]['text']}',
                          ));
                        }
                        // set value
                        widget.callback.call();
                        _controller.text = '';
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  DropdownMenuEntry _buildDropDownItem({
    required String value,
    String? icon,
    String? siteName,
  }) =>
      DropdownMenuEntry(
          label: ' $siteName',
          leadingIcon: Padding(
            padding: EdgeInsets.only(
              right: 8.w,
            ),
            child: Image.asset(
              icon ?? AppImages.imgAuction,
              height: 24.h,
              width: 24.w,
            ),
          ),
          value: value);
}
