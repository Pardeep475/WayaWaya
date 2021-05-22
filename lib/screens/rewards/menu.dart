import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/screens/rewards/qr_code_scanner.dart';
import '../settings.dart';
import './../../config.dart';
import './../../constants.dart';
import './../home.dart';
import 'rewards_new.dart';
import 'package:wayawaya/widgets/custom_app_bar.dart';
import 'package:wayawaya/widgets/home_menu_button.dart';
import '../events_list.dart';
import '../login.dart';
import '../mall_servies.dart';
import '../map/mall_map.dart';
import '../offers_list.dart';
import '../search_page.dart';
import '../shops_and_rest_list.dart';

///SEARCH PAGE & SHOP DOESN'T USE THIS CLASS

class Menu extends StatefulWidget {
  @required
  final String title;
  final bool isSliver;
  final Function onSnowTap;
  final Function onSettingsTap;
  final Function onSearchTap;
  final EdgeInsets padding;
  final IconButton lastIcon;
  final PreferredSizeWidget bottom;
  final ScrollPhysics physics;
  final double titleSize;
  final bool centerTitle;
  final bool floating;
  final bool pinned;
  final bool snap;
  final List<Widget> normalChildren;
  @required
  final List<Widget> children;

  Menu(
      {this.title,
      this.children,
      this.onSnowTap,
      this.onSettingsTap,
      this.onSearchTap,
      this.padding,
      this.lastIcon,
      this.bottom,
      this.floating,
      this.pinned,
      this.snap,
      this.physics,
      this.isSliver = true,
      this.normalChildren,
      this.centerTitle,
      this.titleSize});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  ScrollController _scrollController;
  List<Widget> _children;
  double _scrollPosition;
  bool showDiamond = false;
  bool menuVisible = true;
  bool showMenuIcon = true;
  bool showSearch = false;
  bool backDrop = false;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  AnimationController animationController;
  Animation degHTranslationAnimation,
      degOTranslationAnimation,
      degETranslationAnimation,
      degSTranslationAnimation,
      degSCTranslationAnimation,
      degRTranslationAnimation,
      degRWTranslationAnimation,
      degTMTranslationAnimation,
      degMMTranslationAnimation;
  Animation rotationAnimation;

