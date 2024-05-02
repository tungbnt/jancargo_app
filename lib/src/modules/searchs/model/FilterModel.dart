// import 'package:flutter/material.dart';
//
// import '../../../components/resource/molecules/radio_button.dart';
//
//
// class FilterModelForView {
//    List<RadioBoxModel<Map<String, dynamic>>> filterList;
//   ValueNotifier<bool> isShowFilter = ValueNotifier(false);
//   String filterName = "";
//   String type = "";
//   int id = 0;
//
//   FilterModelForView(this.filterList);
//   String getSelectedParams() {
//     final idSelectedList = filterList.where((element) => element.status.value).map((e) => e.data!['id']).toList();
//     return idSelectedList.isEmpty ? "" : "${id}_${idSelectedList.join(', ')}";
//   }
//
//   getSelectedFilterName() {
//     final filledCategory = filterList.where((element) => element.status.value).map((e) => e.data!["name"]);
//     return filledCategory;
//   }
//
//   clearFilter() {
//     for (var element in filterList) {
//       element.status.value = false;
//     }
//   }
//
//   void selectFilter(int index) => filterList[index].status.value = !filterList[index].status.value;
// }
