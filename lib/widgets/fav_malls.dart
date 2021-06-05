import 'package:flutter/material.dart';
import 'package:wayawaya/common/model/mall_profile_model.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/session_manager.dart';

import '../constants.dart';

class FavMall extends StatefulWidget {
  final int index;
  final MallProfileModel mallProfileModel;

  final Function({int pos, MallProfileModel mallProfileModel, bool selected}) onPressed;

  const FavMall({this.index, this.mallProfileModel, this.onPressed});

  @override
  _FavMallState createState() => _FavMallState();
}

class _FavMallState extends State<FavMall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            margin: EdgeInsets.only(right: 10),
            child: Checkbox(
              value: widget.mallProfileModel.active == 0 ? true : false,
              onChanged: (bool value) async {
                widget.onPressed(pos: widget.index,mallProfileModel: widget.mallProfileModel,selected: value);
              },
            ),
          ),
          Text(
            widget.mallProfileModel.name ?? "",
            style: TextStyle(
              fontSize: 15,
              color: AppColor.dark_text,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
