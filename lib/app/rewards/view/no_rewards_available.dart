import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';

class NoRewardsAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.twenty, vertical: Dimens.twenty),
        child: Text(
          AppString.no_rewards_available,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Dimens.eighteen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
