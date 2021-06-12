import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/dialogs/common_login_dialog.dart';
import 'package:wayawaya/app/common/dialogs/common_login_with_home_page.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/preferences/bloc/select_preferences_bloc.dart';
import 'package:wayawaya/app/preferences/model/currency_model.dart';
import 'package:wayawaya/app/preferences/model/language_model.dart';
import 'package:wayawaya/app/preferences/model/notification_model.dart';
import 'package:wayawaya/app/preferences/view/category_preferences.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';
import 'package:wayawaya/widgets/fav_malls.dart';

import '../../config.dart';
import '../../constants.dart';
import 'model/preferences_categories.dart';

class SelectPreferencesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectPreferencesScreenState();
}

class _SelectPreferencesScreenState extends State<SelectPreferencesScreen> {
  bool _lang = true;
  bool showMalls = false;

  TextStyle _title = GoogleFonts.encodeSansCondensed().copyWith(
    color: black.withOpacity(1),
    fontWeight: FontWeight.w400,
    letterSpacing: 1.1,
    fontSize: 19,
  );
  TextStyle _content = TextStyle(
    color: Colors.grey[600],
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  getMallName(int index) {
    switch (index) {
      case 0:
        return 'Dobsonville';
      case 1:
        return 'Hillfox Value Centre';
      case 2:
        return 'Durban Workshop';
      case 3:
        return 'Randburg Square Centre';
      case 4:
        return 'Atlantis City';
      case 5:
        return 'Hammarsdale Junction';
      case 6:
        return 'Kolonnade Retail Park';
      case 7:
        return 'Bloemfontein Plaza';
      case 8:
        return 'Gugulethu Square';
      case 9:
        return 'Mdantsane City Shopping Centre';
      case 10:
        return 'Pine Crest Centre';
      case 11:
        return 'Nonesi Mall';
    }
  }

  getMallLogo(int index) {
    switch (index) {
      case 0:
        return 'assets/dobsonville.png';
      case 1:
        return 'assets/hillfox.png';
      case 2:
        return 'assets/durban.png';
      case 3:
        return 'assets/randburg.png';
      case 4:
        return 'assets/atlantis.png';
      case 5:
        return 'assets/hammarsdale.png';
      case 6:
        return 'assets/kolonnade.png';
      case 7:
        return 'assets/bloemfontein.png';
      case 8:
        return 'assets/gugulethu.png';
      case 9:
        return 'assets/mdantsane.png';
      case 10:
        return 'assets/pinecrest.png';
      case 11:
        return 'assets/nonesi.png';
    }
  }

  successDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        content: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'Your preferences saved successfully.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        'HOMEPAGE',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        // App.prefs
                        //     .setBool('homeGestures', true)
                        //     .whenComplete(() => App.pushTo(
                        //   context: context,
                        //   screen: HomeScreen(),
                        // ));
                      },
                    ),
                    TextButton(
                      child: Text(
                        'SETTINGS',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        // App.pushTo(context: context, screen: Settings());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SelectPreferencesBloc _selectPreferencesBloc;

  @override
  void initState() {
    super.initState();

    _selectPreferencesBloc = SelectPreferencesBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _selectPreferencesBloc.getPreferencesCategories();
      _selectPreferencesBloc.getMallData();
      _selectPreferencesBloc.getNotificationData(context);
    });
  }

  void changedDropDownItem(NotificationModel selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    _selectPreferencesBloc.notificationSink.add(selectedCity);
    _currentNotification = selectedCity.title;
  }

  _updateValues({int pos, MallProfileModel mallProfileModel, bool selected}) {
    debugPrint(
        'updated_mall_data_testing:-  index  $pos  active  ${mallProfileModel.active}  selected:-  $selected');
    _selectPreferencesBloc.updateItemMallList(pos, mallProfileModel, selected);
  }

  String _currentNotification = "12 daily";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            AnimateAppBar(
              title: AppString.preferences.toUpperCase(),
              isSliver: true,
              floating: true,
              pinned: true,
              physics: RangeMaintainingScrollPhysics(),
              snap: true,
              onSnowTap: () {
                setState(() {
                  debugPrint('animation_click_testing:-   menu click');
                  showMalls = true;
                });
              },
              children: [
                SliverToBoxAdapter(
                  child: StreamBuilder<List<PreferencesCategory>>(
                      initialData: null,
                      stream: _selectPreferencesBloc.categoriesStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SizedBox();
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppString.interested_categories,
                                style: _title,
                              ),
                              ListView.builder(
                                itemCount: snapshot.data.length,
                                padding: EdgeInsets.only(top: 15),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return CategoryPreferences(
                                    preferencesCategory: snapshot.data[index],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<NotificationModel>(
                      initialData: null,
                      stream: _selectPreferencesBloc.notificationStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SizedBox();
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppString.notification_frequency,
                                style: _title,
                              ),
                              DropdownButton(
                                underline: SizedBox(),
                                isExpanded: true,
                                value: snapshot.data,
                                items: _selectPreferencesBloc.getDropDownItems,
                                onChanged: (notificationData) {
                                  changedDropDownItem(notificationData);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<List<MallProfileModel>>(
                      initialData: [],
                      stream: _selectPreferencesBloc.mallProfileStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SizedBox();
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppString.favourite_malls,
                                style: _title,
                              ),
                              ListView.builder(
                                itemCount: snapshot.data.length,
                                padding: EdgeInsets.only(top: 10),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return FavMall(
                                    index: index,
                                    mallProfileModel: snapshot.data[index],
                                    onPressed: _updateValues,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<List<CurrencyModel>>(
                      initialData: null,
                      stream: _selectPreferencesBloc.currencyStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SizedBox();
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppString.alternate_currency,
                                style: _title,
                              ),
                              ListView.builder(
                                itemCount: snapshot.data.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return _itemCurrencyWidget(
                                      snapshot.data[index]);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<List<LanguageModel>>(
                      initialData: null,
                      stream: _selectPreferencesBloc.languageStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SizedBox();
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppString.default_language,
                                style: _title,
                              ),
                              ListView.builder(
                                itemCount: snapshot.data.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return _itemLanguageWidget(
                                      snapshot.data[index]);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: App.width(context),
                    margin: EdgeInsets.only(bottom: 3),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            // onTap: () => successDialog(),
                            child: Card(
                              shadowColor: Colors.grey[400],
                              child: Container(
                                height: 50,
                                width: App.width(context) / 2.3,
                                child: Center(
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _cancelButtonPressed();
                            },
                            child: Card(
                              shadowColor: Colors.grey[400],
                              child: Container(
                                height: 50,
                                width: App.width(context) / 2.3,
                                child: Center(
                                  child: Text(
                                    AppString.cancel.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // MALL OPTIONS
            // Visibility(
            //   visible: showMalls,
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         showMalls = false;
            //       });
            //     },
            //     child: Container(
            //       height: App.height(context),
            //       width: App.width(context),
            //       color: Colors.black.withOpacity(0.45),
            //       alignment: Alignment.center,
            //       child: GridView.builder(
            //         itemCount: 12,
            //         shrinkWrap: true,
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         physics: NeverScrollableScrollPhysics(),
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 3, mainAxisSpacing: 10),
            //         itemBuilder: (BuildContext context, int index) {
            //           return InkWell(
            //             onTap: () => print('Go to Mall'),
            //             child: Container(
            //               height: 150,
            //               width: 100,
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Container(
            //                     decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       boxShadow: [
            //                         BoxShadow(
            //                           blurRadius: 10,
            //                           color: Colors.black38,
            //                           spreadRadius: 5,
            //                         ),
            //                       ],
            //                     ),
            //                     child: CircleAvatar(
            //                       backgroundColor: appLightColor,
            //                       radius: 36,
            //                       child: Image.asset(
            //                         getMallLogo(index),
            //                         height: 50,
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     height: 30,
            //                     child: Center(
            //                       child: Text(
            //                         getMallName(index),
            //                         style: TextStyle(
            //                           color: white,
            //                           fontSize: 12,
            //                         ),
            //                         overflow: TextOverflow.clip,
            //                         textAlign: TextAlign.center,
            //                         maxLines: 1,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _cancelButtonPressed() async {
    bool isLogin = await SessionManager.isLogin();
    if (isLogin) {
      Navigator.pop(context);
    } else {
      _showLoginDialog(
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

  _showLoginDialog(
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
              child: CommonLoginWithHomePageDialog(
                icon: icon,
                title: title,
                content: content,
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

  Widget _itemCurrencyWidget(CurrencyModel _currencyModel) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            margin: EdgeInsets.only(right: 10),
            child: Checkbox(
              value: true,
              onChanged: null,
            ),
          ),
          Text(
            _currencyModel.code.toUpperCase(),
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ShadowText(
              _firstTwo(_currencyModel.code.toUpperCase()),
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemLanguageWidget(LanguageModel _languageModel) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 20,
            margin: EdgeInsets.only(right: 10),
            child: Checkbox(
              value: _lang,
              onChanged: (bool value) {
                _lang = value;
              },
            ),
          ),
          Text(
            _languageModel.name ?? "",
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          CachedNetworkImage(
            height: 25,
            width: 40,
            imageUrl: Utils.getFlagUrl(_languageModel.code ?? ""),
          ),
          // Container(
          //   height: 20,
          //   width: 40,
          //   child: Image.asset(
          //     'assets/uk_flag.jpg',
          //   ),
          // ),
        ],
      ),
    );
  }

  String _firstTwo(String str) {
    return str.length < 2 ? str : str.substring(0, 2);
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.4)),
            ),
          ),
          new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.0),
            child: Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
