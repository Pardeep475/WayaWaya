import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/home.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import 'package:wayawaya/screens/settings.dart';
import '../config.dart';
import '../constants.dart';
import '../widgets/fav_malls.dart';
import '../widgets/interested_cat.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key key}) : super(key: key);

  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  bool _lang = true;
  bool showMalls = false;

  TextStyle _title = GoogleFonts.encodeSansCondensed().copyWith(
    color: black.withOpacity(1),
    fontWeight: FontWeight.w400,
    letterSpacing: 1.1,
    fontSize: 19,
  );
  TextStyle _content = TextStyle(
    color: Colors.grey[600],
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  getMallName(int index) {
    switch (index) {
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

  getMallLogo(int index) {
    switch (index) {
      case 0:
        return 'assets/dobsonville.png';
      case 1:
        return 'assets/hillfox.png';
      case 2:
        return 'assets/durban.png';
      case 3:
        return 'assets/randburg.png';
      case 4:
        return 'assets/atlantis.png';
      case 5:
        return 'assets/hammarsdale.png';
      case 6:
        return 'assets/kolonnade.png';
      case 7:
        return 'assets/bloemfontein.png';
      case 8:
        return 'assets/gugulethu.png';
      case 9:
        return 'assets/mdantsane.png';
      case 10:
        return 'assets/pinecrest.png';
      case 11:
        return 'assets/nonesi.png';
    }
  }

  successDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        content: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'Your preferences saved successfully.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(
                        'HOMEPAGE',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        App.prefs
                            .setBool('homeGestures', true)
                            .whenComplete(() => App.pushTo(
                                  context: context,
                                  screen: HomeScreen(),
                                ));
                      },
                    ),
                    TextButton(
                      child: Text(
                        'SETTINGS',
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        App.pushTo(context: context, screen: Settings());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            MenuNew(
              title: 'PREFERENCES',
              padding: EdgeInsets.only(left: 0, top: 16),
              onSnowTap: () {
                setState(() {
                  showMalls = true;
                });
              },
              children: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 13,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Interested Categories',
                      style: _title,
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 33 * 10.0 + 14,
                        width: App.width(context),
                        margin: EdgeInsets.only(top: 7),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                            itemCount: 10,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              return InterestedCategories(
                                index: index,
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Notification Frequency',
                          style: _title,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          '12 daily',
                          style: _content,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 15, right: 15),
                        child: Text(
                          'Favourite Malls',
                          style: _title,
                        ),
                      ),
                      Container(
                        height: 35 * 12.0 + 20,
                        width: App.width(context),
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: 12,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return FavMall(
                              index: index,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Alternate Currency',
                      style: _title,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 50,
                    width: App.width(context),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.grey[200],
                          margin: EdgeInsets.only(right: 10),
                        ),
                        Text(
                          'ZAR',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ShadowText(
                            'ZA',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Default Language',
                      style: _title,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          margin: EdgeInsets.only(right: 10),
                          child: Checkbox(
                            value: _lang,
                            onChanged: (bool value) {
                              setState(() {
                                _lang = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          'English (UK)',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 20,
                          width: 40,
                          child: Image.asset(
                            'assets/uk_flag.jpg',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: App.width(context),
                    margin: EdgeInsets.only(bottom: 3),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => successDialog(),
                            child: Card(
                              shadowColor: Colors.grey[400],
                              child: Container(
                                height: 50,
                                width: App.width(context) / 2.3,
                                child: Center(
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Card(
                              shadowColor: Colors.grey[400],
                              child: Container(
                                height: 50,
                                width: App.width(context) / 2.3,
                                child: Center(
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            ///MALL OPTIONS
            Visibility(
              visible: showMalls,
              child: InkWell(
                onTap: () {
                  setState(() {
                    showMalls = false;
                  });
                },
                child: Container(
                  height: App.height(context),
                  width: App.width(context),
                  color: Colors.black.withOpacity(0.45),
                  alignment: Alignment.center,
                  child: GridView.builder(
                    itemCount: 12,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => print('Go to Mall'),
                        child: Container(
                          height: 150,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black38,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor: appLightColor,
                                  radius: 36,
                                  child: Image.asset(
                                    getMallLogo(index),
                                    height: 50,
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Center(
                                  child: Text(
                                    getMallName(index),
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.4)),
            ),
          ),
          new BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.0),
            child: Text(data, style: style),
          ),
        ],
      ),
    );
  }
}
