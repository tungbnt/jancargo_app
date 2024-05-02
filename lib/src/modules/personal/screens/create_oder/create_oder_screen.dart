import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:slivers/slivers.dart';

import '../../../../components/resource/molecules/input.dart';

class CreateOderScreen extends StatelessWidget {
  const CreateOderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(' Cài đặt'),
        elevation: 0,
        shadowColor: AppColors.primary200Color,
      ),
      backgroundColor: AppColors.neutral100Color,
      body: CustomScrollView(
        slivers: [
          _fieldSearchPro(
                (keyword) {
              if (keyword.isEmpty && keyword == '') {

              }
            },
          ),
        ],
      ),
    );
  }

  Widget  _fieldSearchPro( ValueSetter<String> onChange,)=> SliverContainer(
    decoration: BoxDecoration(color: AppColors.white),
    sliver: MultiSliver(children: [
      Text('Tạo đơn hàng'),
      AppInput(
        placeholder: 'Tìm kiếm sán phẩm',
        maxLine: 1,
        prefixIcon: const Icon(Icons.search),
        onChange: onChange,
      )
    ]),
  );


}
