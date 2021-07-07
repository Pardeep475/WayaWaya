import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/webview/model/custom_web_view_model.dart';
import 'package:wayawaya/app/map/model/service_model.dart';
import 'package:wayawaya/app/shop/model/color_codes.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class ItemTheMall extends StatelessWidget {
  final ServiceModel serviceModel;
  final int index;

  ItemTheMall({this.serviceModel, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _clickListener(context,serviceModel);
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff00b6b6), //getBackColor(serviceModel),
          borderRadius: BorderRadius.circular(Dimens.five),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              getImage(serviceModel),
              height: Dimens.sixtyFive,
              width: Dimens.sixtyFive,
            ),
            Padding(
              padding: EdgeInsets.all(Dimens.eight),
              child: Text(
                _getTitle(context, serviceModel),
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: AppColor.white,
                  fontSize: Dimens.nineteen,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getTitle(BuildContext context, ServiceModel serviceModel) {
    if (serviceModel == null) return '';
    if (serviceModel.displayName == null) return '';

    return Utils.getTranslatedCode(context, serviceModel.displayName);
  }

  getBackColor(ServiceModel serviceModel) {
    if (serviceModel == null) return AppColor.primary;
    if (serviceModel.color == null) return AppColor.primary;
    dynamic color = jsonDecode(serviceModel.color);
    return Utils.fromHex(color['background']);
  }

  String getImage(ServiceModel serviceModel) {
    if (serviceModel == null) return '';
    if (serviceModel.icon == null) return '';
    dynamic name = jsonDecode(serviceModel.icon);
    switch (name['name']) {
      case 'filling_station':
        {
          return AppImages.ic_1;
        }
      case 'carwash_icon':
        {
          return AppImages.ic_1;
        }
      case 'info':
        {
          return AppImages.ic_1;
        }
      case 'escalator':
        {
          return AppImages.ic_13;
        }
      case 'wheel':
        {
          return AppImages.ic_1;
        }
      case 'restroom':
        {
          return AppImages.ic_9;
        }
      case 'atm':
        {
          return AppImages.ic_2;
        }
      case 'stairs':
        {
          return AppImages.ic_3;
        }
      case 'centre_management':
        {
          return AppImages.ic_4;
        }
      case 'fire_escape':
        {
          return AppImages.ic_6;
        }
      case 'entrance':
        {
          return AppImages.ic_5;
        }
      case 'delivery':
        {
          return AppImages.ic_7;
        }
      case 'bench':
        {
          return AppImages.ic_8;
        }
      case 'parking':
        {
          return AppImages.ic_14;
        }
      case 'elevator':
        {
          return AppImages.ic_13;
        }
      case 'recycle':
        {
          return AppImages.ic_10;
        }
      case 'security':
        {
          return AppImages.ic_12;
        }
      case 'taxi':
        {
          return AppImages.ic_11;
        }
      case 'assembly_point':
        {
          return AppImages.ic_15;
        }
      default:
        {
          return AppImages.ic_1;
        }
    }
  }

  _clickListener(BuildContext context, ServiceModel serviceModel) {
    if (serviceModel == null) return;
    if (serviceModel.type == null) return;
    dynamic type = jsonDecode(serviceModel.type);
    debugPrint('action_type:-   ${type['action']}');
    switch (type['action']) {
      case "search":
        {}
        break;
      case "notification":
        {}
        break;
      case "activity":
        {}
        break;
      case "twodmap":
        {
          _openTwoDMall(context, type['activity']);
        }
        break;
      case "fragment":
        {}
        break;
    }
  }

  _openTwoDMall(BuildContext context, String category) async {
    String defaultMap = await SessionManager.getDefaultMall();
    String mapUrl =
        '${AppString.MAP_URL_LIVE}?category=$category&map_data_url=$defaultMap';
    debugPrint('mapUrl_testing:-    $mapUrl');

    Navigator.pushNamed(
      context,
      AppString.CUSTOM_WEB_VIEW_SCREEN_ROUTE,
      arguments: CustomWebViewModel(title: 'MAP', webViewUrl: mapUrl),
    );
  }
}
