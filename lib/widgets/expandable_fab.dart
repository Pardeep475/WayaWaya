import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/dialogs/common_login_dialog.dart';
import 'package:wayawaya/constants.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/session_manager.dart';

class CircularMenuItem extends StatelessWidget {
  /// if icon and animatedIcon are passed, icon will be ignored
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;
  final double iconSize;
  final double padding;
  final double margin;
  final List<BoxShadow> boxShadow;
  final bool enableBadge;
  final double badgeRightOffet;
  final double badgeLeftOffet;
  final double badgeTopOffet;
  final double badgeBottomOffet;
  final double badgeRadius;
  final TextStyle badgeTextStyle;
  final String badgeLabel;
  final Color badgeTextColor;
  final Color badgeColor;

  /// if animatedIcon and icon are passed, icon will be ignored
  final AnimatedIcon animatedIcon;

  /// creates a menu item .
  /// [onTap] must not be null.
  /// [padding] and [margin]  must be equal or greater than zero.
  CircularMenuItem({
    @required this.onTap,
    this.icon,
    this.color,
    this.iconSize = 25,
    this.boxShadow,
    this.iconColor,
    this.animatedIcon,
    this.padding = 10,
    this.margin = 10,
    this.enableBadge = false,
    this.badgeBottomOffet,
    this.badgeLeftOffet,
    this.badgeRightOffet,
    this.badgeTopOffet,
    this.badgeRadius,
    this.badgeTextStyle,
    this.badgeLabel,
    this.badgeTextColor,
    this.badgeColor,
  })  : assert(onTap != null),
        assert(padding >= 0.0),
        assert(margin >= 0.0);

