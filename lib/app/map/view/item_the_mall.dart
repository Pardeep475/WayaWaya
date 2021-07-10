import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        _clickListener(context, serviceModel);
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
            Container(
              color: Colors.yellow,
              child: SvgPicture.asset(
                getImage(serviceModel),
                height: Dimens.sixtyFive,
                width: Dimens.sixtyFive,
                fit: BoxFit.cover,
              ),
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
          return AppImages.petrol_station;
        }
      case 'carwash_icon':
        {
          return AppImages.car_wash;
        }
      case 'info':
        {
          return AppImages.info;
        }
      case 'escalator':
        {
          return AppImages.escalator;
        }
      case 'wheel':
        {
          return AppImages.ic_1;
        }
      case 'restroom':
        {
          return AppImages.restuarant;
        }
      case 'atm':
        {
          return AppImages.atm;
        }
      case 'stairs':
        {
          return AppImages.stairs;
        }
      case 'centre_management':
        {
          return AppImages.centre_management;
        }
      case 'fire_escape':
        {
          return AppImages.fire_escape;
        }
      case 'entrance':
        {
          return AppImages.entrances;
        }
      case 'delivery':
        {
          return AppImages.delivery_gate;
        }
      case 'bench':
        {
          return AppImages.benches;
        }
      case 'parking':
        {
          return AppImages.parking;
        }
      case 'elevator':
        {
          return AppImages.elevators;
        }
      case 'recycle':
        {
          return AppImages.recycling;
        }
      case 'security':
        {
          return AppImages.security;
        }
      case 'taxi':
        {
          return AppImages.taxi_rank;
        }
      case 'assembly_point':
        {
          return AppImages.assembly_point;
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
