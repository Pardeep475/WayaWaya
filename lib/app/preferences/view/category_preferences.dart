import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/preferences/bloc/categories_preferences_bloc.dart';
import 'package:wayawaya/app/preferences/model/preferences_categories.dart';
import 'package:wayawaya/utils/app_color.dart';

class CategoryPreferences extends StatelessWidget {
  final PreferencesCategory preferencesCategory;

  CategoryPreferences({this.preferencesCategory});

  final CategoriesPreferencesBloc _categoriesPreferencesBloc =
      CategoriesPreferencesBloc();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            preferencesCategory == null
                ? ''
                : preferencesCategory.name == null
                    ? null
                    : preferencesCategory.name.replaceAll('<>', '/'),
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark_text,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Transform.scale(
          scale: 1.2,
          child: StreamBuilder<bool>(
              initialData: false,
              stream: _categoriesPreferencesBloc.switchStream,
              builder: (context, snapshot) {
                return Switch(
                  onChanged: (bool value) {
                    debugPrint('Preferences_Categories: ---->   $value');
                    _categoriesPreferencesBloc.switchSink.add(value);
                  },
                  value: snapshot.data,
                  activeColor: AppColor.primary,
                  activeTrackColor: AppColor.primary,
                  inactiveThumbColor: AppColor.softWhite,
                  inactiveTrackColor: AppColor.softWhite,
                );
              }),
        ),
      ],
    );
  }
}
