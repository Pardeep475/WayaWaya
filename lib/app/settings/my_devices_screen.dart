import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/settings/bloc/my_devices_bloc.dart';
import 'package:wayawaya/app/settings/model/device_model.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

import '../../config.dart';
import '../../constants.dart';
import 'custom_view/custom_item_device.dart';

class MyDeviceScreen extends StatefulWidget {
  const MyDeviceScreen({Key key}) : super(key: key);

  @override
  _MyDeviceScreenState createState() => _MyDeviceScreenState();
}

class _MyDeviceScreenState extends State<MyDeviceScreen> {
  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // Map<String, dynamic> _deviceData = <String, dynamic>{};
  // bool _android;
  // bool _iOS;
  //
  // Future<void> initPlatformState() async {
  //   Map<String, dynamic> deviceData = <String, dynamic>{};
  //
  //   try {
  //     if (_android) {
  //       deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  //     } else if (_iOS) {
  //       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
  //     }
  //   } on PlatformException {
  //     deviceData = <String, dynamic>{
  //       'Error:': 'Failed to get platform version.'
  //     };
  //   }
  //
  //   if (!mounted) return;
  //   setState(() {
  //     _deviceData = deviceData;
  //   });
  //   printY(_deviceData.toString());
  // }
  //
  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'version.securityPatch': build.version.securityPatch,
  //     'version.sdkInt': build.version.sdkInt,
  //     'version.release': build.version.release,
  //     'version.previewSdkInt': build.version.previewSdkInt,
  //     'version.incremental': build.version.incremental,
  //     'version.codename': build.version.codename,
  //     'version.baseOS': build.version.baseOS,
  //     'board': build.board,
  //     'bootloader': build.bootloader,
  //     'brand': build.brand,
  //     'device': build.device,
  //     'display': build.display,
  //     'fingerprint': build.fingerprint,
  //     'hardware': build.hardware,
  //     'host': build.host,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     'product': build.product,
  //     'supported32BitAbis': build.supported32BitAbis,
  //     'supported64BitAbis': build.supported64BitAbis,
  //     'supportedAbis': build.supportedAbis,
  //     'tags': build.tags,
  //     'type': build.type,
  //     'isPhysicalDevice': build.isPhysicalDevice,
  //     'androidId': build.androidId,
  //     'systemFeatures': build.systemFeatures,
  //   };
  // }
  //
  // Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  //   return <String, dynamic>{
  //     'manufacturer': data.name,
  //     'systemName': data.systemName,
  //     'systemVersion': data.systemVersion,
  //     'model': data.model,
  //     'localizedModel': data.localizedModel,
  //     'identifierForVendor': data.identifierForVendor,
  //     'isPhysicalDevice': data.isPhysicalDevice,
  //     'utsname.sysname:': data.utsname.sysname,
  //     'utsname.nodename:': data.utsname.nodename,
  //     'version.release:': data.utsname.release,
  //     'utsname.version:': data.utsname.version,
  //     'utsname.machine:': data.utsname.machine,
  //   };
  // }

  MyDevicesBloc _myDevicesBloc;

  @override
  void initState() {
    super.initState();
    _myDevicesBloc = MyDevicesBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _myDevicesBloc.fetchDevicesData(context);
    });
  }

  _getDataFromDataBase() async {
    try {
      String userData = await SessionManager.getUserData();
      UserDataResponse response = userDataResponseFromJson(userData);
      debugPrint('device_list_testing:-  ${response.devices}');
    } catch (e) {
      debugPrint('device_list_testing:-  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimateAppBar(
      title: AppString.my_devices.toUpperCase(),
      isSliver: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        StreamBuilder<List<DeviceModel>>(
            initialData: [],
            stream: _myDevicesBloc.deviceStream,
            builder: (context, snapshot) {
              if (snapshot.data == null) return SliverToBoxAdapter();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CustomItemDevice(
                      deviceModel: snapshot.data[index],
                    );
                  },
                  childCount: snapshot.data.length,
                ),
              );
            }),
      ],
    );
  }
}
