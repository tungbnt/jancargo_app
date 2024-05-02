import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../util/app_gap.dart';

class SeenAllBtn extends StatelessWidget {
  const SeenAllBtn({super.key, this.onTap});
 final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Ink(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Xem thêm',style: AppStyles.text6014(color: AppColors.primary700Color),),
            const Icon(Icons.navigate_next,color: AppColors.primary700Color,)
          ],
        ),
      ),

    );
  }

}
