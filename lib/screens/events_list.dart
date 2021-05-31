import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayawaya/config.dart';
import 'package:wayawaya/screens/event_details.dart';
import 'package:wayawaya/screens/rewards/menu.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:wayawaya/screens/rewards/menunew.dart';
import '../constants.dart';

class EventsList extends StatefulWidget {
  const EventsList({Key key}) : super(key: key);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  Widget eventCard(int index) {
    return InkWell(
      onTap: () => App.pushTo(context: context, screen: EventDetails()),
      child: Container(
        height: 263,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.grey, spreadRadius: 2)
          ],
        ),
        child: Wrap(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              child: Image.network(
                index % 2 == 0
                    ? 'https://www.cbia.com/wp-content/uploads/2020/05/Social-Distancing.png'
                    : 'https://www.cdc.gov/handwashing/images/twitter-cards/poster-handwashing.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    index % 2 == 0 ? 'Social Distancing' : 'Wash your hands',
                    style: GoogleFonts.ubuntuCondensed().copyWith(
                      color: black.withOpacity(0.7),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                height: 5,
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

                        ///BUTTONS
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: black,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Share'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  final Event event = Event(
                                    title: 'Social Distancing',
                                    description: 'Event description',
                                    location: 'Event location',
                                    startDate: DateTime.now(),
                                    endDate: DateTime(DateTime.december),
                                    iosParams: IOSParams(
                                      reminder: Duration(
                                          /* Ex. hours:1 */), // on iOS, you can set alarm notification after your event.
                                    ),
                                    androidParams: AndroidParams(
                                      emailInvites: [], // on Android, you can add invite emails to your event.
                                    ),
                                  );
                                  Add2Calendar.addEvent2Cal(event);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_sharp,
                                      color: black,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Events'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return eventCard(index);
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
