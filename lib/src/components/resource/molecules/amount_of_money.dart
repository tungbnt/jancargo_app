import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../general/constants/app_colors.dart';
import '../../../modules/home/widget/auction_items.dart';
import '../../../util/app_convert.dart';
import '../../bloc/favorite/favorite_cubit.dart';

class AmountOfMoney extends StatefulWidget {
  const AmountOfMoney({super.key, required this.amountOfMoney, required this.icon, required this.isFavorite, required this.code, required this.name, required this.siteCode, required this.price, required this.endTime, required this.image, required this.currency, required this.url});
  final int amountOfMoney;
  final String icon;
  final String code;
  final String name;
  final String siteCode;
  final int price;
  final String endTime;
  final String image;
  final String currency;
  final String url;
  final ValueNotifier<bool> isFavorite;

  @override
  State<AmountOfMoney> createState() => _AmountOfMoneyState();
}

class _AmountOfMoneyState extends State<AmountOfMoney> {
  final FavoriteCubit _cubitFavorite = FavoriteCubit();
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppConvert.convertAmountVn(widget.amountOfMoney),style: AppStyles.text7016(color: AppColors.primary700Color)),
                Text(AppConvert.convertAmountJp(widget.amountOfMoney),style: AppStyles.text4014(color: AppColors.neutral400Color)),
              ],
            ),
            Spacer(),

          ],
        ),
        Positioned(
          bottom: -10,
          right: -5,
          child:  FavoriteIcon(
          code: widget.code,
            siteCode: widget.code,
            name: widget.name,
            price: widget.price,
            currency: widget.currency,
            endTime: widget.endTime,
            url: widget.url,
            image:  widget.image,
          favorite: widget.isFavorite,
          cubit: _cubitFavorite,
        ),)
      ],
    );
  }
}
