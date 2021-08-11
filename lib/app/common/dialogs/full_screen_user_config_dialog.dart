import 'dart:convert';
import 'dart:ffi';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/common/model/geo_location_model.dart';
import 'package:wayawaya/common/model/language_store.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/permission_service/permission_service.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

class FullScreenUserConfigDialog extends ModalRoute<bool> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.sixteen)),
          margin: EdgeInsets.only(left: Dimens.sixteen, right: Dimens.sixteen),
          padding: EdgeInsets.only(left: Dimens.sixteen, right: Dimens.sixteen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Dimens.twenty,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  AppString.user_config,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntuCondensed().copyWith(
                    color: Color(0xff57585a),
                    fontSize: Dimens.twentyTwo,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              SizedBox(
                height: Dimens.twenty,
              ),
              FutureBuilder<String>(
                  initialData: "",
                  future: getMallName(context),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: Color(0xff57585a),
                        fontSize: Dimens.eighteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    );
                  }),
              SizedBox(
                height: Dimens.three,
              ),
              FutureBuilder<String>(
                  initialData: "",
                  future: fetchLocationPermission(context),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: Color(0xff57585a),
                        fontSize: Dimens.eighteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    );
                  }),
              SizedBox(
                height: Dimens.three,
              ),
              FutureBuilder<String>(
                  initialData: "",
                  future: getGeoLocations(context),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: Color(0xff57585a),
                        fontSize: Dimens.eighteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    );
                  }),
              SizedBox(
                height: Dimens.three,
              ),
              FutureBuilder<String>(
                  initialData: "",
                  future: fetchBatteryPercentage(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: GoogleFonts.ubuntuCondensed().copyWith(
                        color: Color(0xff57585a),
                        fontSize: Dimens.eighteen,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8,
                      ),
                    );
                  }),
              SizedBox(
                height: Dimens.ten,
              ),
              Divider(
                height: Dimens.one,
                color: AppColor.rowDivider,
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    _onBackPressed(context);
                  },
                  child: Text(
                    AppString.ok.toUpperCase(),
                    style: GoogleFonts.ubuntuCondensed().copyWith(
                      color: Color(0xff57585a),
                      fontSize: Dimens.eighteen,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getMallName(BuildContext context) async {
    dynamic mallData = await SessionManager.getSmallDefaultMallData();
    dynamic value = json.decode(mallData);
    if (value["full_name"] == null) return "Mall Name :- ";
    try {
      List<LanguageStore> name = List<LanguageStore>.from(
          value["full_name"].map((x) => LanguageStore.fromJson(x)));
      String venueName = Utils.getTranslatedCode(context, name);
      return "Mall Name :- $venueName";
    } catch (e) {
      List<LanguageStore> name = List<LanguageStore>.from(
          jsonDecode(value["full_name"]).map((x) => LanguageStore.fromJson(x)));
      String venueName = Utils.getTranslatedCode(context, name);
      return "Mall Name :- $venueName";
    }
  }

  Future<String> getGeoLocations(BuildContext context) async {
    dynamic mallData = await SessionManager.getSmallDefaultMallData();
    dynamic value = json.decode(mallData);
    if (value["geo_location"] == null) return "Mall Name :- ";
    List<double> coordinatesList = [];
    try {
      value["geo_location"].forEach((element) {
        GeoLocation geoLocation = GeoLocation.fromJson(element);
        coordinatesList.addAll(geoLocation.location.coordinates);
      });
      return "Coordinates :- ${coordinatesList.toString()}";
    } catch (e) {
      return "Coordinates :-  ";
    }
  }

  Future<String> fetchLocationPermission(BuildContext context) async {
    bool permissionLocation = await PermissionService.checkLocationPermission();
    return permissionLocation
        ? "Location Settings :- Enabled"
        : "Location Settings :- Disabled";
  }

  Future<String> fetchBatteryPercentage() async {
    try {
      var battery = Battery();
      int batteryPer = await battery.batteryLevel;
      return "Battery Power :- $batteryPer%";
    } catch (e) {
      return "Battery Power :- ";
    }
  }

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
