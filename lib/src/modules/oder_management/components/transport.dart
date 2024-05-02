import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../bloc/oder_management_cubit.dart';
import 'item_oder_management.dart';

class Transport extends StatefulWidget {
  const Transport({super.key, required this.cubit});

  final OderManagementCubit cubit;

  @override
  State<Transport> createState() => _TransportState();
}

class _TransportState extends State<Transport> {
  @override
  void initState() {
    super.initState();
    _getOder();
  }
  void _getOder(){
    return widget.cubit.transport();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OderManagementCubit, OderManagementState>(
      bloc: widget.cubit,
      buildWhen: (prv,state)=> state is OderManagementTransportSuccess || state is OderManagementEmpty || state is OderManagementLoading,
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
        if(state is OderManagementTransportSuccess) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: AppGap.h10),
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int i) {
                  return Container(
                      height: AppGap.h245,
                      color: AppColors.white,
                      padding: EdgeInsets.only(top: AppGap.h10),
                      child: ItemOderManagement(dto: state.managementDto!.data!.results![i],));
                }, separatorBuilder: (context, int i) {
              return AppGap.sbH10;
            }, itemCount: state.managementDto!.data!.results!.length),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
