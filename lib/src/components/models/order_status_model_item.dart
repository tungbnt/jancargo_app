import 'package:flutter/widgets.dart';

import 'option_model_item.dart';


class OrderStatusModelItem extends OptionModelItem {
  final ValueNotifier<int>? count;

  const OrderStatusModelItem({
    required super.titleLangKey,
    required super.icon,
    this.count,
  });
}

class OrderStatusModelActionItem extends OrderStatusModelItem {
  final VoidCallback onTap;

  const OrderStatusModelActionItem({
    required super.titleLangKey,
    required super.icon,
    required this.onTap,
    super.count,
  });
}
