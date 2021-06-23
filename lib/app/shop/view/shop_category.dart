import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expandable_card.dart';

class ShopCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopCategoryScreenState();
}

class _ShopCategoryScreenState extends State<ShopCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ExpandableCards(
            index: index,
          );
        });
  }
}
