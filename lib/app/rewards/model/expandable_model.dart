import 'package:wayawaya/app/rewards/model/child_expandable_model.dart';
import 'package:wayawaya/app/rewards/model/header_expandable_model.dart';

class ExpandableModel {
  HeaderExpandableModel headerExpandableModel;
  List<ChildExpandableModel> childExpandableModel;

  ExpandableModel({this.headerExpandableModel, this.childExpandableModel});
}
