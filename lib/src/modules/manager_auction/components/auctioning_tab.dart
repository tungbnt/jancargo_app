import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/manager_auction/bloc/auction_manager_cubit.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/input_field.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/widget_item_auction_manager.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/widget_item_auctioning_manager.dart';

class AuctioningTab extends StatefulWidget {
  const AuctioningTab({super.key, required this.cubit});

  final AuctionManagerCubit cubit;

  @override
  State<AuctioningTab> createState() => _AuctioningTabState();
}

class _AuctioningTabState extends State<AuctioningTab> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getAuctioningTab();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionManagerCubit, AuctionManagerState>(
      bloc: widget.cubit,
      buildWhen: (prv, state) => state is AuctionManagerSuccess || state is AuctionManagerLoading,
      builder: (context, state) {
        if (state is AuctionManagerLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is AuctionManagerSuccess) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: InputField(
                onChange: (value) {},
                controller: widget.cubit.controller,
              )),
              _AuctionManagers(
                items: state.auctionManagerDto?.data ?? [],
                cubit: widget.cubit,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _AuctionManagers extends StatefulWidget {
  const _AuctionManagers({
    super.key,
    required this.items,
    required this.cubit,
  });

  final List<ItemsAuctionManagerDto> items;
  final AuctionManagerCubit cubit;

  @override
  State<_AuctionManagers> createState() => _AuctionManagersState();
}

class _AuctionManagersState extends State<_AuctionManagers> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return BlocListener<AuctionManagerCubit, AuctionManagerState>(
          bloc: widget.cubit,
          listenWhen: (prv,state)=> state is LoadingItemAuctionManagerSuccess || state is ReloadItemAuctionManagerSuccess,
          listener: (context, state) {
           if(state is LoadingItemAuctionManagerSuccess){
             isLoading = true;
           }else if(state is ReloadItemAuctionManagerSuccess){
                 if(state.updateInfoAuction!.highestBidder!.isHighest!){
                   // items[index].name = 'sợ chưa';
                 }
                 isLoading = false;
           }
           setState(() {

           });
          },
          child: Stack(
            children: [
              WidgetItemAuctioningManager(
                item: widget.items[index],
                cubit: widget.cubit,
                getCurrentIndex: (value) {
                  setState(() {
                    widget.items.remove(value);
                  });
                },
              ),
              if(isLoading)
              Positioned.fill(
                child: Container(
                  color: AppColors.white.withOpacity(0.4),
                  child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                                ),
                ),),
            ],
          ),
        );
      },
      itemCount: widget.items.length,
    );
  }
}