  @override
  void initState() {
    if (widget.isSliver == true) {
      setState(() {
        _children = widget.children;
      });
    } else {
      setState(() {
        _children = widget.normalChildren;
      });
    }
    _scrollController = new ScrollController()
      ..addListener(() {
        setState(() {
          _scrollPosition = _scrollController.offset;
        });
        if (_scrollPosition > 0) {
          setState(() {
            menuVisible = false;
          });
        } else {
          setState(() {
            menuVisible = true;
          });
        }
      });
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    degHTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 5.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 5.0),
    ]).animate(animationController);
    degOTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 10.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 15.0)
    ]).animate(animationController);
    degETranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 5.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 25.0)
    ]).animate(animationController);
    degSTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 5.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 35.0)
    ]).animate(animationController);
    degRTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 10.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 45.0)
    ]).animate(animationController);
    degRWTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 15.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 55.0)
    ]).animate(animationController);
    degTMTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 20.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    degMMTranslationAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 25.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 75.0)
    ]).animate(animationController);
    rotationAnimation =
        Tween<double>(begin: 180.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInBack,
    ));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  searchBar() {
    return Container(
      height: 50,
      color: white,
      width: App.width(context),
      child: Row(
        children: [
          ///Back Button
          InkWell(
            onTap: () {
              setState(() {
                showSearch = false;
              });
              FocusScope.of(context).unfocus();
              _searchController.clear();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  CircleAvatar(
                    backgroundColor: white,
                    radius: 20,
                    foregroundImage: AssetImage(
                      'assets/menu_app_ic.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 100,
              child: TextField(
                autofocus: true,
                onSubmitted: (val) {
                  setState(() {
                    showSearch = false;
                  });
                  FocusScope.of(context).unfocus();
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => SearchPage(
                            searchTerm: _searchController.text,
                          ),
                        ),
                      )
                      .whenComplete(() => _searchController.clear());
                },
                controller: _searchController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _searchController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          height: App.height(context),
          width: App.width(context),
          color: bgColor,
          child: widget.isSliver
              ? Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      physics: widget.physics ?? BouncingScrollPhysics(),
                      slivers: [
                        MyAppBar(
                          title: widget.title,
                          centerTitle: widget.centerTitle ?? false,
                          padding: widget.padding ?? null,
                          titleSize: widget.titleSize ?? 14,
                          onSnowTap: widget.onSnowTap ??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => Login()),
                                  ),
                          onSettingsTap: widget.onSettingsTap ??
                              () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Settings()),
                                  ),
                          onSearchTap: widget.onSearchTap ??
                              () {
                                setState(() {
                                  showSearch = true;
                                });
                              },
                        ),
                        ..._children,
                      ],
                    ),

                    ///MENU OPTIONS
                    Visibility(
                      visible: backDrop,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showMenuIcon = !showMenuIcon;
                            backDrop = !backDrop;
                          });
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                        child: Container(
                          height: App.height(context),
                          width: App.width(context),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.66),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showDiamond,
                      maintainState: false,
                      child: Container(
                        height: App.height(context),
                        width: App.width(context),
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            ///HOME
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-310),
                                  degHTranslationAnimation.value * 210),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degHTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.amber,
                                  text: 'Home',
                                  icon: Icon(
                                    FontAwesomeIcons.home,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: HomeScreen(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///OFFERS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-290),
                                  degOTranslationAnimation.value * 247),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degOTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.blue[400],
                                  text: 'Offers',
                                  icon: Image.asset(
                                    'assets/offers.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: OffersList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///EVENTS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-307),
                                  degETranslationAnimation.value * 296),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degETranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Color(0xff595286),
                                  text: 'Events',
                                  icon: Icon(
                                    FontAwesomeIcons.calendar,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: EventsList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///SHOPS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-277),
                                  degSTranslationAnimation.value * 310),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degSTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.green[600],
                                  text: 'Shops',
                                  icon: Image.asset(
                                    'assets/shop.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: ShopRestList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///REWARDS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-282),
                                  degRWTranslationAnimation.value * 394),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degRWTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Color(0xffBA3246),
                                  text: 'Rewards',
                                  icon: Icon(
                                    FontAwesomeIcons.tags,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: RewardsBrowser(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///MALL MAP
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-286),
                                  degMMTranslationAnimation.value * 480),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degMMTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.blue[600],
                                  text: 'Mall Map',
                                  icon: Icon(
                                    FontAwesomeIcons.map,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: MapScreen(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///RESTAURANT
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-306),
                                  degRTranslationAnimation.value * 385),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degRTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.yellow[600],
                                  text: 'Restaurant',
                                  icon: Image.asset(
                                    'assets/restaurant.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: ShopRestList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///THE MALL
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-295),
                                  degTMTranslationAnimation.value * 424),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degTMTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Color(0xff595286),
                                  text: 'The Mall',
                                  icon: Image.asset(
                                    'assets/mall.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: MallServices(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///APP ICON
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-294),
                                  degHTranslationAnimation.value * 348),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degHTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: QRScanner(),
                                    );
                                  },
                                  child: Container(
                                    height: 58,
                                    width: 58,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.black,
                                            spreadRadius: 5)
                                      ],
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/qr_scan.png',
                                        height: 44,
                                        width: 44,
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

                    ///MAIN BUTTON
                    Visibility(
                      visible: menuVisible,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 20),
                        child: MenuButton(
                          color: Color(0xff57B9BE),
                          size: 28.5,
                          child: Center(
                            child: Visibility(
                              visible: showMenuIcon,
                              child: Image.asset(
                                'assets/rhombus.PNG',
                                height: 38,
                                width: 38,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          onClick: () {
                            ///Animation here
                            setState(() {
                              showMenuIcon = !showMenuIcon;
                              showDiamond = !showDiamond;
                              backDrop = !backDrop;
                            });
                            printY(showDiamond.toString());
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ),
                      ),
                    ),

                    ///SEARCH
                    Align(
                      alignment: Alignment.topCenter,
                      child: Visibility(
                        visible: showSearch,
                        child: searchBar(),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    ..._children,

                    ///MENU OPTIONS
                    Visibility(
                      visible: backDrop,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showMenuIcon = !showMenuIcon;
                            backDrop = !backDrop;
                          });
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                        child: Container(
                          height: App.height(context),
                          width: App.width(context),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.66),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showDiamond,
                      maintainState: false,
                      child: Container(
                        height: App.height(context),
                        width: App.width(context),
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            ///HOME
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-310),
                                  degHTranslationAnimation.value * 210),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degHTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.amber,
                                  text: 'Home',
                                  icon: Icon(
                                    FontAwesomeIcons.home,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: HomeScreen(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///OFFERS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-290),
                                  degOTranslationAnimation.value * 247),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degOTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.blue[400],
                                  text: 'Offers',
                                  icon: Image.asset(
                                    'assets/offers.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: OffersList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///EVENTS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-307),
                                  degETranslationAnimation.value * 296),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degETranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Color(0xff595286),
                                  text: 'Events',
                                  icon: Icon(
                                    FontAwesomeIcons.calendar,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: EventsList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///SHOPS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-277),
                                  degSTranslationAnimation.value * 310),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degSTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.green[600],
                                  text: 'Shops',
                                  icon: Image.asset(
                                    'assets/shop.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: ShopRestList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///REWARDS
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-282),
                                  degRWTranslationAnimation.value * 394),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degRWTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Color(0xffBA3246),
                                  text: 'Rewards',
                                  icon: Icon(
                                    FontAwesomeIcons.tags,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: RewardsBrowser(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///MALL MAP
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-286),
                                  degMMTranslationAnimation.value * 480),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degMMTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.blue[600],
                                  text: 'Mall Map',
                                  icon: Icon(
                                    FontAwesomeIcons.map,
                                    color: white,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: MapScreen(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///RESTAURANT
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-306),
                                  degRTranslationAnimation.value * 385),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degRTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Colors.yellow[600],
                                  text: 'Restaurant',
                                  icon: Image.asset(
                                    'assets/restaurant.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: ShopRestList(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///THE MALL
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-295),
                                  degTMTranslationAnimation.value * 424),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degTMTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: MenuButton(
                                  color: Color(0xff595286),
                                  text: 'The Mall',
                                  icon: Image.asset(
                                    'assets/mall.png',
                                    height: 25,
                                    width: 26,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onClick: () {
                                    ///Animation here
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: MallServices(),
                                    );
                                  },
                                ),
                              ),
                            ),

                            ///APP ICON
                            Transform.translate(
                              offset: Offset.fromDirection(
                                  getRadiansFromDegree(-294),
                                  degHTranslationAnimation.value * 348),
                              child: Transform(
                                transform: Matrix4.rotationZ(
                                    getRadiansFromDegree(
                                        rotationAnimation.value))
                                  ..scale(degHTranslationAnimation.value),
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showMenuIcon = !showMenuIcon;
                                      showDiamond = !showDiamond;
                                      backDrop = !backDrop;
                                    });
                                    if (animationController.isCompleted) {
                                      animationController.reverse();
                                    } else {
                                      animationController.forward();
                                    }
                                    App.pushTo(
                                      context: context,
                                      screen: QRScanner(),
                                    );
                                  },
                                  child: Container(
                                    height: 58,
                                    width: 58,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.black,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/qr_scan.png',
                                        height: 44,
                                        width: 44,
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

                    ///MAIN BUTTON
                    Visibility(
                      visible: menuVisible,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, left: 20),
                        child: MenuButton(
                          color: Color(0xff57B9BE),
                          size: 28.5,
                          child: Center(
                            child: Visibility(
                              visible: showMenuIcon,
                              child: Image.asset(
                                'assets/rhombus.PNG',
                                height: 38,
                                width: 38,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          onClick: () {
                            ///Animation here
                            setState(() {
                              showMenuIcon = !showMenuIcon;
                              showDiamond = !showDiamond;
                              backDrop = !backDrop;
                            });
                            printY(showDiamond.toString());
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ),
                      ),
                    ),

                    ///SEARCH
                    Align(
                      alignment: Alignment.topCenter,
                      child: Visibility(
                        visible: showSearch,
                        child: searchBar(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
