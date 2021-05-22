import 'dart:io';

// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wayawaya/app/auth/splash/splash_screen.dart';
import 'package:wayawaya/app/mall/mall_screen.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/size_config.dart';
import 'app/auth/forgotpassword/forgot_password_screen.dart';
import 'app/auth/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          home: SplashScreen(),
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
}

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
