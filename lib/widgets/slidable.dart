import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wayawaya/utils/app_images.dart';
import '../constants.dart';

class Slide extends StatefulWidget {
  const Slide({Key key}) : super(key: key);

  @override
  _SlideState createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              AppImages.splash_screen_bg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 130,
                      child: Image.asset(
                        AppImages.menu_app_ic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: Image.asset(
                        'assets/dobsonville.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (_) => OffersList(),
                            //   ),
                            // )
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/rewards.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (_) => EventsList(),
                            //   ),
                            // )
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/about_mall.jpg',
                                ),
                                fit: BoxFit.cover,
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
        ),
      ),
      secondaryActions: <Widget>[
        SlideAction(
          color: appLightColor,
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://graphicriver.img.customer.envatousercontent.com/files/278099749/preview_13070075.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=d79f2ef088cc37d58faa7f986a62f148',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://image.freepik.com/free-vector/music-event-horizontal-poster-flyer-template-with-gradient-colorful-design_85212-212.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
