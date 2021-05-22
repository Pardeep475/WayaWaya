import 'package:flutter/material.dart';
import 'package:wayawaya/screens/rewards/menu_button.dart';
import '../settings.dart';
import '../../config.dart';
import '../../constants.dart';
import 'package:wayawaya/widgets/custom_app_bar.dart';
import '../login.dart';
import '../search_page.dart';

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
      height: 50,
      color: white,
      width: App.width(context),
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
                    backgroundColor: white,
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
                  setState(() {
                    showSearch = false;
                  });
                  FocusScope.of(context).unfocus();
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => SearchPage(
                            searchTerm: _searchController.text,
                          ),
                        ),
                      )
                      .whenComplete(() => _searchController.clear());
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          height: App.height(context),
          width: App.width(context),
          color: bgColor,
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
                              EdgeInsets.only(left: 0, top: 16),
                          titleSize: widget.titleSize ?? 14,
                          onSnowTap: widget.onSnowTap ??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => Login()),
                                  ),
                          onSettingsTap: widget.onSettingsTap ??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Settings()),
                                  ),
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
                    // ..._children,

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
