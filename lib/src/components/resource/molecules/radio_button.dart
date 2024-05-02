import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  const CustomRadioListTile({
    super.key,
    required this.title,
    this.onSelected,
    required this.value,
    this.groupValue,
  });

  final String title;
  final T value;
  final T? groupValue;
  final ValueSetter<T>? onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onSelected?.call(value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(

            value: value,
            groupValue: groupValue,
            activeColor: AppColors.primary800Color,
            onChanged: (value) {
              onSelected?.call(value as T);
            },
          ),
          Text(title,style: AppStyles.text4012(),),
        ],
      ),
    );
  }
}

class CustomRadioListWidget<T> extends StatelessWidget {
  const CustomRadioListWidget({
    super.key,
    required this.widget,
    this.onSelected,
     this.value,
    this.groupValue,
  });

  final Widget widget;
  final T? value;
  final T? groupValue;
  final ValueSetter<T>? onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onSelected?.call(value as T);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: value,
            groupValue: groupValue,
            activeColor: AppColors.primary800Color,
            onChanged: (value) {
              if(value == null){
                return onSelected?.call(groupValue as T);
              }
              onSelected?.call(value as T);
            },
          ),
          widget,
        ],
      ),
    );
  }
}

class RadioBoxModel<T, T2> extends Equatable {
  const RadioBoxModel({
    required this.data,
    required this.displayName,
    required this.remoteValue,
  });

  final T data;
  final String displayName;
  final T2 remoteValue;

  @override
  List<Object?> get props => [data, displayName];
}
