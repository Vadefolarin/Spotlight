import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Spotlight extends StatefulWidget {
  const Spotlight({Key? key}) : super(key: key);

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  bool _isHovered = false;
  void _toggleHover(bool value) {
    setState(() {
      _isHovered = value;
    });
  }

  double mouseX = 0;
  double mouseY = 0;

  void _updateLocation(PointerHoverEvent event) {
    setState(() {
      mouseX = event.localPosition.dx;
      mouseY = event.localPosition.dy;
    });
  }

    Offset dragGesturePositon = Offset.zero;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onEnter: (_) => _toggleHover(true),
        onExit: (_) => _toggleHover(false),
        onHover: _updateLocation,
        child: Stack(
          children: [
            Center(
              child: Text(
                'Victor',
                style: TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? Colors.white : Colors.transparent,
                ),
              ),
              
            ),
            Positioned(
              // bottom: mouseY,
              bottom: mouseY,
              top: 150,
              left: mouseX,
              child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return RadialGradient(
                      center: Alignment.center,
                      radius: 0.5,
                      colors: [
                        Colors.transparent,
                        _isHovered ? Colors.grey : Colors.transparent,
                      ],
                      stops: const [
                        0.8,
                        1.0,
                      ],
                    ).createShader(bounds);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      backgroundBlendMode: BlendMode.srcOver,
                    ),
                  )),
            ),
            Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent)
          ],
        ),
      ),
    );
  }
}
