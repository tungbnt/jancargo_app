import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class RowSuggestion extends StatelessWidget {
  RowSuggestion({super.key, this.getCurrentIndex, required this.dto});

  final ValueSetter<String>? getCurrentIndex;
  final List<SearchSuggestionItemDto> dto;

  List<String> suggestions = [
    'Nồi cơm điện',
    'Máy giặt',
    'Túi xách Gucci',
    'Máy ảnh Nhật',
    'Giày hiệu'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: AppGap.h10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dto.isNotEmpty && dto != null
            ? dto
                .map((e) =>
                    columnSuggest(e.name!, e.name == 'Giày hiệu' ? false : true))
                .toList()
            : suggestions
                .map((e) => columnSuggest(e, e == 'Giày hiệu' ? false : true))
                .toList(),
      ),
    );
  }

  Widget columnSuggest(String text, bool isDivider) => GestureDetector(
        onTap: () {
          getCurrentIndex?.call(text);
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                child: Text(
                  text,
                  style: AppStyles.text4014(color: AppColors.neutral900Color),
                ),
              ),
              isDivider && dto.length != 1 ? const Divider() : const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
