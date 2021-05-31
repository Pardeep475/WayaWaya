import 'dart:ui';

class AppColor {
  static final AppColor _appColor = AppColor._internal();

  factory AppColor() {
    return _appColor;
  }

  AppColor._internal();

  static const primary = Color(0xFF56babe);
  static const primaryDark = Color(0xFF397C85);
  static const accent = Color(0xFF2a2c2d);
  static const colored_text = Color(0xFF6CD1D9);
  static const secondaryBlack = Color(0xFF8A000000);
  static const borderColor = Color(0xFFBDBDBD);
  static const secondaryColor = Color(0xFF939393);
  static const softWhite = Color(0xFFf0f0f0);
  static const mall_card_back_color = Color(0xFF80CCE6F4);
  static const red_500 = Color(0xFFF44336);
  static const orange_500 = Color(0xFFFF9800);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const orange = Color(0xFFEE6710);
  static const yellow = Color(0xFFFEB62B);
  static const dark_text = Color(0xFF797777);
  static const dark_colored_text = Color(0xFFF56505);
  static const divider_color = Color(0xFFBABABA);
  static const search_back = Color.fromRGBO(0, 0, 0, .13);
  static const yellow_transparent = Color.fromRGBO(253, 156, 39, .70);
  static const hint_color = Color(0xFF878787);
  static const text_color_credit_check_address = Color(0xFF3D3D3D);
  static const green = Color(0xFF1A7900);
}
