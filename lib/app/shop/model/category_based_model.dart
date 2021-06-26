import 'package:flutter/material.dart';
import 'package:wayawaya/app/shop/model/retail_with_category.dart';

class CategoryBasedModel {
  String title;
  List<RetailWithCategory> retailWithCategory;
  Color categoryColor;

  CategoryBasedModel({this.title, this.retailWithCategory, this.categoryColor});
}
