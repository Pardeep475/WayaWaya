import 'package:flutter/material.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/settings/model/settings_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import '../../constants.dart';
import 'bloc/settings_bloc.dart';
import 'custom_view/custom_settings_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = SettingsBloc();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _settingsBloc.setUpSettingsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimateAppBar(
          title: AppString.settings,
          isSliver: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            StreamBuilder<List<SettingsModel>>(
                initialData: [],
                stream: _settingsBloc.settingsStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) return SliverToBoxAdapter();

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CustomSettingsCard(
                          settingsModel: snapshot.data[index],
                          onPressed: (value) {
                            _onItemClick(value);
                          },
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
                  );
                }),
          ],
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.grey[100],
          height: 100,
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                AppString.app_version,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppColor.dark_text,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              InkWell(
                onTap: _logoutButtonClick,
                child: Container(
                  color: white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.login_outlined,
                        color: AppColor.dark_text,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        AppString.logout,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColor.dark_text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _logoutButtonClick() {
    debugPrint('settings_click_testing:-  logout');
  }

  _onItemClick(SettingsModel settingsModel) {
    switch (settingsModel.title) {
      case AppString.my_account:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          break;
        }
      case AppString.preferences_small:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          break;
        }
      case AppString.my_devices:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          Navigator.pushNamed(context, AppString.MY_DEVICES_SCREEN_ROUTE);
          break;
        }
      case AppString.my_favourites:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          break;
        }
      case AppString.privacy_policy:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          _settingsBloc.privacyPolicyOnClick(context);
          break;
        }
      case AppString.term_and_conditions:
        {
          debugPrint('settings_click_testing:-  ${settingsModel.title}');
          _settingsBloc.termAndConditionOnClick(context);
          break;
        }
    }
  }
}
