import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../bloc/oder_management_cubit.dart';
import 'item_oder_management.dart';

class Delivering extends StatefulWidget {
  const Delivering({super.key, required this.cubit});

  final OderManagementCubit cubit;

  @override
  State<Delivering> createState() => _DeliveringState();
}

class _DeliveringState extends State<Delivering> {
  @override
  void initState() {
    super.initState();
    _getOder();
  }
  void _getOder(){
    return widget.cubit.delivering();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OderManagementCubit, OderManagementState>(
      bloc: widget.cubit,
      buildWhen: (prv,state)=> state is OderManagementDeliveringSuccess || state is OderManagementEmpty || state is OderManagementLoading,
      builder: (context, state) {
        if(state is OderManagementLoading){
          return SizedBox(
            height: MediaQuery.of(context).size.height - AppGap.h128,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if(state is OderManagementEmpty){
          return SizedBox(
            height: MediaQuery.of(context).size.height - AppGap.h128,
            child: Center(
              child: Text('Không có dữ liệu'),
            ),
          );
        }
        if(state is OderManagementDeliveringSuccess) {
          return ListView.separated(itemBuilder: (context, int i) {
            return ItemOderManagement(dto: state.managementDto!.data!.results![i],);
          }, separatorBuilder: (context, int i) {
            return AppGap.sbH10;
          }, itemCount: state.managementDto!.data!.results!.length);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
