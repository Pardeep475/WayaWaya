import 'package:flutter/material.dart';
import 'package:wayawaya/screens/map/mall_map.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import '../config.dart';
import '../constants.dart';

class MallServices extends StatefulWidget {
  const MallServices({Key key}) : super(key: key);

  @override
  _MallServicesState createState() => _MallServicesState();
}

class _MallServicesState extends State<MallServices> {
  getServiceName(int index) {
    switch (index) {
      case 0:
        return 'Info Desk';
      case 1:
        return 'ATMs';
      case 2:
        return 'Stairs';
      case 3:
        return 'Centre Management';
      case 4:
        return 'Entrances';
      case 5:
        return 'Fire Escapes';
      case 6:
        return 'Delivery Gate';
      case 7:
        return 'Benches';
      case 8:
        return 'Restaurants';
      case 9:
        return 'Recycling';
      case 10:
        return 'Taxi Rank';
      case 11:
        return 'Security House';
      case 12:
        return 'Elevators';
      case 13:
        return 'Parking';
      case 14:
        return 'Assembly Points';
    }
  }

  Widget serviceCard(int index) {
    return InkWell(
      onTap: () => App.pushTo(context: context, screen: MapScreen()),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Color(0xff00B6B7),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 3,
            ),
            Image.asset(
              'assets/ic_${index + 1}.png',
              height: 76,
              width: 76,
              color: Colors.white.withOpacity(0.6),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              getServiceName(index),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MenuNew(
      title: 'EVENTS',
      children: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(1.5, 3, 1.5, 0),
                child: serviceCard(index),
              );
            },
            childCount: 15,
          ),
        ),
      ],
    );
  }
}
