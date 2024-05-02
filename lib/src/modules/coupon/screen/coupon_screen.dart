import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/input.dart';
import 'package:jancargo_app/src/domain/dtos/user/voucher/voucher_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/coupon/bloc/coupon_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:slivers/slivers.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key, this.dto});

  final VoucherDto? dto;

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final CouponCubit _cubit = CouponCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100Color,
      appBar: AppBar(
        bottomOpacity: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => Future.delayed(Duration.zero, () {
            RouteService.pop();
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Voucher',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CouponCubit, CouponState>(
        bloc: _cubit,
        buildWhen: (prv, state) =>
            state is CouponLoading || state is CouponDataSuccess,
        builder: (context, state) {
          if (state is CouponLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is CouponDataSuccess) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _InputField(
                    onChange: (value) {
                      _cubit.searchCoupon(value);
                    },
                    controller: _cubit.controller,
                  ),
                ),
                _Coupons(
                  dto: state.voucherDto!,
                  cubit: _cubit,
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({super.key, required this.onChange, this.controller});

  final ValueSetter<String> onChange;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return FieldSearchCoupon(
      onChange: onChange,
      controller: controller,
    );
  }
}

class _Coupons extends StatefulWidget {
  const _Coupons({
    super.key,
    required this.dto, required this.cubit,
  });

  final VoucherDto dto;
  final CouponCubit cubit;

  @override
  State<_Coupons> createState() => _CouponsState();
}

class _CouponsState extends State<_Coupons> {
  List<VouchersDto>? searchDto = [];
  bool isSearch = false;


  @override
  Widget build(BuildContext context) {
    return BlocListener<CouponCubit, CouponState>(
      bloc: widget.cubit,
      listenWhen: (prv,state)=> state is SearchCouponLoading || state is SearchCouponDataSuccess || state is SearchCouponEmpty,
      listener: (context, state) {
        if (state is SearchCouponLoading) {
        } else if (state is SearchCouponDataSuccess) {
          searchDto = state.voucherDto!.data;
          isSearch = true;
          setState(() {

          });
        }else if (state is SearchCouponEmpty) {
          isSearch = false;
          setState(() {

          });
        }
      },
      child: SliverContainer(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        padding:
            EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h16),
        sliver: isSearch ? _search() :  SliverList.builder(
            itemBuilder: (context, index) {
              return _itemCoupon(widget.dto.data![index].coupons![index]);
            },
            itemCount: widget.dto.data![0].coupons!.length),
      ),
    );
  }

  Widget _search()=> searchDto == [] ? SliverToBoxAdapter(child: Center(child: Text('Không tìm thấy voucher!'),),) : SliverList.builder(
      itemBuilder: (context, index) {
        return _itemCoupon(searchDto![index].coupons![index]);
      },
      itemCount: widget.dto.data![0].coupons!.length);

  Widget _itemCoupon(VoucherItemDto item) => Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: AppGap.w3, right: AppGap.w10),
            margin: EdgeInsets.only(bottom: AppGap.h10),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.neutral300Color),
              borderRadius: BorderRadius.all(
                Radius.circular(AppGap.r8),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 72.h,
                    width: 68.w,
                    child: Image.asset(AppImages.icCoupon)),
                AppGap.sbW12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      style:
                          AppStyles.text4014(color: AppColors.neutral800Color),
                    ),
                    Text(
                      'Ngày hết hạn: ${AppConvert.convertStringDateTime(item.endDate!)}',
                      style:
                          AppStyles.text4012(color: AppColors.neutral500Color),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: AppGap.h16,
          //   right: AppGap.w10,
          //   child: Text(
          //     'Dùng ngay',
          //     style: AppStyles.text4016(color: AppColors.primary800Color),
          //   ),
          // ),
        ],
      );
}

class FieldSearchCoupon extends StatefulWidget {
  const FieldSearchCoupon({
    super.key,
    required this.onChange,
    this.controller,
    this.filterSheetBuilder,
    this.valueFilter,
  });

  final ValueSetter<String> onChange;
  final TextEditingController? controller;
  final WidgetBuilder? filterSheetBuilder;
  final ValueSetter<bool>? valueFilter;

  @override
  State<FieldSearchCoupon> createState() => _FieldSearchCouponState();
}

class _FieldSearchCouponState extends State<FieldSearchCoupon> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h5),
      margin: EdgeInsets.only(bottom: AppGap.h10),
      color: AppColors.white,
      child: Row(
        children: [
          SizedBox(
            width: widget.filterSheetBuilder == null ? 340 : 290,
            child: AppInput(
              placeholder: _controller.text.isEmpty
                  ? 'Tìm kiếm voucher'
                  : (_controller.text != "" ? '' : 'Tìm kiếm voucher'),
              controller: widget.controller,
              maxLine: 1,
              prefixIcon: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Center(
                      child: SvgPicture.asset(
                    AppImages.icSearchSmall,
                    color: AppColors.neutral400Color,
                    height: 20.h,
                    width: 20.w,
                    fit: BoxFit.contain,
                  ))),
              onChange: widget.onChange,
            ),
          ),
          if (widget.filterSheetBuilder != null)
            IconButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: widget.filterSheetBuilder!,
                ).then((value) {
                  if (value != true) return;
                  widget.valueFilter?.call(value);
                });
              },
              icon: SvgPicture.asset(AppImages.icFilter),
            ),
        ],
      ),
    );
  }
}
