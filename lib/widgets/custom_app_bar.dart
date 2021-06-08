import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/screens/rewards/menu_button.dart';
import 'package:wayawaya/screens/select_def_mall.dart';
import 'package:wayawaya/screens/settings.dart';
import '../constants.dart';

class MyAppBar extends StatefulWidget {
  final Function onSnowTap;
  final Function onSettingsTap;
  final Function onSearchTap;
  final EdgeInsets padding;
  final IconButton lastIcon;
  final PreferredSizeWidget bottom;
  final double titleSize;
  final bool isSliver;
  final bool centerTitle;
  final bool floating;
  final bool pinned;
  final bool snap;
  final List<MainMenuPermission> mainMenuPermissionList;
  @required
  final String title;

  const MyAppBar({
    this.onSnowTap,
    this.onSettingsTap,
    this.onSearchTap,
    this.title,
    this.padding,
    this.lastIcon,
    this.floating,
    this.snap,
    this.bottom,
    this.pinned,
    this.centerTitle,
    this.titleSize,
    this.mainMenuPermissionList,
    this.isSliver = true,
  });

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String _loggedIn;
  String _selectedMall;

  getMallLogo() {
    _selectedMall = 'Dobsonville Mall';
    print(_selectedMall);
    switch (_selectedMall) {
      case 'Dobsonville Mall':
        return 'assets/dobsonville.png';
      case 'Hillfox Value Centre':
        return 'assets/hillfox.png';
      case 'Durban Workshop':
        return 'assets/durban.png';
      case 'Randburg Square Centre':
        return 'assets/randburg.png';
      case 'Atlantis City':
        return 'assets/atlantis.png';
      case 'Hammarsdale Junction':
        return 'assets/hammarsdale.png';
      case 'Kolonnade Retail Park':
        return 'assets/kolonnade.png';
      case 'Bloemfontein Plaza':
        return 'assets/bloemfontein.png';
      case 'Gugulethu Square':
        return 'assets/gugulethu.png';
      case 'Mdantsane City Shopping Centre':
        return 'assets/mdantsane.png';
      case 'Pine Crest Centre':
        return 'assets/pinecrest.png';
      case 'Nonesi Mall':
        return 'assets/nonesi.png';
    }
  }

  @override
  void initState() {
    super.initState();
    _loggedIn = 'Pardeep Kumar';
    _selectedMall = 'Dobsonville Mall';
    getMallLogo();
    print(_loggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSliver
        ? SliverAppBar(
            backgroundColor: Colors.grey[700],
            automaticallyImplyLeading: false,
            expandedHeight: 58,
            floating: widget.floating ?? false,
            pinned: widget.pinned ?? false,
            snap: widget.snap ?? false,
            centerTitle: widget.centerTitle ?? false,
            leading: MenuTile(itemList: widget.mainMenuPermissionList),
            title: Container(
              height: 58,
              child: Padding(
                padding: widget.padding ??
                    const EdgeInsets.only(
                        left: 70, top: 20, bottom: 20, right: 20),
                child: Text(
                  widget.title,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: widget.titleSize ?? 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            actions: [
              _loggedIn == null
                  ? InkWell(
                      child: Icon(
                        Icons.ac_unit_rounded,
                        color: appLightColor,
                      ),
                      onTap: widget.onSnowTap ?? () {},
                    )
                  : const SizedBox(),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: appLightColor,
                ),
                onPressed: widget.onSettingsTap ??
                    () => App.pushTo(context: context, screen: Settings()),
              ),
              widget.lastIcon ??
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: appLightColor,
                    ),
                    onPressed: widget.onSearchTap ?? () {},
                  ),
              _loggedIn != null
                  ? InkWell(
                      onTap: () => App.pushTo(
                          context: context,
                          screen: SelectMall(
                            onlyChangeMall: true,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: appLightColor,
                          foregroundImage: AssetImage(
                            getMallLogo().toString(),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
            bottom: widget.bottom ?? null,
          )
        : AppBar(
            backgroundColor: Colors.grey[700],
            automaticallyImplyLeading: false,
            centerTitle: widget.centerTitle ?? false,
            title: Container(
              height: 58,
              child: Padding(
                padding: widget.padding ??
                    EdgeInsets.only(left: 70, top: 20, bottom: 20, right: 20),
                child: Text(
                  widget.title,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: widget.titleSize ?? 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            actions: [
              _loggedIn == null
                  ? InkWell(
                      child: Icon(
                        Icons.ac_unit_rounded,
                        color: appLightColor,
                      ),
                      onTap: widget.onSnowTap ?? () {},
                    )
                  : Container(),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: appLightColor,
                ),
                onPressed: widget.onSettingsTap ?? () {},
              ),
              widget.lastIcon ??
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: appLightColor,
                    ),
                    onPressed: widget.onSearchTap ?? () {},
                  ),
              _loggedIn != null
                  ? InkWell(
                      onTap: () =>
                          App.pushTo(context: context, screen: SelectMall()),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 5),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: appLightColor,
                          foregroundImage: AssetImage(
                            getMallLogo().toString(),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
            bottom: widget.bottom ?? null,
          );
  }
}
