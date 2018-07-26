import 'package:flutter/material.dart';

class ChromeFloatingCircles extends StatefulWidget {
  final Color topLeftItemColor;
  final Color topRightItemColor;
  final Color bottomLeftItemColor;
  final Color bottomRightItemColor;

  final BoxShape shape;
  final double size;

  final int duration;

  const ChromeFloatingCircles(
      {Key key,
      @required this.topLeftItemColor,
      @required this.topRightItemColor,
      @required this.bottomLeftItemColor,
      @required this.bottomRightItemColor,
      this.shape = BoxShape.circle,
      this.size = 100.0,
      this.duration = 1000})
      : super(key: key);

  @override
  _ChromeFloatingCirclesState createState() => _ChromeFloatingCirclesState();
}

class _ChromeFloatingCirclesState extends State<ChromeFloatingCircles>
    with TickerProviderStateMixin {
  AnimationController translateAnimationController;
  Animation<double> animation;
  double itemSize;
  Offset topLeftItemOffset;
  Offset topRightItemOffset;
  Offset bottomLeftItemOffset;
  Offset bottomRightItemOffset;

  void initTranslateAnimation() {
    final duration = Duration(milliseconds: widget.duration);

    translateAnimationController =
        AnimationController(vsync: this, duration: duration);

    animation = CurvedAnimation(
        parent: translateAnimationController, curve: Curves.linear);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        translateAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        translateAnimationController.forward();
      }
    });

    animation.addListener(() {
      this.setState(() {});
    });

    translateAnimationController.forward();
  }

  initOffsets() {
    topLeftItemOffset = Offset(animation.value * (widget.size - itemSize),
        animation.value * (widget.size - itemSize));
    topRightItemOffset = Offset(
        (1 - animation.value) * (widget.size - itemSize),
        animation.value * (widget.size - itemSize));
    bottomLeftItemOffset = Offset(animation.value * (widget.size - itemSize),
        (1 - animation.value) * (widget.size - itemSize));
    bottomRightItemOffset = Offset(
        (1 - animation.value) * (widget.size - itemSize),
        (1 - animation.value) * (widget.size - itemSize));
  }

  @override
  void initState() {
    super.initState();

    initTranslateAnimation();

    itemSize = widget.size * 0.25;
  }

  @override
  void dispose() {
    super.dispose();

    translateAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Stack(
          children: <Widget>[
            buildItem(1, widget.topLeftItemColor),
            buildItem(2, widget.topRightItemColor),
            buildItem(3, widget.bottomLeftItemColor),
            buildItem(4, widget.bottomRightItemColor)
          ],
        ),
      ),
    );
  }

  Widget buildItem(int i, Color color) {
    Offset offset;

    initOffsets();

    if (i == 1) {
      offset = topLeftItemOffset;
    } else if (i == 2) {
      offset = topRightItemOffset;
    } else if (i == 3) {
      offset = bottomLeftItemOffset;
    } else {
      offset = bottomRightItemOffset;
    }

    return Transform.translate(
      offset: offset,
      child: Container(
        width: itemSize,
        height: itemSize,
        decoration: BoxDecoration(
          color: color,
          shape: widget.shape,
        ),
      ),
    );
  }
}
