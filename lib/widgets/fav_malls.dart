import 'package:flutter/material.dart';

import '../constants.dart';

class FavMall extends StatefulWidget {
  final int index;

  const FavMall({
    this.index,
  });

  @override
  _FavMallState createState() => _FavMallState();
}

class _FavMallState extends State<FavMall> {
 List<bool> values = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  getMallName() {
    switch (widget.index) {
      case 0:
        return 'Dobsonville';
      case 1:
        return 'Hillfox Value Centre';
      case 2:
        return 'Durban Workshop';
      case 3:
        return 'Randburg Square Centre';
      case 4:
        return 'Atlantis City';
      case 5:
        return 'Hammarsdale Junction';
      case 6:
        return 'Kolonnade Retail Park';
      case 7:
        return 'Bloemfontein Plaza';
      case 8:
        return 'Gugulethu Square';
      case 9:
        return 'Mdantsane City Shopping Centre';
      case 10:
        return 'Pine Crest Centre';
      case 11:
        return 'Nonesi Mall';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 35,
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            margin: EdgeInsets.only(right: 10),
            child: Checkbox(
              value: values[widget.index],
              onChanged: (bool value) {
                setState(() {
                  values[widget.index] = value;
                });
              },
            ),
          ),
          Text(
            getMallName(),
            style: TextStyle(
              fontSize: 15,
              color: hintColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
