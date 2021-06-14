import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:wayawaya/screens/home.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';

class CommonImageWidget extends StatelessWidget {
  final String imgUrl;
  final String tag;

  CommonImageWidget({this.imgUrl, this.tag});

  @override
  Widget build(BuildContext context) {
    debugPrint('common_image_widget_url:-   $imgUrl');
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: AppColor.primaryDark,
        foregroundDecoration: tag == null
            ? null
            : RotatedCornerDecoration(
                color: AppColor.primary,
                badgeShadow:
                    const BadgeShadow(color: Colors.black87, elevation: 1.5),
                labelInsets: LabelInsets(baselineShift: 2),
                geometry: const BadgeGeometry(
                  width: 70,
                  alignment: BadgeAlignment.topLeft,
                  height: 70,
                ),
                textSpan: TextSpan(
                  text: tag,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
        child: this.imgUrl == null
            ? SizedBox.expand(
                child: Container(
                  color: AppColor.primaryDark,
                ),
              )
            : CachedNetworkImage(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                imageUrl: imgUrl,
                fit: BoxFit.fill,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            AppColor.primaryDark),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.asset(
                    AppImages.icon_placeholder,
                    fit: BoxFit.cover,
                  );
                },
              ),
      ),
    );
  }
}
