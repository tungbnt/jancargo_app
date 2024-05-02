import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';

class WidgetObjectResolver extends StatefulWidget {
  const WidgetObjectResolver({super.key, required this.url});
  final String url;

  @override
  State<WidgetObjectResolver> createState() => _WidgetObjectResolverState();
}

class _WidgetObjectResolverState extends State<WidgetObjectResolver> {
  final RakutenSearchCubit _cubit = RakutenSearchCubit();

  @override
  void initState() {
    super.initState();
    _cubit.objectResolverRakuten(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RakutenSearchCubit, RakutenSearchState>(
      bloc: _cubit,
      listenWhen: (prv, state) =>
          state is RakutenObjectResolverLoading ||
          state is RakutenObjectResolverSuccess,
      listener: (context, state) {
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
           RouteService.routeGoOnePage(
            RakutenDetailProductScreen(
              code:
                  '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
              source: AppConstants.rakutenSource,
            ),
          );
        }
      },
    );
  }
}
