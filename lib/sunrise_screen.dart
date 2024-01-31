import 'package:flutter/material.dart';
import 'dart:math';

class SunriseScreen extends StatefulWidget {
  const SunriseScreen({super.key});

  @override
  _SunriseScreenState createState() => _SunriseScreenState();
}

class _SunriseScreenState extends State<SunriseScreen>
    with SingleTickerProviderStateMixin {
  final backgroundColor = Colors.white;
  late AnimationController _rotationController;
  late Animation<double> _innerCircleAnimation;
  late Animation<double> _outerCircleAnimation;
  late Animation<Color?> _colorAnimation;
  int _sunriseCount = 20;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    var _curvedAnimation =
        CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut);

    _innerCircleAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_curvedAnimation);
    _outerCircleAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_curvedAnimation);

    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(_curvedAnimation)
      ..addListener(() => setState(() {}));

    Future.delayed(Duration(seconds: 1), () {
      _startAnimation();
    });
  }

  _startAnimation() {
    if (!_rotationController.isAnimating) {
      if (_rotationController.value == 0)
        _rotationController.forward(from: 0);
      else
        _rotationController.animateBack(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => setState(() {
          _sunriseCount += 2;
        }),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: _startAnimation,
        child: Container(
          color: backgroundColor,
          child: Stack(
            children: <Widget>[
              RotationTransition(
                turns: _outerCircleAnimation,
                child: CustomPaint(
                  foregroundPainter: SunrisePainter(
                      color: _colorAnimation.value,
                      sunriseCount: _sunriseCount),
                  child: SizedBox.expand(),
                ),
              ),
              Center(
                  child: RotationTransition(
                turns: _innerCircleAnimation,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 64,
                    child: FlutterLogo(
                      size: 64,
                    )),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _rotationController.dispose();
  }
}

class SunrisePainter extends CustomPainter {
  final sunriseCount;
  final color;

  SunrisePainter({this.sunriseCount = 20, this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    //hypotenuse of width/2 and height/2 is the (minimum) radius
    final circleRadius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2));
    //circumference: pi*diameter = pi * 2 * radius
    final sunriseWidth = pi * circleRadius * 2 / sunriseCount;
    final angle = 2 * pi / sunriseCount;
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.translate(size.width / 2, size.height / 2);
    for (var i = 0; i < sunriseCount; i++) {
      if (i % 2 == 0) {
        var path = Path();
        path.lineTo(circleRadius, 0);
        path.lineTo(circleRadius, sunriseWidth);
        path.lineTo(0, 0);
        canvas.drawPath(path, paint);
      }
      canvas.rotate(angle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
