import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/preferences/bloc/categories_preferences_bloc.dart';
import 'package:wayawaya/app/preferences/model/category_model.dart';
import 'package:wayawaya/app/preferences/model/preferences_categories.dart';
import 'package:wayawaya/utils/app_color.dart';

class CategoryPreferences extends StatelessWidget {
  final CategoryModel preferencesCategory;
  final Function(String categoriesId) onPressed;

  CategoryPreferences({this.preferencesCategory, this.onPressed});

  final CategoriesPreferencesBloc _categoriesPreferencesBloc =
      CategoriesPreferencesBloc();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            preferencesCategory.categoryName,
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
              initialData: preferencesCategory.isSelected,
              stream: _categoriesPreferencesBloc.switchStream,
              builder: (context, snapshot) {
                return Switch(
                  onChanged: (bool value) {
                    debugPrint('Preferences_Categories: ---->   $value');
                    onPressed(preferencesCategory.categoryId);
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
