import 'package:flutter/material.dart';
import 'package:wayawaya/app/search/bloc/search_bloc.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/app/search/views/event_item_view.dart';
import 'package:wayawaya/app/search/views/no_data_found_view.dart';
import 'package:wayawaya/app/search/views/offer_item_view.dart';
import 'package:wayawaya/app/search/views/restaurant_item_view.dart';
import 'package:wayawaya/app/search/views/shop_item_view.dart';
import 'package:wayawaya/utils/utils.dart';

class SearchAll extends StatefulWidget {
  final String searchQuery;

  const SearchAll({Key key, this.searchQuery}) : super(key: key);

  @override
  _SearchAllState createState() => _SearchAllState();
}

class _SearchAllState extends State<SearchAll> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
    debugPrint('pardeep_search_testing:-   all Search  ${widget.searchQuery}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchBloc.getSearchItems(widget.searchQuery ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: StreamBuilder<List<GlobalAppSearch>>(
          initialData: [],
          stream: _searchBloc.allSearchStream,
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
                  // activity
                  // cinema
                  // whatson
                  switch (snapshot.data[index].type) {
                    case "restaurant":
                      {
                        return RestaurantItemView(
                          globalAppSearch: snapshot.data[index],
                        );
                      }
                    case "shop":
                      {
                        return ShopItemView(
                          globalAppSearch: snapshot.data[index],
                        );
                      }
                    case "event":
                      {
                        return EventItemView(
                          globalAppSearch: snapshot.data[index],
                        );
                      }
                    case "offer":
                      {
                        return OfferItemView(
                          globalAppSearch: snapshot.data[index],
                        );
                      }
                    default:
                      {
                        return ShopItemView(
                          globalAppSearch: snapshot.data[index],
                        );
                      }
                  }
                },
              );
            }
          }),
    );
  }
}
