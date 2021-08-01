import 'dart:convert';

import 'package:expandable_group/expandable_group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wayawaya/app/auth/login/model/user_data_response.dart';
import 'package:wayawaya/app/common/full_screen_enter_points_to_redeem_dialog.dart';
import 'package:wayawaya/app/common/full_screen_loyalty_info_dialog.dart';
import 'package:wayawaya/app/common/full_screen_not_an_vanue_dialog.dart';
import 'package:wayawaya/app/common/menu/animate_app_bar.dart';
import 'package:wayawaya/app/common/menu/model/main_menu_permission.dart';
import 'package:wayawaya/app/rewards/bloc/loyalty_bloc.dart';
import 'package:wayawaya/app/rewards/model/child_expandable_model.dart';
import 'package:wayawaya/app/rewards/model/header_expandable_model.dart';
import 'package:wayawaya/network/local/profile_database_helper.dart';
import 'package:wayawaya/network/local/sync_service.dart';
import 'package:wayawaya/network/model/loyalty/loyalty_points.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';

import 'model/expandable_model.dart';
import 'model/loyalty_points.dart';

class LoyaltyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  LoyaltyBloc _loyaltyBloc;

  @override
  void initState() {
    _loyaltyBloc = LoyaltyBloc();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loyaltyBloc.setUpGestureLoyalty();
      _loyaltyBloc.setTotalBalance();
      _loyaltyBloc.syncLoyalty();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.push(context, FullScreenLoyaltyInfoDialog());
            },
            child: Container(
              child: Icon(
                Icons.info_outline,
                color: Color(0xff1774E6),
                size: Dimens.forty,
              ),
            ),
          ),
          body: Stack(
            children: [
              StreamBuilder<List<MainMenuPermission>>(
                  initialData: [],
                  stream: _loyaltyBloc.mainMenuPermissionStream,
                  builder: (context, snapshot) {
                    return AnimateAppBar(
                      title: 'Home/Rewards/Wallet',
                      isSliver: true,
                      physics: ClampingScrollPhysics(),
                      mainMenuPermissions: snapshot.data,
                      children: [
                        SliverToBoxAdapter(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            height: Dimens.twoHundredFifty,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    AppImages.ic_loyelty_chart_banner),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              height: Dimens.twoHundred,
                              width: Dimens.twoHundred,
                              child: StreamBuilder<LoyaltyPoints>(
                                  stream: _loyaltyBloc.pieChartStream,
                                  builder: (context, snapshot) {
                                    if (snapshot == null ||
                                        snapshot.data == null) {
                                      final List<ChartData> chartData = [
                                        ChartData(
                                            '100', 100, AppColor.pieChartColor),
                                        ChartData('', 0,
                                            AppColor.percentagePieXhartColor),
                                      ];
                                      return SfCircularChart(
                                        margin: EdgeInsets.all(0),
                                        annotations: <CircularChartAnnotation>[
                                          CircularChartAnnotation(
                                            width: "93%",
                                            height: "93%",
                                            widget: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black26,
                                                  shape: BoxShape.circle),
                                              height: Dimens.twoHundred,
                                              width: Dimens.twoHundred,
                                              padding:
                                                  EdgeInsets.all(Dimens.five),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    '0',
                                                    style: GoogleFonts
                                                            .ubuntuCondensed()
                                                        .copyWith(
                                                      color: AppColor
                                                          .pieChartTextColor,
                                                      fontSize: Dimens.thirty,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Available',
                                                    style: GoogleFonts
                                                            .ubuntuCondensed()
                                                        .copyWith(
                                                      color: AppColor
                                                          .pieChartTextColor,
                                                      fontSize:
                                                          Dimens.seventeen,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        series: <CircularSeries>[
                                          DoughnutSeries<ChartData, String>(
                                              dataSource: chartData,
                                              enableSmartLabels: true,
                                              enableTooltip: true,
                                              sortingOrder:
                                                  SortingOrder.ascending,
                                              dataLabelMapper: (data, __) =>
                                                  '${data.x}',
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                textStyle: TextStyle(
                                                    fontSize: Dimens.forteen,
                                                    color: AppColor
                                                        .pieChartTextColor),
                                                isVisible: true,
                                                labelIntersectAction:
                                                    LabelIntersectAction.none,
                                                labelAlignment:
                                                    ChartDataLabelAlignment.top,
                                                connectorLineSettings:
                                                    ConnectorLineSettings(
                                                  length: '10',
                                                  type: ConnectorType.curve,
                                                  width: 2,
                                                ),
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .inside,
                                              ),
                                              pointColorMapper:
                                                  (ChartData data, _) =>
                                                      data.color,
                                              xValueMapper:
                                                  (ChartData data, _) => data.x,
                                              yValueMapper:
                                                  (ChartData data, _) => data.y,
                                              innerRadius: '55%',
                                              radius: "80%")
                                        ],
                                      );
                                    }
                                    final List<ChartData> dynamicChartData = [
                                      ChartData(
                                          snapshot.data.availablePoints
                                              .toString(),
                                          snapshot.data.availablePoints
                                              .toDouble(),
                                          AppColor.pieChartColor),
                                      ChartData(
                                          snapshot.data.redeemed != 0
                                              ? snapshot.data.redeemed
                                                  .toString()
                                              : "",
                                          snapshot.data.redeemed.toDouble(),
                                          AppColor.percentagePieXhartColor),
                                    ];
                                    return SfCircularChart(
                                      margin: EdgeInsets.all(0),
                                      annotations: <CircularChartAnnotation>[
                                        CircularChartAnnotation(
                                          width: "93%",
                                          height: "93%",
                                          widget: Container(
                                            height: Dimens.twoHundred,
                                            width: Dimens.twoHundred,
                                            decoration: BoxDecoration(
                                                color: Colors.black26,
                                                shape: BoxShape.circle),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  snapshot.data.availablePoints
                                                      .toString(),
                                                  style: GoogleFonts
                                                          .ubuntuCondensed()
                                                      .copyWith(
                                                    color: AppColor
                                                        .pieChartTextColor,
                                                    fontSize: Dimens.forty,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Available',
                                                  style: GoogleFonts
                                                          .ubuntuCondensed()
                                                      .copyWith(
                                                    color: AppColor
                                                        .pieChartTextColor,
                                                    fontSize: Dimens.seventeen,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartData, String>(
                                            dataSource: dynamicChartData,
                                            enableSmartLabels: true,
                                            enableTooltip: true,
                                            sortingOrder:
                                                SortingOrder.ascending,
                                            dataLabelMapper: (data, __) =>
                                                '${data.x}',
                                            dataLabelSettings:
                                                DataLabelSettings(
                                              textStyle: TextStyle(
                                                  fontSize: Dimens.forteen,
                                                  color: AppColor
                                                      .pieChartTextColor),
                                              isVisible: true,
                                              labelIntersectAction:
                                                  LabelIntersectAction.none,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.top,
                                              connectorLineSettings:
                                                  ConnectorLineSettings(
                                                length: '10',
                                                type: ConnectorType.curve,
                                                width: 2,
                                              ),
                                              labelPosition:
                                                  ChartDataLabelPosition.inside,
                                            ),
                                            pointColorMapper:
                                                (ChartData data, _) =>
                                                    data.color,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                            innerRadius: '55%',
                                            radius: "80%")
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Card(
                            elevation: Dimens.five,
                            margin: EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimens.ten),
                                  child: StreamBuilder<LoyaltyPointsModel>(
                                      initialData: LoyaltyPointsModel(
                                          points: "0", status: 1),
                                      stream: _loyaltyBloc.totalPointStream,
                                      builder: (context, snapshot) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Dimens.five,
                                            ),
                                            Text(
                                              AppString.membership,
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.ubuntuCondensed()
                                                      .copyWith(
                                                color: AppColor.black,
                                                fontSize: Dimens.thirty,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: Dimens.three,
                                            // ),
                                            // snapshot.data.status > 0
                                            //     ? IconShadowWidget(
                                            //         Icon(Icons.star,
                                            //             color: Colors.yellow,
                                            //             size: 36),
                                            //       )
                                            //     : SizedBox(),
                                            // SizedBox(
                                            //   width: snapshot.data.status > 0
                                            //       ? Dimens.three
                                            //       : 0,
                                            // ),
                                            // snapshot.data.status > 1
                                            //     ? IconShadowWidget(
                                            //         Icon(Icons.star,
                                            //             color: Colors.yellow,
                                            //             size: 36),
                                            //       )
                                            //     : SizedBox(),
                                            // SizedBox(
                                            //   width: snapshot.data.status > 1
                                            //       ? Dimens.three
                                            //       : 0,
                                            // ),
                                            // snapshot.data.status > 2
                                            //     ? IconShadowWidget(
                                            //         Icon(Icons.star,
                                            //             color: Colors.yellow,
                                            //             size: 36),
                                            //       )
                                            //     : SizedBox(),
                                            Expanded(
                                              child: SizedBox(),
                                            ),
                                            Text(
                                              snapshot.data.points ?? "",
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.ubuntuCondensed()
                                                      .copyWith(
                                                color: AppColor.black,
                                                fontSize: Dimens.thirty,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimens.twenty,
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                                Divider(
                                  height: Dimens.one,
                                  color: AppColor.rowDivider,
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    await _scannerFunctionality(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimens.ten),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Dimens.five,
                                        ),
                                        IconShadowWidget(
                                          Icon(Icons.qr_code_scanner_sharp,
                                              color: Colors.black, size: 36),
                                        ),
                                        SizedBox(
                                          width: Dimens.ten,
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppString.scan,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.ubuntuCondensed()
                                                .copyWith(
                                              color: AppColor.black,
                                              fontSize: Dimens.twentyFour,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: StreamBuilder<List<ExpandableModel>>(
                              initialData: null,
                              stream: _loyaltyBloc.expandableListStream,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: Dimens.forty,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: Dimens.thirty,
                                          width: Dimens.thirty,
                                          child: CircularProgressIndicator(
                                            strokeWidth: Dimens.two,
                                            backgroundColor:
                                                AppColor.primaryDark,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimens.ten,
                                        ),
                                        Text(
                                          AppString.processing_data,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: Dimens.forteen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.data.isEmpty) {
                                  return Wrap(
                                    children: [
                                      Card(
                                        color: AppColor.white,
                                        elevation: 2,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimens.thirty),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            AppString.no_record_found,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.ubuntuCondensed()
                                                .copyWith(
                                              color: AppColor.black
                                                  .withOpacity(0.7),
                                              fontSize: Dimens.nineteen,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          bottom: Dimens.thirty),
                                      itemBuilder: (context, index) {
                                        return ExpandableGroup(
                                          header: _header(snapshot.data[index]
                                              .headerExpandableModel),
                                          items: _buildItems(
                                              context,
                                              snapshot.data[index]
                                                  .childExpandableModel),
                                        );
                                      });
                                }
                              }),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: Dimens.forty,
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
        StreamBuilder<bool>(
            initialData: false,
            stream: _loyaltyBloc.gestureLoyaltyStream,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () async {
                      SessionManager.setGestureLoyalty(false);
                      _loyaltyBloc.gestureLoyaltySink.add(false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.66),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.19,
                            left: Dimens.thirty,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  gestureH(text: AppString.earn_points),
                                  gestureH(text: AppString.available_points),
                                  gestureH(text: AppString.redeemed_points),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.51,
                            left: 0,
                            child:
                                gestureH(text: AppString.show_details_new_line),
                          ),

                          Positioned(
                            right: 0,
                            top: MediaQuery.of(context).size.height * 0.4,
                            child: gestureV(text: AppString.your_points),
                          ),
                          Positioned(
                            bottom: Dimens.forty,
                            right: Dimens.twentyFive,
                            child: gestureH(text: AppString.help),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            }),
      ],
    );
  }

  Widget _header(HeaderExpandableModel headerExpandableModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Dimens.sixteen,
        ),
        Text(
          headerExpandableModel.date ?? "",
          style: GoogleFonts.ubuntuCondensed().copyWith(
            color: AppColor.black.withOpacity(0.7),
            fontSize: Dimens.thirty,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.8,
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BALANCE',
              style: GoogleFonts.ubuntuCondensed().copyWith(
                color: AppColor.black.withOpacity(0.7),
                fontSize: Dimens.eighteen,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ),
            ),
            SizedBox(
              height: Dimens.two,
            ),
            Text(
              headerExpandableModel.points ?? "",
              style: GoogleFonts.ubuntuCondensed().copyWith(
                color: AppColor.black.withOpacity(0.7),
                fontSize: Dimens.thirty,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ),
            ),
          ],
        )
      ],
    );
  }

  List<Widget> _buildItems(
          BuildContext context, List<ChildExpandableModel> items) =>
      items
          .map(
            (e) => ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: Dimens.three, horizontal: Dimens.twenty),
              title: ItemChildExpandable(
                childExpandableModel: e,
              ),
            ),
          )
          .toList();

  Container gestureV({String text}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: Dimens.fiftyFive,
            width: Dimens.fiftyFive,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.touch_u,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: Dimens.twentyTwo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container gestureH({String text}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: Dimens.twentyTwo,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: Dimens.ten,
          ),
          Container(
            height: Dimens.fiftyFive,
            width: Dimens.fiftyFive,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.touch_r,
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _scannerFunctionality(BuildContext context) async {
    debugPrint("scanner_functionality");
    bool isUserInMall = await checkIfUserInMall();
    if (isUserInMall) {
      Navigator.pushNamed(context, AppString.QR_SCANNER_SCREEN_ROUTE)
          .then((value) async {
        if (value != null) {
          try {
            Barcode scanData = value as Barcode;
            dynamic jsonScanData = jsonDecode(scanData.code);
            String rid = "";
            String type = "";
            String points = "";
            rid = jsonScanData["shop_id"];
            type = jsonScanData["type"];
            points = jsonScanData["points"];
            if (Utils.checkNullOrEmpty(rid)) return;
            if (Utils.checkNullOrEmpty(type)) return;
            bool isUserInMall = await checkIfUserInMall();
            if (!isUserInMall) {
              Navigator.push(
                context,
                FullScreenNotAnVenueDialog(),
              );
              return;
            }
            bool checkRetailUnitByID =
            await ProfileDatabaseHelper.checkRetailUnitByRid(rid);
            if (checkRetailUnitByID) {
              if (type.toLowerCase() == "store_visit".toLowerCase()) {
                if (Utils.checkNullOrEmpty(points)) {
                  // LoyaltyUtil.setStoreVisitLoyaltyPoints(mDataManager.getPreferencesHelper(), rid);
                  SyncService.updateStoreVisitLoyaltyPoints(context: context);
                } else {
                  SyncService.updateStoreVisitQRPoints(
                      context: context,
                      points: int.parse(points),
                      shop_id: rid);
                }
              } else if (type.toLowerCase() == "redemption".toLowerCase()) {
                // redeem points
                Navigator.push(
                  context,
                  FullScreenEnterPointsToRedeemDialog(
                      onPressed: (points) async {
                        int totalPoints = await getLoyaltyPointsForRedeem();
                        if (points != 0) {
                          if (points > totalPoints) {
                            Navigator.push(
                              context,
                              FullScreenNotAnVenueDialog(
                                  title: AppString.error,
                                  content: AppString.no_sufficient_points),
                            );
                          } else {
                            SyncService.redeemLoyaltyPoints(
                                context: context, shop_id: rid, points: points);
                          }
                        } else {
                          Navigator.push(
                            context,
                            FullScreenNotAnVenueDialog(
                                title: AppString.error,
                                content: AppString.no_points_entered),
                          );
                        }
                      }),
                );
              }
            } else {
              Navigator.push(
                context,
                FullScreenNotAnVenueDialog(
                    content: AppString.no_shop_available),
              );
            }
          } catch (e) {
            Navigator.push(
              context,
              FullScreenNotAnVenueDialog(content: e.toString()),
            );
          }
        }
      });
    } else {
      Navigator.push(
        context,
        FullScreenNotAnVenueDialog(),
      );
    }
  }

  Future<int> getLoyaltyPointsForRedeem() async {
    String userData = await SessionManager.getUserData();
    UserDataResponse _response = userDataResponseFromJson(userData);
    if (_response == null) return 0;
    if (_response.loyaltyStatus == null) return 0;
    dynamic loyaltyStatus = jsonDecode(_response.loyaltyStatus);
    if (loyaltyStatus['points'] == null) return 0;
    return loyaltyStatus['points'];
  }

  Future<bool> checkIfUserInMall() async {
    bool isUserInMall = await SessionManager.getUserInMall();
    return isUserInMall ?? false;
  }

}

class ItemChildExpandable extends StatelessWidget {
  final ChildExpandableModel childExpandableModel;

  ItemChildExpandable({this.childExpandableModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          childExpandableModel.iconData,
        ),
        SizedBox(
          width: Dimens.five,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                childExpandableModel.date ?? "",
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: AppColor.black.withOpacity(0.7),
                  fontSize: Dimens.twentyFour,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(
                height: Dimens.two,
              ),
              Text(
                childExpandableModel.description ?? "",
                maxLines: 1,
                style: GoogleFonts.ubuntuCondensed().copyWith(
                  color: AppColor.black.withOpacity(0.7),
                  fontSize: Dimens.eighteen,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: Dimens.five,
        ),
        Text(
          childExpandableModel.points ?? "",
          style: GoogleFonts.ubuntuCondensed().copyWith(
            color: AppColor.black.withOpacity(0.7),
            fontSize: Dimens.thirty,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color color;
}
