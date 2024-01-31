import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class DayNightAnimation extends StatefulWidget {
  const DayNightAnimation({super.key});

  @override
  State<DayNightAnimation> createState() => _DayNightAnimationState();
}

class _DayNightAnimationState extends State<DayNightAnimation> {
  double value = 0.4;
  bool isDayMood = true;
  double imageSize = 150;
  Timer? timer;

  List<Color> lightBgColors = [
    const Color(0xFF8C2480),
    const Color(0xFFCE587D),
    const Color(0xFFFF9485),
    // Color(0xFFFF9D80),
  ];
  var darkBgColors = [
    const Color(0xFF0D1441),
    const Color(0xFF283584),
    const Color(0xFF376AB2),
  ];

  void changeMode() {
    setState(() {
      isDayMood = !isDayMood;
    });
  }

  void _onBack() {
    if (value > .9) {
      changeMode();
    }
    timer = Timer.periodic(const Duration(milliseconds: 5), (_) {
      if (value > .4) {
        setState(() {
          value = value - .01;
        });
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDayMood ? lightBgColors : darkBgColors,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Text(
                  'PARIBAHAN.COM',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.1),
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 16,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: imageSize - 70),
                                child: SizedBox(
                                  height: imageSize + 50,
                                  width: 100,
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: Slider(
                                      inactiveColor: Colors.transparent,
                                      value: value,
                                      onChangeEnd: (v) {
                                        _onBack();
                                      },
                                      onChanged: (v) {
                                        setState(() {
                                          value = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(seconds: 1),
                                child: isDayMood
                                    ? Image.asset(
                                        key: const Key('1'),
                                        'assets/images/sun.png',
                                        width: imageSize,
                                        height: imageSize,
                                      )
                                    : Image.asset(
                                        key: const Key('2'),
                                        'assets/images/moon.png',
                                        width: imageSize,
                                        height: imageSize,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Lottie.asset(
                            'assets/animations/cloud.json',
                            height: 600,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Lottie.asset(
                            'assets/animations/cloud.json',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 16,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: imageSize - 70),
                                child: SizedBox(
                                  height: imageSize + 50,
                                  width: 100,
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: Slider(
                                      activeColor: Colors.transparent,
                                      inactiveColor: Colors.transparent,
                                      value: value,
                                      onChangeEnd: (v) {
                                        _onBack();
                                      },
                                      onChanged: (v) {
                                        setState(() {
                                          value = v;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: imageSize,
                                width: imageSize,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Opacity(
                        opacity: 0.8,
                        child: Lottie.asset(
                          'assets/animations/bus1.json',
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
