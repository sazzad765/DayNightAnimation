import 'package:flutter/material.dart';
import 'dart:math' as math;

class Rectangle extends CustomPainter {
  bool? isFilled;

  Rectangle({this.isFilled});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 20;
    // // if (isFilled != null) {
    //   paint.style = PaintingStyle.fill;
    // // } else {
    // //   paint.style = PaintingStyle.stroke;
    // // }
    // paint.strokeCap = StrokeCap.round;
    // paint.strokeJoin = StrokeJoin.round;
    // paint.strokeWidth = 5;
    // Offset offset = Offset(size.width * 0.5, size.height);
    //
    // Rect rect = Rect.fromCenter(center: offset, width: 100, height: 100);
    // canvas.drawRect(rect, paint);

    // paint.style = PaintingStyle.fill;
    // paint.strokeCap = StrokeCap.round;
    // paint.strokeJoin = StrokeJoin.round;
    //
    // canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), .4,
    //     2 * math.pi - .8, true, paint);

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 100)
      ..quadraticBezierTo(30, 50, 90, 100)

      ..lineTo(100, 100);
    // ..lineTo(100, 0)..quadraticBezierTo(100, 70, 20, 20)
    // ..lineTo(100, 100)
    // ..lineTo(0, 100)
    // ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant Rectangle oldDelegate) {
    return false;
  }

  double _degreeToRadians(num degree) {
    return (degree * math.pi) / 180.0;
  }
}
