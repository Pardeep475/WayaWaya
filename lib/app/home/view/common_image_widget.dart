import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:wayawaya/app/home/model/campaign_model.dart';
import 'package:wayawaya/app/offers/model/detail_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';

class CommonImageWidget extends StatelessWidget {
  final String imgUrl;
  final String tag;
  final Campaign campaign;

  CommonImageWidget({this.imgUrl, this.tag, this.campaign});

  @override
  Widget build(BuildContext context) {
    debugPrint('img_url_home:-  $imgUrl');
    return InkWell(
      onTap: () {
        if (campaign == null) return;

        if (tag.toUpperCase() == 'OFFER') {
          List<Campaign> _listOfCampaign = [];
          _listOfCampaign.add(campaign);
          DetailModel _detailModel =
              DetailModel(listOfCampaign: _listOfCampaign, position: 0);
          Navigator.pushNamed(context, AppString.OFFER_DETAILS_SCREEN_ROUTE,
              arguments: _detailModel);
        } else if (tag.toUpperCase() == 'EVENT') {
          List<Campaign> _listOfCampaign = [];
          _listOfCampaign.add(campaign);
          DetailModel _detailModel =
          DetailModel(listOfCampaign: _listOfCampaign, position: 0);
          Navigator.pushNamed(context, AppString.EVENT_DETAILS_ROUTE,
              arguments: _detailModel);
        }
      },
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
                fit: BoxFit.none,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
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
