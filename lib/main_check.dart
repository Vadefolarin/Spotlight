import 'dart:ui';

import 'package:flutter/material.dart';

class SpotlightDemo extends StatefulWidget {
  const SpotlightDemo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SpotlightDemoState createState() => _SpotlightDemoState();
}

class _SpotlightDemoState extends State<SpotlightDemo> {
  Offset dragGesturePositon = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (DragUpdateDetails details) => setState(
          () {
            dragGesturePositon = details.localPosition;
          },
        ),
        onTapDown: (TapDownDetails details) {
          setState(() {
            dragGesturePositon = details.globalPosition;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            dragGesturePositon = details.globalPosition;
          });
        },
        onTapCancel: () {
          setState(() {
            dragGesturePositon = Offset.zero;
          });
        },
        child: Stack(
          children: [
            // Background image or content
            Center(
              child: Container(
                  decoration: const BoxDecoration(),
                  child: Text(
                    'VELOCITY',
                    style: TextStyle(
                      fontSize: 250.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      wordSpacing: 20,
                    ),
                  )),
            ),
            // Spotlight effect
            Positioned(
              left: dragGesturePositon.dx,
              top: dragGesturePositon.dy,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                child: Container(
                  alignment: Alignment.center,
                  // Choose Colors.black.withOpacity(0.3) here if you want a shadow effect in addition to blurring.
                  color: Colors.transparent,
                  // This part is new, creating the cutout.
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: Hole(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Hole extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 80;
    double blurRadius = 10;
    canvas.drawCircle(
      const Offset(0, -100),
      radius,
      Paint()
        ..blendMode = BlendMode.xor
        ..color = Colors.white

        // The mask filter gives some fuziness to the cutout.
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius),
    );
  }

  @override
  bool shouldRepaint(Hole oldDelegate) => false;
}
