import 'package:flutter/material.dart';
import 'package:wayawaya/app/search/bloc/search_bloc.dart';
import 'package:wayawaya/app/search/model/global_app_search.dart';
import 'package:wayawaya/app/search/views/event_item_view.dart';
import 'package:wayawaya/app/search/views/no_data_found_view.dart';
import 'package:wayawaya/utils/utils.dart';

class SearchEvents extends StatefulWidget {
  final String searchQuery;

  const SearchEvents({Key key, this.searchQuery}) : super(key: key);

  @override
  _SearchEventsState createState() => _SearchEventsState();
}

class _SearchEventsState extends State<SearchEvents> {
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
    debugPrint('pardeep_search_testing:-   all Search  ${widget.searchQuery}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchBloc.getEventSearchItems(widget.searchQuery ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: StreamBuilder<List<GlobalAppSearch>>(
          initialData: [],
          stream: _searchBloc.eventStream,
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
                  return EventItemView(
                    globalAppSearch: snapshot.data[index],
                  );
                },
              );
            }
          }),
    );
  }
}
