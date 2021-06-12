import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/dialogs/common_login_with_home_page.dart';
import 'package:wayawaya/app/common/dialogs/common_preferences_saved_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/preferences/bloc/select_preferences_bloc.dart';
import 'package:wayawaya/app/preferences/model/currency_model.dart';
import 'package:wayawaya/app/preferences/model/language_model.dart';
import 'package:wayawaya/app/preferences/model/notification_model.dart';
import 'package:wayawaya/app/preferences/model/upload_preferences_model.dart';
import 'package:wayawaya/app/preferences/view/category_preferences.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';
import 'package:wayawaya/widgets/fav_malls.dart';

import '../../config.dart';
import '../../constants.dart';
import 'model/category_model.dart';

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
  NotificationModel _notificationModel;

  @override
  void initState() {
    super.initState();

    _selectPreferencesBloc = SelectPreferencesBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _selectPreferencesBloc.getMallData();
      _selectPreferencesBloc.getPreferencesCategories();
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
                  child: StreamBuilder<List<CategoryModel>>(
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
                                    onPressed: (categoriesId) {
                                      _selectPreferencesBloc
                                          .updateCategoriesList(categoriesId);
                                    },
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
                        _notificationModel = snapshot.data;
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
                                  _notificationModel = notificationData;
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
                            onTap: () {
                              _saveButtonPressed();
                            },
                            child: Card(
                              shadowColor: Colors.grey[400],
                              child: Container(
                                height: 50,
                                width: App.width(context) / 2.3,
                                child: Center(
                                  child: Text(
                                    AppString.save.toUpperCase(),
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
            StreamBuilder<ApiResponse<ErrorResponse>>(
              stream: _selectPreferencesBloc.selectPreferencesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      Future.delayed(Duration(milliseconds: 200), () {
                        Utils.commonProgressDialog(context);
                      });
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height,
                      );
                      break;
                    case Status.COMPLETED:
                      {
                        debugPrint("completed");
                        Navigator.pop(context);
                        Future.delayed(Duration(milliseconds: 100), () {
                          _loginComplete();
                        });
                      }
                      break;
                    case Status.ERROR:
                      {
                        Navigator.pop(context);
                        Future.delayed(Duration(milliseconds: 100), () {
                          debugPrint(
                              "Error error ${snapshot.data.data.message}");
                          _showErrorDialog(
                            icon: Icon(
                              FontAwesomeIcons.exclamationCircle,
                              color: AppColor.red_500,
                            ),
                            title: AppString.sorry,
                            content: AppString.check_your_internet_connectivity,
                            buttonText: AppString.ok.toUpperCase(),
                            onPressed: () => Navigator.pop(context),
                          );
                        });
                      }
                      break;
                  }
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  _loginComplete() {
    _showPreferencesSavedDialog();
  }

  _saveButtonPressed() async {
    bool isLogin = await SessionManager.isLogin();
    if (isLogin != null && isLogin) {
      Utils.checkConnectivity().then((value) {
        if (value) {
          // save preferences with login
          _selectPreferencesBloc.updateUserInfoApi(
              context: context, data: _getUploadPreferencesModel());
        } else {
          _showErrorDialog(
            icon: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: AppColor.orange_500,
            ),
            title: AppString.login.toUpperCase(),
            content: AppString.check_your_internet_connectivity,
            buttonText: AppString.ok.toUpperCase(),
            onPressed: () => Navigator.pop(context),
          );
        }
      });
    } else {
      // save preferences without login
      await _selectPreferencesBloc.putOfflineUserPreferenceData(
          _getNotificationCount(),
          _selectPreferencesBloc.getFavoriteMall,
          _selectPreferencesBloc.selectedCurrency,
          _selectPreferencesBloc.selectedLanguage);
      // SessionManager.setDefaultMall(_selectPreferencesBloc.getFavoriteMall);
      _showPreferencesSavedDialog();
    }
  }

  UploadPreferencesModel _getUploadPreferencesModel() => UploadPreferencesModel(
      preferences: UploadPreferencesModelData(
          categories: _selectPreferencesBloc.categoriesList,
          notification: _getNotificationCount(),
          alternateCurrency: _selectPreferencesBloc.selectedCurrency,
          defaultLanguage: _selectPreferencesBloc.selectedLanguage,
          favoriteMalls: _selectPreferencesBloc.getFavoriteMall));

  _showPreferencesSavedDialog() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonPreferencesSavedDialog(),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  int _getNotificationCount() {
    int finalN = 12;
    try {
      if (_notificationModel != null) {
        dynamic notificationSplit = _notificationModel.title.trim().split(" ");
        String patchNotify = notificationSplit[0];
        finalN = int.parse(patchNotify);
      }
    } catch (e) {}

    return finalN;
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
      );
    }
  }

  _showLoginDialog({Icon icon, String title, String content}) {
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
    _selectPreferencesBloc.updateCurrentCurrency(
        '${_currencyModel.code.toUpperCase()}, ${_currencyModel.countryCode}');
    debugPrint(
        'currency_code:-   ${_currencyModel.code}    ${_currencyModel.countryCode}');
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
    _selectPreferencesBloc.updateCurrentLanguage(_languageModel.code);
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          StreamBuilder<bool>(
              initialData: true,
              stream: _selectPreferencesBloc.languageCheckBoxStream,
              builder: (context, snapshot) {
                return Container(
                  width: 20,
                  margin: EdgeInsets.only(right: 10),
                  child: Checkbox(
                    value: snapshot.data,
                    onChanged: (bool value) {
                      _selectPreferencesBloc.languageCheckBoxSink.add(value);
                      if (value) {
                        _selectPreferencesBloc
                            .updateCurrentLanguage(_languageModel.code);
                      } else {
                        _selectPreferencesBloc.updateCurrentLanguage('');
                      }
                    },
                  ),
                );
              }),
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
        ],
      ),
    );
  }

  String _firstTwo(String str) {
    return str.length < 2 ? str : str.substring(0, 2);
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
              child: CommonErrorDialog(
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
