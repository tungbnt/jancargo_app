import 'package:flutter/material.dart';
import 'package:jancargo_app/src/modules/search/components/tab_screen/marcari_search.dart';
import 'package:jancargo_app/src/modules/search/components/tab_screen/rakuten_search.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.storeName});

  final String storeName;

  @override
  Widget build(BuildContext context) {
    return switch (storeName) {
      'Rakuten' => SearchRakutenResult(),
      'Mercari' => SearchMarcariResult(nameStore: storeName,),
      _ => Container(),
    };
  }
}
