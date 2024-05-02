import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';

import '../../../components/resource/molecules/flash_sale_timer.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';

class TimeAuction extends StatelessWidget {
  const TimeAuction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
      width: double.infinity,
      height: AppGap.h40,
      child: Row(
        children: [
          Text(
            AppStrings.of(context).auctionTime,
            style: AppStyles.text7018(),
          ),
          Spacer(),
          FlashSaleTimer(),
        ],
      ),
    );
  }
}
