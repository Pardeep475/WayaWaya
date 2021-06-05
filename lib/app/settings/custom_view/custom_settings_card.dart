import 'package:flutter/material.dart';
import 'package:wayawaya/app/settings/model/settings_model.dart';
import 'package:wayawaya/utils/app_color.dart';

class CustomSettingsCard extends StatelessWidget {
  final Function(SettingsModel) onPressed;
  final SettingsModel settingsModel;

  CustomSettingsCard({this.onPressed, this.settingsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(settingsModel);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Card(
          elevation: 1.3,
          shadowColor: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                settingsModel.icon == null
                    ? SizedBox()
                    : Icon(
                        settingsModel.icon,
                        size: 16,
                        color: AppColor.dark_text,
                      ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  settingsModel.title ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColor.dark_text,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
