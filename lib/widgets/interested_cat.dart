import 'package:flutter/material.dart';

class InterestedCategories extends StatefulWidget {
  final int index;

  const InterestedCategories({
    this.index,
  });

  @override
  _InterestedCategoriesState createState() => _InterestedCategoriesState();
}

class _InterestedCategoriesState extends State<InterestedCategories> {
  List<bool> values = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  getCategory() {
    switch (widget.index) {
      case 0:
        return 'Restaurant / Food & Dining';
      case 1:
        return 'Restaurant / Wine & Spirits';
      case 2:
        return 'Shopping / Bags';
      case 3:
        return 'Shopping / Beauty & Health';
      case 4:
        return 'Shopping / Electronics';
      case 5:
        return 'Shopping / Home Decor';
      case 6:
        return 'Shopping / Men\'s';
      case 7:
        return 'Shopping / Sports';
      case 8:
        return 'Shopping / Supermarket';
      case 9:
        return 'Shopping / Women\'s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getCategory(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Switch(
            onChanged: (val) {
              setState(() {
                values[widget.index] = val;
              });
            },
            value: values[widget.index],
            activeColor: Color(0xff53B6BB),
            activeTrackColor: Color(0xffc9e1e3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
