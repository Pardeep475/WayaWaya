import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wayawaya/app/auth/signup/sign_up_screen.dart';
import 'package:wayawaya/app/auth/splash/splash_screen.dart';
import 'package:wayawaya/app/common/webview/custom_web_view.dart';
import 'package:wayawaya/app/events/event_detail_screen.dart';
import 'package:wayawaya/app/events/event_screen.dart';
import 'package:wayawaya/app/mall/mall_screen.dart';
import 'package:wayawaya/app/map/the_mall_screen.dart';
import 'package:wayawaya/app/map/two_d_map_screen.dart';
import 'package:wayawaya/app/offers/offer_details.dart';
import 'package:wayawaya/app/offers/offers_screen.dart';
import 'package:wayawaya/app/preferences/select_preferences_screen.dart';
import 'package:wayawaya/app/rewards/details.dart';
import 'package:wayawaya/app/rewards/loyalty_screen.dart';
import 'package:wayawaya/app/rewards/qr_code_scanner.dart';
import 'package:wayawaya/app/search/search_screen.dart';
import 'package:wayawaya/app/settings/settings_screen.dart';
import 'package:wayawaya/app/shop/shop_detail_screen.dart';
import 'package:wayawaya/app/shop/shop_screen.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/geo_fence_service.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/size_config.dart';
import 'app/auth/forgotpassword/forgot_password_screen.dart';
import 'app/auth/login/login_screen.dart';
import 'app/home/home_screen.dart';
import 'app/rewards/rewards_new.dart';
import 'app/settings/my_account_screen.dart';
import 'app/settings/my_devices_screen.dart';
import 'network/local/notification_service.dart';
import 'network/local/super_admin_database_helper.dart';
import 'utils/analytics_service/analytics_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GeoFenceService.initGeofence();
  await NotificationService().init();
  await SuperAdminDatabaseHelper.initDataBase();
  await AnalyticsServices.init();
  bool isFirstTime = await SessionManager.isFirstTime();
  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;

  MyApp({this.isFirstTime});

  @override
  State<StatefulWidget> createState() =>
      MyAppState(isFirstTime: this.isFirstTime);
}

class MyAppState extends State<MyApp> {
  final bool isFirstTime;

  MyAppState({this.isFirstTime});

  @override
  void initState() {
    super.initState();
    _getCurrentDeviceInfo();
  }

  updateDataToDatabase() async {}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: AppString.app_name,
          theme: ThemeData(
              primarySwatch: Colors.cyan,
              primaryColor: Colors.teal,
              unselectedWidgetColor: Colors.grey[400],
              scaffoldBackgroundColor: Colors.grey[100]),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _customGenerateRoute,
          home: isFirstTime ? SplashScreen() : MallScreen(),
          // home: SelectPreferencesScreen(),
        );
      });
    });
  }

  //FORGOT_PASSWORD_SCREEN_ROUTE
  Route<dynamic> _customGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppString.LOGIN_SCREEN_ROUTE:
        return PageTransition(
          child: LoginScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SIGN_UP_SCREEN_ROUTE:
        return PageTransition(
          child: SignUpScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.FORGOT_PASSWORD_SCREEN_ROUTE:
        return PageTransition(
          child: ForgotPassword(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SPLASH_SCREEN_ROUTE:
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.MALL_SCREEN_ROUTE:
        return PageTransition(
          child: MallScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.HOME_SCREEN_ROUTE:
        return PageTransition(
          child: HomeScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SELECT_PREFERENCES_SCREEN_ROUTE:
        return PageTransition(
          child: SelectPreferencesScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SETTINGS_SCREEN_ROUTE:
        return PageTransition(
          child: SettingsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.MY_DEVICES_SCREEN_ROUTE:
        return PageTransition(
          child: MyDeviceScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.MY_ACCOUNT_SCREEN_ROUTE:
        return PageTransition(
          child: MyAccountScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SEARCH_SCREEN_ROUTE:
        return PageTransition(
          child: SearchScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.OFFER_SCREEN_ROUTE:
        return PageTransition(
          child: OfferScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.EVENT_SCREEN_ROUTE:
        return PageTransition(
          child: EventScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SEARCH_SCREEN_ROUTE:
        return PageTransition(
          child: SearchScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.OFFER_DETAILS_SCREEN_ROUTE:
        return PageTransition(
          child: OfferDetails(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.EVENT_DETAILS_ROUTE:
        return PageTransition(
          child: EventDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.TWO_D_MAP_SCREEN_ROUTE:
        return PageTransition(
          child: TwoDMapScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SHOP_SCREEN_ROUTE:
        return PageTransition(
          child: ShopScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.SHOP_DETAIL_SCREEN_ROUTE:
        return PageTransition(
          child: ShopDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE:
        return PageTransition(
          child: CustomWebView(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.REWARDS_SCREEN_ROUTE:
        return PageTransition(
          child: RewardsBrowser(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.THE_MALL_SCREEN_ROUTE:
        return PageTransition(
          child: TheMallScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.QR_SCANNER_SCREEN_ROUTE:
        return PageTransition(
          child: QRScanner(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.REWARDS_DETAIL_SCREEN_ROUTE:
        return PageTransition(
          child: RewardsDetails(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      case AppString.LOYALTY_SCREEN_ROUTE:
        return PageTransition(
          child: LoyaltyScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
        break;
      default:
        {
          return PageTransition(
            child: LoginScreen(),
            type: PageTransitionType.rightToLeft,
            settings: settings,
          );
        }
    }
  }

  _getCurrentDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      debugPrint(
          'device_info_testing:- ${'${androidInfo.manufacturer}${AppString.DEVICE_SEPARATOR}${androidInfo.model}${AppString.DEVICE_SEPARATOR}ANDROID${androidInfo.version.release}'.toUpperCase().trim()}'); // e.g.
      String finalDevice =
          '${androidInfo.manufacturer}${AppString.DEVICE_SEPARATOR}${androidInfo.model}${AppString.DEVICE_SEPARATOR}ANDROID${androidInfo.version.release}'
              .toUpperCase()
              .trim();
      SessionManager.setCurrentDevice(finalDevice ?? ""); // "Moto G (4)"
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      // OPPO~^CPH1911~^ANDROID10
      // device_info_testing iOS 14.5, iPhone 12 Pro Max iPhone
      // Apple ~^ iPhone X ~^ iOS 14.4.2

      debugPrint(
          'device_info_testing:- ${'Apple${AppString.DEVICE_SEPARATOR}${iosInfo.name}${AppString.DEVICE_SEPARATOR}${iosInfo.systemName} ${iosInfo.systemVersion}'.toUpperCase().trim()}'); // e.g.
      String finalDevice =
          'Apple${AppString.DEVICE_SEPARATOR}${iosInfo.name}${AppString.DEVICE_SEPARATOR}${iosInfo.systemName} ${iosInfo.systemVersion}'
              .toUpperCase()
              .trim();
      SessionManager.setCurrentDevice(finalDevice ?? ""); // "Moto G (4)"
    }
  }
}
