import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/search/bloc/search_bloc.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/app/search/views/no_data_found_view.dart';
import 'package:wayawaya/app/search/views/shop_item_view.dart';
import 'package:wayawaya/screens/search_details.dart';
import 'package:wayawaya/utils/utils.dart';
import '../constants.dart';

class SearchShops extends StatefulWidget {
  final String searchQuery;

  const SearchShops({Key key, this.searchQuery}) : super(key: key);

  @override
  _SearchShopsState createState() => _SearchShopsState();
}

class _SearchShopsState extends State<SearchShops> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
    debugPrint('pardeep_search_testing:-   all Search  ${widget.searchQuery}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchBloc.getShopSearchItems(widget.searchQuery ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: StreamBuilder<List<GlobalAppSearch>>(
          initialData: [],
          stream: _searchBloc.shopStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              Future.delayed(Duration(milliseconds: 200), () {
                Utils.commonProgressDialog(context);
              });
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
              );
            } else if (snapshot.data.isEmpty) {
              return StreamBuilder<bool>(
                  initialData: false,
                  stream: _searchBloc.noDataFoundStream,
                  builder: (context, snapshot) {
                    if (snapshot.data) {
                      return SizedBox();
                    }
                    return GestureDetector(
                      onTap: () {
                        _searchBloc.noDataFoundSink.add(true);
                      },
                      child: NoDataFoundView(),
                    );
                  });
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                key: PageStorageKey('rest'),
                itemBuilder: (_, index) {
                  return ShopItemView(
                    globalAppSearch: snapshot.data[index],
                  );
                },
              );
            }
          }),
    );
  }
}
