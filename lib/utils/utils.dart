import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wayawaya/app/home/model/campaign_element.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/network/live/network_constants.dart';

import 'app_color.dart';
import 'app_strings.dart';
import 'dimens.dart';

class Utils {
  static final Utils _utils = Utils._internal();

  factory Utils() {
    return _utils;
  }

  Utils._internal();

  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      } else {
        debugPrint('not connected');
        return false;
      }
    } on SocketException catch (_) {
      debugPrint('SocketException not connected');
      return false;
    }
  }

  static showSnackBar(String message, BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: message,
      backgroundColor: AppColor.primary,
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: 3),
      messageText: Text(
        message,
        // textAlign: TextAlign.center,
        style: TextStyle(fontSize: Dimens.twenty, color: AppColor.white),
      ),
    )..show(context);
  }

  static bool checkNullOrEmpty(String value) {
    if (value == null || value.isEmpty) return true;
    return false;
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  static String dateConvert(String value, String format) {
    try {
      DateTime date = DateTime.parse(value);
      String formattedDate = DateFormat(format).format(date.toLocal());
      return formattedDate;
    } catch (e) {
      debugPrint('date_format_tesing:-   $e');
      return '';
    }
  }

  static commonProgressDialog(BuildContext context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.1),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              content: Container(
                height: Dimens.forty,
                child: Row(
                  children: [
                    SizedBox(
                      height: Dimens.thirty,
                      width: Dimens.thirty,
                      child: CircularProgressIndicator(
                        strokeWidth: Dimens.two,
                        backgroundColor: AppColor.primaryDark,
                      ),
                    ),
                    SizedBox(
                      width: Dimens.ten,
                    ),
                    Text(
                      AppString.processing_data,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Dimens.forteen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {},
    );
  }

  static commonErrorDialog({BuildContext context, String icon, String ti}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.1),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              content: Container(
                height: Dimens.forty,
                child: Row(
                  children: [
                    SizedBox(
                      height: Dimens.thirty,
                      width: Dimens.thirty,
                      child: CircularProgressIndicator(
                        strokeWidth: Dimens.two,
                        backgroundColor: AppColor.primaryDark,
                      ),
                    ),
                    SizedBox(
                      width: Dimens.ten,
                    ),
                    Text(
                      AppString.processing_data,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Dimens.forteen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {},
    );
  }

  static String getTranslatedCode(
      BuildContext context, List<LanguageStore> translatedData) {
    String languageCode =
        '${Localizations.localeOf(context).languageCode}_${Localizations.localeOf(context).countryCode}';
    String languageCode1 = '${Localizations.localeOf(context).languageCode}';
    String preferredLanguageLocal = 'en_UK';

    String text = "";
    if (translatedData != null) {
      translatedData.forEach((language) {
        if (language.language == preferredLanguageLocal) {
          text = language.text;
          return;
        } else if (language.language == languageCode) {
          text = language.text;
          return;
        } else if (language.language == languageCode1) {
          text = language.text;
          return;
        } else {
          String defaultLang = "en_US";
          if (language.language == defaultLang ||
              language.language.contains("en")) {
            text = language.text;
          }
        }
      });
    }
    return text;
  }

  static String getTranslatedCodeFromImageId(List<ImageId> translatedData) {
    String text = "";
    if (translatedData != null) {
      translatedData.forEach((language) {
        if (language.language == Language.EN_US) {
          text = language.text;
          return;
        }
      });
    }
    return text;
  }

  static String getFlagUrl(String item) {
    switch (item) {
      case "en_US":
        {
          return parseMediaUrl(
              "http://res.cloudinary.com/intelipower/image/upload/v1512717289/media/5203363f47bc4c2991a7a2bf3f4a2cb4/flags/flags-png-250/us.png");
        }
      case 'fr':
        {
          return parseMediaUrl(
              "http://res.cloudinary.com/intelipower/image/upload/v1512717289/media/5203363f47bc4c2991a7a2bf3f4a2cb4/flags/flags-png-250/fr.png");
        }
      case 'en_UK':
        {
          return parseMediaUrl(
              "http://res.cloudinary.com/intelipower/image/upload/v1512717289/media/5203363f47bc4c2991a7a2bf3f4a2cb4/flags/flags-png-250/gb.png");
        }
      default:
        {
          return parseMediaUrl(
              "http://res.cloudinary.com/intelipower/image/upload/v1512717289/media/5203363f47bc4c2991a7a2bf3f4a2cb4/flags/flags-png-250/gb.png");
        }
    }
  }

  static String parseMediaUrl(String url) {
    if (url.contains("media.dev.fattengage.com")) {
      return url.replaceFirst(
          "media.dev.fattengage.com", NetworkConstants.base_url_image);
    } else if (url.contains("api.fattiengage.com")) {
      return url.replaceFirst(
          "api.fattiengage.com", NetworkConstants.base_url_image);
    } else {
      return url;
    }
  }

  static String uploadDateFormat(String value) {
    try {
      DateFormat originalFormat = new DateFormat("dd/MM/yyyy");
      DateFormat targetFormat = new DateFormat(AppString.DATE_FORMAT);
      DateTime date = originalFormat.parse(value);
      String formattedDate = targetFormat.format(date.toLocal());
      debugPrint("date_format_birthday---->    $formattedDate");
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  static String dateFormat(String value) {
    try {
      DateFormat originalFormat = new DateFormat("dd/MM/yyyy");
      DateFormat targetFormat = new DateFormat(AppString.DATE_FORMAT);
      DateTime date = originalFormat.parse(value);
      String formattedDate = targetFormat.format(date.toLocal());
      debugPrint("date_format_birthday---->    $formattedDate");
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  static String eventStatus({String startDate, String endDate}) {
    try {
      DateTime calendar = DateTime.now();

      if (DateTime.parse(startDate).isBefore(calendar) &&
          DateTime.parse(endDate).isAfter(calendar)) {
        return "started";
      } else if (calendar.isAfter(DateTime.parse(startDate))) {
        return "starts";
      } else {
        return "ended";
      }
    } catch (e) {
      debugPrint('date_format_tesing:-   $e');
      return 'ended';
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static bool storeStatus({DateTime openTime, DateTime closeTime}) {
    try {
      DateFormat sdf = new DateFormat('HH:mm:ss');
      DateTime dt = DateTime.now();

      DateTime tempOpenTime =
          getDateOnStringParse(sdf.format(openTime), "HH:mm:ss");
      DateTime tempCloseTime =
          getDateOnStringParse(sdf.format(closeTime), "HH:mm:ss");
      DateTime tempCompareTime =
          getDateOnStringParse(sdf.format(dt), "HH:mm:ss");

      if (tempOpenTime.isBefore(tempCompareTime) &&
          tempCloseTime.isAfter(tempCompareTime)) {
        return true;
      } else if (tempCloseTime.isAfter(tempCompareTime) &&
          tempOpenTime.isBefore(tempCompareTime)) {
        return false;
      }
      return false;
    } catch (e) {
      debugPrint('date_format_tesing:-   $e');
      return false;
    }
  }

  static DateTime getDateOnStringParse(String dateText, String format) {
    DateTime returnValue;

    try {
      DateFormat sdfmt1 = new DateFormat(format);
      returnValue = sdfmt1.parse(dateText);
      return returnValue;
    } catch (e) {
      debugPrint('Exception caught in getDateOnStringParse    $e');
      return DateTime.now();
    }
  }

  static String convertDateToTime(String value) {
    try {
      DateFormat originalFormat = new DateFormat(AppString.DATE_FORMAT);
      DateFormat targetFormat = new DateFormat('hh:mm:ss');
      DateTime date = originalFormat.parse(value);
      String formattedDate = targetFormat.format(date.toLocal());
      debugPrint("date_format_birthday---->    $formattedDate");
      return formattedDate;
    } catch (e) {
      return "";
    }
  }
}
