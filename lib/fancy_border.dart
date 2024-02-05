import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/rectangle_shape.dart';

class FancyBorder extends StatelessWidget {
  const FancyBorder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
          child: CustomPaint(
        size: Size(size.width * 0.5, size.height * 0.1),
        painter: Rectangle(),
      )),
    );
  }
}
