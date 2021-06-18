import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import '../config.dart';
import '../constants.dart';

class ScaleAndFadeTransformer extends PageTransformer {
  final double _scale;
  final double _fade;

  ScaleAndFadeTransformer({double fade: 0.3, double scale: 0.8})
      : _fade = fade,
        _scale = scale;

  @override
  Widget transform(Widget item, TransformInfo info) {
    double position = info.position;
    double scaleFactor = (1 - position.abs()) * (1 - _scale);
    double fadeFactor = (1 - position.abs()) * (1 - _fade);
    double opacity = _fade + fadeFactor;
    double scale = _scale + scaleFactor;
    return new Opacity(
      opacity: opacity,
      child: new Transform.scale(
        scale: scale,
        child: item,
      ),
    );
  }
}

class EventDetails extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EventDetails> {
  int _index = 0;
  IndexController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new IndexController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MenuNew(
        title: 'WELCOME TO LEVEL\n1 BLOEM PLAZA',
        physics: NeverScrollableScrollPhysics(),
        children: [
          SliverToBoxAdapter(
            child: Container(
              height: App.height(context),
              child: TransformerPageView(
                controller: _controller,
                loop: false,
                index: _index,
                onPageChanged: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                transformer: ScaleAndFadeTransformer(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Stack(
                      children: [
                        Container(
                          height: App.height(context) - 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/about_mall.jpg',
                                height: 180,
                                width: App.width(context),
                                fit: BoxFit.cover,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome To Level 1 Bloem Plaza',
                                      style: GoogleFonts.ubuntuCondensed()
                                          .copyWith(
                                        color: black.withOpacity(0.7),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text('29-Dec'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Text('26-Jun'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Stay safe & sanitise SA style!',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 156,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                bottomButton(1),
                                bottomButton(2),
                                bottomButton(3),
                                bottomButton(4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container bottomButton(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Icon(
              (index == 1)
                  ? Icons.remove_red_eye
                  : (index == 2)
                      ? Icons.watch_later_outlined
                      : (index == 3)
                          ? Icons.share
                          : Icons.calendar_today,
              size: 25,
              color: Colors.grey[700],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              (index == 2)
                  ? '06:00'
                  : (index == 4)
                      ? 'Add'
                      : '0',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
