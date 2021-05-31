import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/screens/splash.dart';
import '../config.dart';
import '../constants.dart';
import 'background.dart';
import 'home.dart';

class SelectMall extends StatefulWidget {
  final bool onlyChangeMall;

  const SelectMall({Key key, this.onlyChangeMall = false}) : super(key: key);
  @override
  _SelectMallState createState() => _SelectMallState();
}

class _SelectMallState extends State<SelectMall> {
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

  getMallName(int index) {
    switch (index) {
      case 0:
        return 'Dobsonville Mall';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appDarkColor,
        centerTitle: true,
        title: Text(
          'Select Your Default Mall',
          style: GoogleFonts.roboto().copyWith(
            color: white,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/SplashScreen_BG.jpg',
          ),
          fit: BoxFit.cover,
        )),
        child: ListView.separated(
            itemCount: 12,
            separatorBuilder: (_, index) {
              return Container(
                height: 6,
                color: appDarkColor.withOpacity(0.2),
              );
            },
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  App.prefs.setBool('defaultMall', true);
                  App.prefs.setString('selectedMall', getMallName(index).toString());
                  printR(App.prefs.getString('selectedMall').toString());
                  widget.onlyChangeMall ? Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (_) => Splash(),
                  ), (route) => false) : Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (_) => BackgroundScreen(),
                  ), (route) => false);
                },
                child: Container(
                  height: 125,
                  width: App.width(context),
                  color: Color(0xff6CD1D5).withOpacity(0.5),
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 90,
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              getMallLogo(index).toString(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 2),
                          child: Text(
                            getMallName(index).toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
