import 'package:flutter/foundation.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/service_extras/service_extras_dto.dart';

import '../../../domain/dtos/user/warehouse/warehouse_dto.dart';

class PaymentOrderItem {
  PaymentOrderItem(this.cartItem);

  final ItemCartDto cartItem;
  final ValueNotifier<List<ItemsServiceExtrasDto>> selectedServiceExtras = ValueNotifier([]);
  final ValueNotifier<ShipModeDto?> selectedShipMethod = ValueNotifier<ShipModeDto?>(null);

  bool isServiceExtraSelected(ItemsServiceExtrasDto serviceExtra) {
    return selectedServiceExtras.value.any((e) => e.code == serviceExtra.code);
  }

  void toogleServiceExtraSelection(ItemsServiceExtrasDto serviceExtra) {
    final code = serviceExtra.code;

    if (code == null || code.isEmpty) {
      return;
    }

    final childCodes = serviceExtra.childCode?.toSet() ?? const {};

    final selectedServiceExtras = List.of(this.selectedServiceExtras.value);

    final selectedCodes = selectedServiceExtras.map((e) => e.code).whereType<String>().toSet();

    if (selectedCodes.contains(code)) {
      selectedServiceExtras.remove(serviceExtra);
    } else {
      // nếu hiện tại đang chọn gói nâng cao thì phải bỏ nó đi
      // ko thì sẽ có cả gói nâng cao + dịch vụ khác
      final bool isAdvancedServiceExtra = selectedServiceExtras.any((e) => e.childCode?.isNotEmpty == true);

      if (isAdvancedServiceExtra) {
        selectedServiceExtras.clear();
      } else if (childCodes.isNotEmpty) {
        // Đây là 1 gói nâng cao
        //     hoặc là 1 gói có chứa mã con
        selectedServiceExtras.clear();
      }

      selectedServiceExtras.add(serviceExtra);
    }

    this.selectedServiceExtras.value = selectedServiceExtras;
  }

  int getTotalPriceForCodes(List<ItemsServiceExtrasDto> items,) {
    int totalPrice = 0;
    for (var item in items) {
      totalPrice += item.price ?? 0;
    }
    return totalPrice;
  }


}
