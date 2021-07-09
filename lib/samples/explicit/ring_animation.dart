import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_animations_gallery/animation_controller_state.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';

class AnimatedRingPage extends StatefulWidget {
  @override
  _AnimatedRingPageState createState() =>
      _AnimatedRingPageState(Duration(milliseconds: 750));
}

class _AnimatedRingPageState
    extends AnimationControllerState<AnimatedRingPage> {
  _AnimatedRingPageState(Duration duration) : super(duration);
  late final Animation<double> _curveAnimation = animationController.drive(
    CurveTween(curve: Curves.easeInOut),
  );

  void _handleTapDown(TapDownDetails details) {
    animationController.forward();
  }

  void _handleTapCancel() {
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Animated Ring',
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tap and hold to animate',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 32),
            SizedBox(
              width: 240,
              height: 240,
              child: GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: (_) => _handleTapCancel(),
                onTapCancel: _handleTapCancel,
                child: AnimatedBuilder(
                  animation: _curveAnimation,
                  builder: (context, child) {
                    return Ring(progress: _curveAnimation.value);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ring extends StatelessWidget {
  const Ring({required this.progress});
  final double progress;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingPainter(
          progress: progress,
          backgroundColor: Theme.of(context).primaryColorLight,
          foregroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  RingPainter({
    required this.progress,
    required this.backgroundColor,
    required this.foregroundColor,
  });
  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = backgroundColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = foregroundColor
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
