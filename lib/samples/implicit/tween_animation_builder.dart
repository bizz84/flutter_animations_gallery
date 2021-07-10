import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_animations_gallery/samples/settings/duration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TweenAnimationBuilderPage extends ConsumerStatefulWidget {
  const TweenAnimationBuilderPage({Key? key}) : super(key: key);

  @override
  _TweenAnimationBuilderPageState createState() =>
      _TweenAnimationBuilderPageState();
}

class _TweenAnimationBuilderPageState
    extends ConsumerState<TweenAnimationBuilderPage> {
  double _value = 0.0;

  static const size = 120.0;

  @override
  Widget build(BuildContext context) {
    final duration = ref.watch(durationProvider);
    return PageScaffold(
      title: 'TweenAnimationBuilder',
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size / 4),
            Text(
              'Without TweenAnimationBuilder',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: size / 4),
            Transform.translate(
              offset: Offset(_value * 200 - 100, 0),
              child: Container(
                width: size,
                height: size,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: size / 4),
            Text(
              'With TweenAnimationBuilder',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: size / 4),
            TweenAnimationBuilder<double>(
              duration: duration,
              tween: Tween(begin: 0.0, end: _value),
              child: Container(
                width: size,
                height: size,
                color: Theme.of(context).primaryColor,
              ),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value * 200 - 100, 0),
                  //angle: 0.5 * pi * value,
                  child: child,
                );
              },
            ),
            SizedBox(height: size / 4),
            // use a Row to ensure the Slider has a fixed width, but the parent Column is full-width
            Row(children: [
              Spacer(),
              SizedBox(
                width: 240,
                child: Slider.adaptive(
                  value: _value,
                  onChanged: (value) => setState(() => _value = value),
                ),
              ),
              Spacer(),
            ]),
            SizedBox(height: size / 4),
          ],
        ),
      ),
    );
  }
}
