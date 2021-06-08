import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/dialogs/common_login_dialog.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/common/model/categories_model.dart';
import 'package:wayawaya/screens/rewards/menu_button.dart';
import 'package:wayawaya/screens/select_def_mall.dart';
import 'package:wayawaya/screens/settings.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

import '../../../config.dart';
import '../../../constants.dart';
import 'bloc/custom_app_bar_bloc.dart';

class CustomAppBar extends StatefulWidget {
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
  @required
  final List<MainMenuPermission> mainMenuPermissionList;
  @required
  final String title;

  CustomAppBar(
      {this.onSnowTap,
      this.onSettingsTap,
      this.onSearchTap,
      this.padding,
      this.lastIcon,
      this.bottom,
      this.titleSize,
      this.isSliver = true,
      this.centerTitle,
      this.floating,
      this.pinned,
      this.snap,
      this.mainMenuPermissionList,
      this.title});

  @override
  State<StatefulWidget> createState() {
    return _CustomAppBarState();
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _loggedIn;
  String _selectedMall;
  CustomAppBarBloc _customAppBarBloc;

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
    _customAppBarBloc = CustomAppBarBloc();
    super.initState();
    _loggedIn = 'Pardeep Kumar';
    _selectedMall = 'Dobsonville Mall';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProfileCategories();
    });
  }

  getProfileCategories() async {
    _customAppBarBloc.getProfileCategories();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('animate_app_bar_testing:-  ${widget.title}');
    return StreamBuilder<List<Category>>(
        initialData: [],
        stream: _customAppBarBloc.profileCategoryStream,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return SliverAppBar(
              backgroundColor: Colors.grey[800],
              automaticallyImplyLeading: false,
              expandedHeight: 58,
              floating: widget.floating ?? false,
              pinned: widget.pinned ?? false,
              snap: widget.snap ?? false,
              centerTitle: widget.centerTitle ?? false,
              leading: MenuTile(itemList: widget.mainMenuPermissionList),
              title: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: widget.titleSize ?? 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                _loggedIn == null
                    ? InkWell(
                        child: Icon(
                          Icons.ac_unit_rounded,
                          color: appLightColor,
                          size: 24,
                        ),
                        onTap: widget.onSnowTap ?? () {},
                      )
                    : const SizedBox(),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: appLightColor,
                    size: 34,
                  ),
                  onPressed: widget.onSettingsTap ?? _onSettingsButtonClick,
                ),
                widget.lastIcon ??
                    IconButton(
                      padding: EdgeInsets.only(left: 25, right: 20),
                      icon: Icon(
                        Icons.search,
                        color: appLightColor,
                        size: 34,
                      ),
                      onPressed: widget.onSearchTap ?? () {},
                    ),
                _loggedIn != null
                    ? InkWell(
                        onTap: () => _onMallSelection(),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
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
            );
          } else {
            return widget.isSliver
                ? SliverAppBar(
                    backgroundColor: Colors.grey[800],
                    automaticallyImplyLeading: false,
                    expandedHeight: 58,
                    floating: widget.floating ?? false,
                    pinned: widget.pinned ?? false,
                    snap: widget.snap ?? false,
                    centerTitle: widget.centerTitle ?? false,
                    leading: MenuTile(itemList: widget.mainMenuPermissionList),
                    title: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: widget.titleSize ?? 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: [
                      _loggedIn == null
                          ? InkWell(
                              child: Icon(
                                Icons.ac_unit_rounded,
                                color: appLightColor,
                                size: 24,
                              ),
                              onTap: widget.onSnowTap ?? () {},
                            )
                          : const SizedBox(),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: appLightColor,
                          size: 34,
                        ),
                        onPressed:
                            widget.onSettingsTap ?? _onSettingsButtonClick,
                      ),
                      widget.lastIcon ??
                          IconButton(
                            padding: EdgeInsets.only(left: 25, right: 20),
                            icon: Icon(
                              Icons.search,
                              color: appLightColor,
                              size: 34,
                            ),
                            onPressed: widget.onSearchTap ?? () {},
                          ),
                      _loggedIn != null
                          ? InkWell(
                              onTap: () => _onMallSelection(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: StreamBuilder<String>(
                                    initialData: null,
                                    stream: _customAppBarBloc
                                        .identifierCategoryStream,
                                    builder: (context, snapshot) {
                                      return CircleAvatar(
                                        radius: 20,
                                        backgroundColor: appLightColor,
                                        child: snapshot.data == null
                                            ? Image.asset(
                                                'assets/image/ic_launcher_bdd45df0be5d4891bcfa25eddf44aa86.png')
                                            : Image.asset(
                                                'assets/image/ic_launcher_${snapshot.data}.png'),
                                      );
                                    }),
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
                            EdgeInsets.only(
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
                          : Container(),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: appLightColor,
                        ),
                        onPressed:
                            widget.onSettingsTap ?? _onSettingsButtonClick,
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
                              onTap: () => _onMallSelection(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
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
        });
  }

  _onMallSelection() {
    debugPrint('mall_selection_screen:-  _onMallSelection ');
    Navigator.pushNamed(context, AppString.MALL_SCREEN_ROUTE);
  }

  _onSettingsButtonClick() async {
    bool isLogin = await SessionManager.isLogin();
    if (isLogin != null && isLogin) {
      Navigator.pushNamed(context, AppString.SETTINGS_SCREEN_ROUTE);
    } else {
      _showErrorDialog(
        icon: Icon(
          FontAwesomeIcons.exclamationTriangle,
          color: AppColor.orange_500,
        ),
        title: AppString.login.toUpperCase(),
        content: AppString.currently_not_logged_in,
        buttonText: AppString.login.toUpperCase(),
        onPressed: () =>
            Navigator.pushNamed(context, AppString.LOGIN_SCREEN_ROUTE),
      );
    }
  }

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonLoginDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
