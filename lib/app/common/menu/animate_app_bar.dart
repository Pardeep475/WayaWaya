import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/bloc/animate_app_bar_widget_bloc.dart';
import 'package:wayawaya/app/common/menu/custom_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/utils/app_color.dart';

class AnimateAppBar extends StatefulWidget {
  @required
  final String title;
  final bool isSliver;
  final Function onSnowTap;
  final Function onSettingsTap;
  final Function onSearchTap;
  final EdgeInsets padding;
  final IconButton lastIcon;
  final PreferredSizeWidget bottom;
  final ScrollPhysics physics;
  final double titleSize;
  final bool centerTitle;
  final bool floating;
  final bool pinned;
  final bool snap;
  @required
  final List<MainMenuPermission> mainMenuPermissions;
  @required
  final List<Widget> children;

  AnimateAppBar(
      {this.title,
      this.isSliver,
      this.onSnowTap,
      this.onSettingsTap,
      this.onSearchTap,
      this.padding,
      this.lastIcon,
      this.bottom,
      this.physics,
      this.titleSize,
      this.centerTitle,
      this.floating,
      this.pinned,
      this.snap,
      this.mainMenuPermissions,
      this.children});

  @override
  State<StatefulWidget> createState() => _AnimateAppBarState();
}

class _AnimateAppBarState extends State<AnimateAppBar> {
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController;
  bool showMenuIcon = true;
  bool showSearch = false;

  AnimateAppBarWidgetBloc _animateAppBarWidgetBloc;

  @override
  void initState() {
    _animateAppBarWidgetBloc = AnimateAppBarWidgetBloc();
    super.initState();
  }

  searchBar() {
    return Container(
      height: 50,
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ///Back Button
          InkWell(
            onTap: () {
              _animateAppBarWidgetBloc.searchSink.add(false);
              FocusScope.of(context).unfocus();
              _searchController.clear();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColor.white,
                    radius: 20,
                    foregroundImage: AssetImage(
                      'assets/menu_app_ic.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  _animateAppBarWidgetBloc.searchSink.add(false);
                  FocusScope.of(context).unfocus();
                  // Navigator.of(context)
                  //     .push(
                  //       MaterialPageRoute(
                  //         builder: (_) => SearchPage(
                  //           searchTerm: _searchController.text,
                  //         ),
                  //       ),
                  //     )
                  //     .whenComplete(() => _searchController.clear());
                },
                controller: _searchController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('animate_app_bar_testing:-  ${widget.isSliver}');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[100],
          child: widget.isSliver
              ? Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      physics: widget.physics ?? BouncingScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        CustomAppBar(
                          title: widget.title,
                          pinned: widget.pinned ?? false,
                          snap: widget.snap ?? false,
                          floating: widget.floating ?? false,
                          centerTitle: widget.centerTitle ?? false,
                          padding: widget.padding ?? EdgeInsets.only(left: 0, top: 16),
                          titleSize: widget.titleSize ?? 16,
                          mainMenuPermissionList: widget.mainMenuPermissions,
                          onSnowTap: widget
                              .onSnowTap /*??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => Login()),
                                  )*/
                          ,
                          onSettingsTap: widget
                              .onSettingsTap /*??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Settings()),
                                  )*/
                          ,
                          onSearchTap: widget.onSearchTap ??
                              () {
                                _animateAppBarWidgetBloc.searchSink.add(true);
                                // setState(() {
                                //   showSearch = true;
                                // });
                              },
                        ),
                        ...widget.children ?? [],
                      ],
                    ),

                    ///SEARCH
                    Align(
                      alignment: Alignment.topCenter,
                      child: StreamBuilder<bool>(
                          initialData: false,
                          stream: _animateAppBarWidgetBloc.searchStream,
                          builder: (context, snapshot) {
                            if (snapshot.data) {
                              return searchBar();
                            } else {
                              return SizedBox();
                            }
                          }),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    ///SEARCH
                    Align(
                      alignment: Alignment.topCenter,
                      child: StreamBuilder<bool>(
                          initialData: false,
                          stream: _animateAppBarWidgetBloc.searchStream,
                          builder: (context, snapshot) {
                            if (snapshot.data) {
                              return searchBar();
                            } else {
                              return SizedBox();
                            }
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
