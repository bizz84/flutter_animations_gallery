import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_animations_gallery/samples/settings/curves.dart';
import 'package:flutter_animations_gallery/samples/settings/duration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedContainerPage extends ConsumerStatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends ConsumerState<AnimatedContainerPage> {
  double _width = 200;
  double _height = 200;
  Color _color = Colors.red;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(16);

  final random = Random();

  void _randomize() {
    setState(() {
      _width = random.nextInt(300).toDouble();
      _height = random.nextInt(300).toDouble();

      _color = Color.fromRGBO(
        random.nextInt(128),
        random.nextInt(128),
        random.nextInt(128),
        1,
      );

      _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    final curve = ref.watch(curveProvider);
    final duration = ref.watch(durationProvider);
    return PageScaffold(
      title: 'AnimatedContainer',
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: _randomize,
      ),
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          duration: duration,
          curve: curve,
        ),
      ),
    );
  }
}
