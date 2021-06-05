import 'dart:io';

// import 'package:device_preview/device_preview.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wayawaya/app/auth/signup/sign_up_screen.dart';
import 'package:wayawaya/app/auth/splash/splash_screen.dart';
import 'package:wayawaya/app/mall/mall_screen.dart';
import 'package:wayawaya/app/preferences/select_preferences_screen.dart';
import 'package:wayawaya/app/settings/settings_screen.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/size_config.dart';
import 'app/auth/forgotpassword/forgot_password_screen.dart';
import 'app/auth/login/login_screen.dart';
import 'app/home/home_screen.dart';
import 'app/settings/my_devices_screen.dart';
import 'network/local/super_admin_database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SuperAdminDatabaseHelper _superAdminDatabaseHelper =
  //     SuperAdminDatabaseHelper();
  // await _superAdminDatabaseHelper.initDataBase();

  await SuperAdminDatabaseHelper.initDataBase();
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
      debugPrint('device_info_testing ${iosInfo.utsname.machine}'); //
      SessionManager.setCurrentDevice(iosInfo.utsname.machine ?? "");
    }
  }
}

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Future<String> getEmail() => UserPreferences().getUserEmail();
//     print(UserPreferences().getUserEmail().runtimeType);
//
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.cyan,
//           primaryColor: Colors.teal,
//           unselectedWidgetColor: Colors.grey[400],
//         ),
//         home: FutureBuilder(
//           future: getEmail(),
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.none:
//               case ConnectionState.waiting:
//                 return CircularProgressIndicator();
//               default:
//                 if (snapshot.data == null)
//                   return _navigateToScreen();
//                 else
//                   return Splash();
//                 return Splash();
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   _navigateToScreen() {
//     bool mall = App.prefs.getBool('defaultMall') ?? false;
//     bool bg = App.prefs.getBool('bgScreen') ?? false;
//     bool login = App.prefs.getBool('login') ?? false;
//     String callStat = Platform.isIOS
//         ? 'GRANTED'
//         : App.prefs.getString('callAccess') ?? 'DENIED';
//     String locStat = App.prefs.getString('locAccess') ?? 'DENIED';
//     String locType = App.prefs.getString('locType') ?? 'NOT SET';
//     print(mall.toString() + "," + bg.toString() + "," + login.toString());
//     if (mall == false) {
//       return SelectMall();
//     } else {
//       if (bg == false) {
//         printR(callStat + locStat + locType);
//         if (callStat == 'GRANTED' &&
//             locStat == 'GRANTED' &&
//             locType == 'NOT SET') {
//           return BackgroundScreen(
//             showOnlyLocType: true,
//           );
//         } else {
//           return BackgroundScreen();
//         }
//       } else {
//         if (login == false) {
//           return Login();
//         } else {
//           return HomeScreen();
//         }
//       }
//     }
//   }
// }
