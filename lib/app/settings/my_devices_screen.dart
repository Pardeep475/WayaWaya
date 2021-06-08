import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/settings/bloc/my_devices_bloc.dart';
import 'package:wayawaya/app/settings/model/device_model.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'custom_view/custom_item_device.dart';

class MyDeviceScreen extends StatefulWidget {
  const MyDeviceScreen({Key key}) : super(key: key);

  @override
  _MyDeviceScreenState createState() => _MyDeviceScreenState();
}

class _MyDeviceScreenState extends State<MyDeviceScreen> {
  MyDevicesBloc _myDevicesBloc;

  @override
  void initState() {
    super.initState();
    _myDevicesBloc = MyDevicesBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _myDevicesBloc.fetchMenuButtons();
      _myDevicesBloc.fetchDevicesData(context);
    });
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<MainMenuPermission>>(
      initialData: [],
      stream: _myDevicesBloc.mainMenuPermissionStream,
      builder: (context, snapshot) {
        debugPrint('main_menu_permission_testing:--  StreamBuilder device screen ${snapshot.data}');
        return AnimateAppBar(
          title: AppString.my_devices.toUpperCase(),
          isSliver: true,
          mainMenuPermissions: snapshot.data,
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
    );
  }
}
