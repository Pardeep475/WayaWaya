import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/super_admin_database_helper.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _confirmLocAlways().then((value) async {
        try {
          String defaultMall = await SessionManager.getDefaultMall();
          if (defaultMall == null || defaultMall.isEmpty) {
            List<MallProfileModel> _mallList =
                await SuperAdminDatabaseHelper.getDefaultVenueProfile(
                    defaultMall);
            debugPrint('database_testing:-   ${_mallList.length}');
            if (_mallList.length > 0) {
              SessionManager.setDefaultMall(_mallList[0].identifier);
              SessionManager.setAuthHeader(_mallList[0].key);
              SessionManager.setSmallDefaultMallData(_mallList[0].venue_data);
            }
          }
          await ProfileDatabaseHelper.initDataBase(defaultMall);
          await SyncService.fetchAllSyncData();

        } catch (e) {
          debugPrint('splash_database_error:-    $e');
        } finally {
          Future.delayed(Duration(seconds: 3), () {
            _openFurtherScreen();
          });
        }
      });
    });
  }

  Future _confirmLocAlways() async {
    debugPrint('I am asking for permission again');
    var status2 = await Permission.locationAlways.request();
    if (status2.isGranted) {
      debugPrint('Always');
      // Navigator.pushNamedAndRemoveUntil(
      //     context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
    } else if (status2.isPermanentlyDenied) {
      debugPrint('Only while using');
      // Navigator.pushNamedAndRemoveUntil(
      //     context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
    } else {
      debugPrint('Only while using');
      // Navigator.pushNamedAndRemoveUntil(
      //     context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
    }

    return;
  }

  _openFurtherScreen() async {
    bool isFirstTime = await SessionManager.getISLoginScreenVisible();
    debugPrint('isFirstTimeSplash:-   $isFirstTime');
    if (!isFirstTime) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppString.LOGIN_SCREEN_ROUTE, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, AppString.HOME_SCREEN_ROUTE, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage(
                AppImages.app_splashscreen,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
