import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/app/home/model/top_campaign_model.dart';

import 'common_image_widget.dart';

class WhatsonWidget extends StatelessWidget {
  final TopCampaignModel topCampaignModelPositionZero;
  final TopCampaignModel topCampaignModelPositionOne;

  WhatsonWidget(
      {this.topCampaignModelPositionZero, this.topCampaignModelPositionOne});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      child: Row(
        children: [
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: CommonImageWidget(
                    imgUrl: topCampaignModelPositionZero == null
                        ? null
                        : topCampaignModelPositionZero.imgUrl,
                    tag: topCampaignModelPositionZero == null
                        ? null
                        : topCampaignModelPositionZero.tag,
                  ),
                ),
                Expanded(
                  child: CommonImageWidget(
                    imgUrl: topCampaignModelPositionOne == null
                        ? null
                        : topCampaignModelPositionOne.imgUrl,
                    tag: topCampaignModelPositionOne == null
                        ? null
                        : topCampaignModelPositionOne.tag,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
