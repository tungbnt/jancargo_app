import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/modules/manager_auction/bloc/auction_manager_cubit.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/input_field.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/widget_item_auction_manager.dart';

class SuccessAuctionTab extends StatefulWidget {
  const SuccessAuctionTab({super.key, required this.cubit});
  final AuctionManagerCubit cubit;

  @override
  State<SuccessAuctionTab> createState() => _SuccessAuctionTabState();
}

class _SuccessAuctionTabState extends State<SuccessAuctionTab> {
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    widget.cubit.getSuccessAuction();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuctionManagerCubit, AuctionManagerState>(
      bloc: widget.cubit,
      listenWhen: (prv, state) => state is AuctionManagerSuccess,
      listener: (context, state) {
        if (state is AuctionManagerSuccess) {
          isSearch = true;
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: InputField(
                onChange: (value) {
                  if (isSearch == false) {
                    return;
                  }
                  widget.cubit.getSuccessAuction(keyword: value);
                },
                controller: widget.cubit.controller,
              )),
          BlocBuilder<AuctionManagerCubit, AuctionManagerState>(
            bloc: widget.cubit,
            buildWhen: (prv, state) =>
            state is AuctionManagerSuccess ||
                state is AuctionManagerLoading,
            builder: (context, state) {
              if (state is AuctionManagerLoading) {
                return  SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 80.h,
                    child: const Column(
                      children: [
                        Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is AuctionManagerSuccess) {
                return _AuctionManagers(
                  items: state.auctionManagerDto!.data ?? [],
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}

class _AuctionManagers extends StatelessWidget {
  const _AuctionManagers({super.key, required this.items,});
  final List<ItemsAuctionManagerDto> items;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(itemBuilder: (context, index) {
      return WidgetItemAuctionManager(item: items[index],

      );
    }, itemCount: items.length,
    );
  }
}
