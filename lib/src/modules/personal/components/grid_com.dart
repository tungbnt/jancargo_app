import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';

import '../../../util/app_gap.dart';
import '../widget/container_grid.dart';

class GridCom extends StatelessWidget {
  const GridCom({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) =>  ContainerGrid(model: AppStorage.myModelList[index],),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3 / 2,mainAxisExtent: AppGap.w174,
        crossAxisSpacing: AppGap.h5,
        mainAxisSpacing:  AppGap.h5,),
      itemCount: AppStorage.myModelList.length,
    );
  }
}
