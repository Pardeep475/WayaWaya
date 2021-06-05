import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/app/settings/model/device_model.dart';

import '../../../config.dart';
import '../../../constants.dart';

class CustomItemDevice extends StatelessWidget {
  final DeviceModel deviceModel;

  CustomItemDevice({this.deviceModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        elevation: 1.3,
        shadowColor: Colors.grey[300],
        child: Container(
          width: App.width(context),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: Stack(
                      children: [
                        Icon(
                          CommunityMaterialIcons.cellphone,
                          size: 50,
                          color: deviceModel.isCurrentDevice
                              ? Colors.green
                              : Colors.black,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              deviceModel.manufacturer.toUpperCase() == 'APPLE'
                                  ? CommunityMaterialIcons.apple
                                  : CommunityMaterialIcons.android,
                              size: 15,
                              color: black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    deviceModel.os.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      deviceModel.manufacturer.toUpperCase(),
                      style: GoogleFonts.ubuntu().copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      deviceModel.model.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
