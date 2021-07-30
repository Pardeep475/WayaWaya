import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/dialogs/full_screen_show_qr_and_barcode_generator_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/settings/model/settings_model.dart';
import 'package:wayawaya/app/shop/model/shops_fav_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_header_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/geo_fence_service.dart';
import 'package:wayawaya/utils/session_manager.dart';
import '../../constants.dart';
import 'bloc/settings_bloc.dart';
import 'custom_view/custom_settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = SettingsBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _settingsBloc.fetchMenuButtons();
      _settingsBloc.setUpSettingsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: StreamBuilder<List<MainMenuPermission>>(
            initialData: [],
            stream: _settingsBloc.mainMenuPermissionStream,
            builder: (context, snapshot) {
              return AnimateAppBar(
                title: AppString.settings,
                isSliver: true,
                mainMenuPermissions: snapshot.data,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StreamBuilder<List<SettingsModel>>(
                      initialData: [],
                      stream: _settingsBloc.settingsStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SliverToBoxAdapter();

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return CustomSettingsCard(
                                settingsModel: snapshot.data[index],
                                onPressed: (value) {
                                  _onItemClick(value);
                                },
                              );
                            },
                            childCount: snapshot.data.length,
                          ),
                        );
                      }),
                ],
              );
            }),
        bottomNavigationBar: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.grey[100],
          height: 100,
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                AppString.app_version,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColor.dark_text,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: Dimens.five,
              ),
              InkWell(
                onTap: _logoutButtonClick,
                child: Container(
                  color: white,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.only(
                      top: Dimens.fifteen, bottom: Dimens.twenty),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.login_outlined,
                        color: AppColor.dark_text,
                      ),
                      SizedBox(
                        width: Dimens.five,
                      ),
                      Text(
                        AppString.logout,
                        style: TextStyle(
                          fontSize: Dimens.eighteen,
                          color: AppColor.dark_text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logoutButtonClick() async {
    debugPrint('settings_click_testing:-  logout');
    SessionManager.setISLogin(false);
    Navigator.pushNamedAndRemoveUntil(
        context, AppString.SPLASH_SCREEN_ROUTE, (route) => false);
  }

  _onItemClick(SettingsModel settingsModel) async {
    switch (settingsModel.title) {
      case AppString.my_account:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          Navigator.pushNamed(context, AppString.MY_ACCOUNT_SCREEN_ROUTE);
          break;
        }
      case AppString.preferences_small:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          Navigator.pushNamed(
              context, AppString.SELECT_PREFERENCES_SCREEN_ROUTE);
          break;
        }
      case AppString.my_devices:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          Navigator.pushNamed(context, AppString.MY_DEVICES_SCREEN_ROUTE);
          break;
        }
      case AppString.my_favourites:
        {
          Navigator.pushNamed(context, AppString.SHOP_SCREEN_ROUTE,
              arguments: ShopFavModel(isShop: true, index: 3));
          break;
        }
      case AppString.privacy_policy:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          _settingsBloc.privacyPolicyOnClick(context);
          //
          // DataBaseHelperCommon.deleteData();

          break;
        }
      case AppString.term_and_conditions:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          // _settingsBloc.termAndConditionOnClick(context);




          await SyncService.checkUser();
          // GeoFenceService.requestPermission();
          // GeoFenceService.addLatLongToGeofence();
          // GeoFenceService.listenBackgroundLocation();
          // Future.delayed(Duration(seconds: 40),(){
          //   GeoFenceService.removeLatLongToGeoFence();
          // });

          break;
        }
    }
  }

  _implementLocalDb() async {
    String defaultMall = await SessionManager.getDefaultMall();
    List<LoyaltyHeaderResponse> _serviceList =
        await ProfileDatabaseHelper.getLoyaltyData(
      databasePath: defaultMall,
    );
    _serviceList.forEach((element) {
      debugPrint(
          'LoyaltyTemp:-   ${element.timestamp}   ${element.totalMonthPoints}   ${element.month}');
    });
  }
}
