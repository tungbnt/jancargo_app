import 'package:flutter/material.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.onChange, this.controller});
  final ValueSetter<String> onChange;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return FieldSearch(
      onChange: onChange,
      controller: controller,
    );
  }
}