import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/widgets/custom_app_bar.dart';

///SEARCH PAGE & SHOP DOESN'T USE THIS CLASS

class MenuNew extends StatefulWidget {
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
  final List<Widget> normalChildren;
  @required
  final List<Widget> children;

  MenuNew(
      {this.title,
      this.children,
      this.onSnowTap,
      this.onSettingsTap,
      this.onSearchTap,
      this.padding,
      this.lastIcon,
      this.bottom,
      this.floating,
      this.pinned,
      this.snap,
      this.physics,
      this.isSliver = true,
      this.normalChildren,
      this.centerTitle,
      this.titleSize});

  @override
  _MenuNewState createState() => _MenuNewState();
}

class _MenuNewState extends State<MenuNew> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController;
  List<Widget> _children;
  bool showMenuIcon = true;
  bool showSearch = false;

  @override
  void initState() {
    if (widget.isSliver == true) {
      setState(() {
        _children = widget.children;
      });
    } else {
      setState(() {
        _children = widget.normalChildren;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  searchBar() {
    return Container(
      height: Dimens.fifty,
      color: AppColor.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ///Back Button
          InkWell(
            onTap: () {
              setState(() {
                showSearch = false;
              });
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
                    radius: Dimens.twenty,
                    foregroundImage: AssetImage(
                      AppImages.menu_app_ic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: Dimens.hundred,
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  setState(() {
                    showSearch = false;
                  });
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(context, AppString.SEARCH_SCREEN_ROUTE,
                          arguments: _searchController.text)
                      .whenComplete(() => _searchController.clear());
                },
                controller: _searchController,
                cursorHeight: Dimens.twentyFive,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: Dimens.two),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: Dimens.eighteen,
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
                        MyAppBar(
                          title: widget.title,
                          centerTitle: widget.centerTitle ?? false,
                          padding: widget.padding ??
                              EdgeInsets.only(left: 0, top: Dimens.sixteen),
                          titleSize: widget.titleSize ?? Dimens.forteen,
                          onSnowTap: widget.onSnowTap ??
                              () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppString.LOGIN_SCREEN_ROUTE,
                                  (route) => false),
                          onSettingsTap: widget.onSettingsTap ??
                              () => Navigator.pushNamed(
                                  context, AppString.SETTINGS_SCREEN_ROUTE),
                          onSearchTap: widget.onSearchTap ??
                              () {
                                setState(() {
                                  showSearch = true;
                                });
                              },
                        ),
                        ..._children,
                      ],
                    ),

                    ///SEARCH
                    Align(
                      alignment: Alignment.topCenter,
                      child: Visibility(
                        visible: showSearch,
                        child: searchBar(),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    ///SEARCH
                    Align(
                      alignment: Alignment.topCenter,
                      child: Visibility(
                        visible: showSearch,
                        child: searchBar(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
