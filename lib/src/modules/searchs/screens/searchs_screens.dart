import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/all_search/all_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_all/search_all_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_amazon_js/search_amazon_js_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_amazon_us/search_amazon_us_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_auction/search_auction_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_mercari/search_mercari_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_paypay/search_paypay_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_rakuten/search_rakuten_page.dart';
import 'package:jancargo_app/src/modules/searchs/screens/search_yahoo_shopping/search_yahoo_shopping_page.dart';
import 'package:jancargo_app/src/modules/searchs/widget/item_store_name.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_storage.dart';

class SearchsScreens extends StatefulWidget {
  const SearchsScreens({super.key,  this.category, this.categoryId, this.indexTab = 0,  this.keyWord,  this.title = "Tìm kiếm"});
  final String? category;
  final String? categoryId;
  final int? indexTab;
  final String? keyWord;
  final String title;
  @override
  State<SearchsScreens> createState() => _SearchsScreensState();
}

class _SearchsScreensState extends State<SearchsScreens> {
  final AllSearchCubit _cubit = AllSearchCubit();
  ValueNotifier<int> current = ValueNotifier(0);
  late String? keyWord;
  late int? oldCurrent;
  @override
  void initState() {
    super.initState();
    indexTab();
  }


  Future<int> indexTab()async{
    
    ///gắn keyword
    keyWord = widget.keyWord;
    
    if(widget.indexTab == null && widget.category == ""){
      return current.value = 0;
    }else if(widget.category != ""){
      return current.value = 1;
    }else {
      oldCurrent = widget.indexTab!;
      return current.value = widget.indexTab!;
    }
  }

  String _titleSearch(String category,){
    String? title;
    if(category.isNotEmpty && current.value == 1){

      title = category;
    }else if(current.value != 0){
      String storeName = AppStorage.items[current.value]['text'];
      title = 'Tìm kiếm $storeName';
    }
    return title ?? 'Tìm kiếm';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow800Color,
        centerTitle: true,
        leading: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => Future.delayed(Duration.zero, () {
            RouteService.pop();
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: ValueListenableBuilder(
          valueListenable: current,
          builder: (BuildContext context, value, Widget? child) {
            return Text(widget.category!.isNotEmpty ? _titleSearch(widget.category!) : widget.title,style: AppStyles.text7018(color: AppColors.black03),);
          },
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.neutral200Color,
      body: BlocListener<AllSearchCubit, AllSearchState>(
        bloc: _cubit,
        listenWhen: (prv,state)=> state is AllSearchChangeTab,
        listener: (BuildContext context, state) {
          if(state is AllSearchChangeTab){
            current.value = state.currentTab!;
          }
        },
        child: CustomScrollView(
          slivers: [
            _stores(),
            _tabsSearch(),
          ],
        ),
      ),
    );
  }

  Widget _stores() => SliverToBoxAdapter(
        child: ItemStoreName(
          current: current,
          getIndex: (int currentIndex){
            // /// clear keywword when navigator data from home
            if(oldCurrent != currentIndex){
              keyWord = '';
              print('widget.keyWord ${keyWord}');

            }
           setState(() {

           });
          },
        ),
      );

  Widget _tabsSearch() => ValueListenableBuilder(
      valueListenable: current,
      builder: (BuildContext context, value, Widget? child) {



        String storeName = AppStorage.items[current.value]['text'];
        switch(storeName){
          case 'Tất cả': return SearchAllPage(keyWord: keyWord ?? "",cubit: _cubit,);
          case 'Mercari': return SearchMercariPage(keyWord: keyWord ?? "",);
          case 'Rakuten': return SearchRakutenPage(keyWord: keyWord ?? "",);
          case 'Paypay Fleamarket': return SearchPayPayPage(keyWord: keyWord ?? "",);
          case 'Amazon JS': return SearchAmazonJsPage(keyWord: keyWord ?? "",);
          case 'Amazon US': return SearchAmazonUsPage(keyWord: keyWord ?? "",);
          case 'Yahoo! Shopping': return SearchYahooShoppingPage(keyWord: keyWord ?? "",);
          case 'Yahoo! Auction': return SearchAuctionPage(category: widget.category ?? '',categoryId: widget.categoryId ?? "",keyWord: keyWord ?? "",);

          default: return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      });
}
