import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AnalyticsServices {
  static final AnalyticsServices _analyticsServices =
  AnalyticsServices._internal();

  factory AnalyticsServices() {
    return _analyticsServices;
  }

  AnalyticsServices._internal();

  static init() async {
    await Firebase.initializeApp();
  }

  static setForcefullyCrash() {
    FirebaseCrashlytics.instance.crash();
  }
}