  Widget _buildCircularMenuItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: color ?? Theme.of(context).primaryColor,
                blurRadius: 10,
              ),
            ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: color ?? Theme.of(context).primaryColor,
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: animatedIcon == null
                  ? Icon(
                      icon,
                      size: iconSize,
                      color: iconColor ?? Colors.white,
                    )
                  : animatedIcon,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  Widget _buildCircularMenuItemWithBadge(BuildContext context) {
    return _Badge(
      color: badgeColor,
      bottomOffset: badgeBottomOffet,
      rightOffset: badgeRightOffet,
      leftOffset: badgeLeftOffet,
      topOffset: badgeTopOffet,
      radius: badgeRadius,
      textStyle: badgeTextStyle,
      onTap: onTap,
      textColor: badgeTextColor,
      label: badgeLabel,
      child: _buildCircularMenuItem(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return enableBadge
        ? _buildCircularMenuItemWithBadge(context)
        : _buildCircularMenuItem(context);
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    Key key,
    @required this.child,
    @required this.label,
    this.color,
    this.textColor,
    this.onTap,
    this.radius,
    this.bottomOffset,
    this.leftOffset,
    this.rightOffset,
    this.topOffset,
    this.textStyle,
  }) : super(key: key);

  final Widget child;
  final String label;
  final Color color;
  final Color textColor;
  final Function onTap;
  final double rightOffset;
  final double leftOffset;
  final double topOffset;
  final double bottomOffset;
  final double radius;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        child,
        Positioned(
          right: (leftOffset == null && rightOffset == null) ? 8 : rightOffset,
          top: (topOffset == null && bottomOffset == null) ? 8 : topOffset,
          left: leftOffset,
          bottom: bottomOffset,
          child: FittedBox(
            child: GestureDetector(
              onTap: onTap ?? () {},
              child: CircleAvatar(
                maxRadius: radius ?? 10,
                minRadius: radius ?? 10,
                backgroundColor: color ?? Theme.of(context).primaryColor,
                child: FittedBox(
                  child: Text(
                    label ?? '',
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 10,
                          color: textColor ?? Theme.of(context).accentColor,
                        ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CircularMenu extends StatefulWidget {
  /// use global key to control animation anywhere in the code
  final GlobalKey<CircularMenuState> key;

  /// list of CircularMenuItem contains at least two items.
  final List<CircularMenuItem> items;

  /// menu alignment
  final AlignmentGeometry alignment;

  /// menu radius
  final double radius;

  /// widget holds actual page content
  final Widget backgroundWidget;

  /// animation duration
  final Duration animationDuration;

  /// animation curve in forward
  final Curve curve;

  /// animation curve in rverse
  final Curve reverseCurve;

  /// callback
  final VoidCallback toggleButtonOnPressed;
  final Color toggleButtonColor;
  final double toggleButtonSize;
  final List<BoxShadow> toggleButtonBoxShadow;
  final double toggleButtonPadding;
  final double toggleButtonMargin;
  final Color toggleButtonIconColor;
  final AnimatedIconData toggleButtonAnimatedIconData;

  /// staring angle in clockwise radian
  final double startingAngleInRadian;

  /// ending angle in clockwise radian
  final double endingAngleInRadian;

  final PageController pageController;

  /// creates a circular menu with specific [radius] and [alignment] .
  /// [toggleButtonElevation] ,[toggleButtonPadding] and [toggleButtonMargin] must be
  /// equal or greater than zero.
  /// [items] must not be null and it must contains two elements at least.
  CircularMenu({
    @required this.items,
    this.alignment = Alignment.bottomCenter,
    this.radius = 100,
    this.backgroundWidget,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.bounceOut,
    this.reverseCurve = Curves.fastOutSlowIn,
    this.toggleButtonOnPressed,
    this.toggleButtonColor,
    this.toggleButtonBoxShadow,
    this.toggleButtonMargin = 10,
    this.toggleButtonPadding = 10,
    this.toggleButtonSize = 40,
    this.toggleButtonIconColor,
    this.pageController,
    this.toggleButtonAnimatedIconData = AnimatedIcons.menu_close,
    this.key,
    this.startingAngleInRadian,
    this.endingAngleInRadian,
  })  : assert(items != null, 'items can not be empty list'),
        assert(items.length > 1, 'if you have one item no need to use a Menu'),
        super(key: key);

  @override
  CircularMenuState createState() => CircularMenuState();
}

class CircularMenuState extends State<CircularMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _completeAngle;
  double _initialAngle;
  double _endAngle;
  double _startAngle;
  int _itemsCount;
  Animation<double> _animation;

  /// forward animation
  void forwardAnimation() {
    _animationController.forward();
  }

  /// reverse animation
  void reverseAnimation() {
    _animationController.reverse();
  }

  @override
  void initState() {
    _configure();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: widget.curve,
          reverseCurve: widget.reverseCurve),
    );
    _itemsCount = widget.items.length;
    super.initState();
  }

  void _configure() {
    if (widget.startingAngleInRadian != null ||
        widget.endingAngleInRadian != null) {
      if (widget.startingAngleInRadian == null) {
        throw ('startingAngleInRadian can not be null');
      }
      if (widget.endingAngleInRadian == null) {
        throw ('endingAngleInRadian can not be null');
      }

      if (widget.startingAngleInRadian < 0) {
        throw 'startingAngleInRadian has to be in clockwise radian';
      }
      if (widget.endingAngleInRadian < 0) {
        throw 'endingAngleInRadian has to be in clockwise radian';
      }
      _startAngle = (widget.startingAngleInRadian / math.pi) % 2;
      _endAngle = (widget.endingAngleInRadian / math.pi) % 2;
      if (_endAngle < _startAngle) {
        throw 'startingAngleInRadian can not be greater than endingAngleInRadian';
      }
      _completeAngle = _startAngle == _endAngle
          ? 2 * math.pi
          : (_endAngle - _startAngle) * math.pi;
      _initialAngle = _startAngle * math.pi;
    } else {
      switch (widget.alignment.toString()) {
        case 'bottomCenter':
          _completeAngle = 1 * math.pi;
          _initialAngle = 1 * math.pi;
          break;
        case 'topCenter':
          _completeAngle = 1 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'centerLeft':
          _completeAngle = 1 * math.pi;
          _initialAngle = 1.5 * math.pi;
          break;
        case 'centerRight':
          _completeAngle = 1 * math.pi;
          _initialAngle = 0.5 * math.pi;
          break;
        case 'center':
          _completeAngle = 2 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'bottomRight':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 1 * math.pi;
          break;
        case 'bottomLeft':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 1.5 * math.pi;
          break;
        case 'topLeft':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 0 * math.pi;
          break;
        case 'topRight':
          _completeAngle = 0.5 * math.pi;
          _initialAngle = 0.5 * math.pi;
          break;
        default:
          throw 'startingAngleInRadian and endingAngleInRadian can not be null';
      }
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    _configure();
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _buildMenuItems() {
    List<Widget> items = [];
    debugPrint('list_of_menu_items:-   ${widget.items.length}');
    widget.items.asMap().forEach((index, item) {
      items.add(
        Positioned.fill(
          child: Align(
            alignment: widget.alignment,
            child: Transform.translate(
              offset: Offset.fromDirection(
                  _completeAngle == (2 * math.pi)
                      ? (_initialAngle +
                          (_completeAngle / (_itemsCount)) * index)
                      : (_initialAngle +
                          (_completeAngle / (_itemsCount - 1)) * index),
                  _animation.value * widget.radius),
              child: Transform.scale(
                scale: _animation.value,
                child: Transform.rotate(
                  angle: _animation.value * (math.pi * 2),
                  child: index == 0
                      ? CircularMenuItem(
                          padding: 18,
                          icon: Icons.sort_by_alpha,
                          onTap: () {
                            debugPrint('click on short by alpha');
                            _animationController.status ==
                                    AnimationStatus.dismissed
                                ? (_animationController).forward()
                                : (_animationController).reverse();
                            if (widget.pageController == null) return;
                            widget.pageController.animateToPage(
                              0,
                              duration: Duration(microseconds: 100),
                              curve: Curves.easeInOut,
                            );
                            // _shopBloc.listTypeSink.add(0);
                            // Navigator.of(context).pushReplacement(
                            //   MaterialPageRoute(
                            //     builder: (_) => ShopRestList(
                            //       title: 'Restaurant',
                            //     ),
                            //   ),
                            // );
                          },
                          color: appLightColor,
                          iconColor: Colors.white,
                        )
                      : index == 1
                          ? CircularMenuItem(
                              padding: 18,
                              icon: Icons.list,
                              onTap: () {
                                debugPrint('click on icon list ');
                                _animationController.status ==
                                        AnimationStatus.dismissed
                                    ? (_animationController).forward()
                                    : (_animationController).reverse();

                                if (widget.pageController == null) return;

                                widget.pageController.animateToPage(
                                  1,
                                  duration: Duration(microseconds: 500),
                                  curve: Curves.easeInOut,
                                );

                                // _shopBloc.listTypeSink.add(1);
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //     builder: (_) => ShopRestCategory(
                                //       title: 'Restaurant',
                                //     ),
                                //   ),
                                // );
                              },
                              color: appLightColor,
                              iconColor: Colors.white,
                            )
                          : CircularMenuItem(
                              padding: 18,
                              icon: Icons.thumb_up,
                              onTap: () async {
                                debugPrint('click on favourte ');
                                _animationController.status ==
                                        AnimationStatus.dismissed
                                    ? (_animationController).forward()
                                    : (_animationController).reverse();
                                if (widget.pageController == null) return;

                                bool isLogin = await SessionManager.isLogin();
                                if(isLogin != null && isLogin){
                                  widget.pageController.animateToPage(
                                    2,
                                    duration: Duration(microseconds: 100),
                                    curve: Curves.easeInOut,
                                  );
                                }else{
                                  _showErrorDialog(
                                    icon: Icon(
                                      FontAwesomeIcons.exclamationTriangle,
                                      color: AppColor.orange_500,
                                    ),
                                    title: AppString.login.toUpperCase(),
                                    content: AppString.currently_not_logged_in,
                                    buttonText: AppString.login.toUpperCase(),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, AppString.LOGIN_SCREEN_ROUTE,arguments: "value");
                                    }
                                  );
                                }

                              },
                              color: appLightColor,
                              iconColor: Colors.white,
                            ),
                ),
              ),
            ),
          ),
        ),
      );
    });
    return items;
  }

  _showErrorDialog(
      {Icon icon,
        String title,
        String content,
        String buttonText,
        VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonLoginDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }


  Widget _buildMenuButton(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: widget.alignment,
        child: CircularMenuItem(
          margin: widget.toggleButtonMargin,
          color: _animationController.status == AnimationStatus.dismissed
              ? AppColor.primary
              : Colors.black45,
          padding: (-_animation.value * widget.toggleButtonPadding * 0.5) +
              widget.toggleButtonPadding,
          onTap: () {
            _animationController.status == AnimationStatus.dismissed
                ? (_animationController).forward()
                : (_animationController).reverse();
            if (widget.toggleButtonOnPressed != null) {
              widget.toggleButtonOnPressed();
            }
          },
          boxShadow: widget.toggleButtonBoxShadow,
          animatedIcon: AnimatedIcon(
            icon: _animationController.status == AnimationStatus.dismissed
                ? AnimatedIcons.add_event
                : widget.toggleButtonAnimatedIconData,
            //AnimatedIcons.menu_close,
            size: widget.toggleButtonSize,
            color: widget.toggleButtonIconColor ?? Colors.white,
            progress: _animation,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.backgroundWidget ?? Container(),
        ..._buildMenuItems(),
        _buildMenuButton(context),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
