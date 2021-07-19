import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/models/omni_channel_item_model/omni_channel_item_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'bloc/mall_bloc.dart';

class MallScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  MallBloc _mallBloc;

  @override
  void initState() {
    super.initState();
    _mallBloc = MallBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _mallBloc.getMallData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryDark,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          AppString.select_your_default_mall,
          style: const TextStyle(
            color: AppColor.softWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage(
              AppImages.splash_screen_bg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: StreamBuilder<List<MallProfileModel>>(
            initialData: [],
            stream: _mallBloc.mallProfileStream,
            builder: (context, snapshot) {
              return ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (_, index) {
                    return Container(
                      height: 6,
                      color: const Color(0xff397C85).withOpacity(0.2),
                    );
                  },
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () async{
                        SessionManager.setFirstTime(true);
                        SessionManager.setDefaultMall(snapshot.data[index].identifier);
                        SessionManager.setAuthHeader(snapshot.data[index].key);
                        SessionManager.setSmallDefaultMallData(snapshot.data[index].venue_data);
                        await SyncService.fetchAllSyncData();
                        Navigator.pushReplacementNamed(
                            context, AppString.SPLASH_SCREEN_ROUTE);
                      },
                      child: Container(
                        height: 125,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xff6CD1D5).withOpacity(0.5),
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 90,
                              margin: const EdgeInsets.only(left: 20),
                              child: Image.asset(
                                  'assets/image/ic_launcher_${snapshot.data[index].identifier}.png'),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 2),
                                child: Text(
                                  snapshot.data[index].name ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
