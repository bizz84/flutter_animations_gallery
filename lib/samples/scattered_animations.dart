import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/animation_controller_state.dart';
import 'package:flutter_animations_gallery/page_scaffold.dart';

class StaggeredFractionallySizedBoxTransition extends AnimatedWidget {
  StaggeredFractionallySizedBoxTransition({
    Key? key,
    required Animation<double> animation,
    required int index,
    required this.child,
  })  : indexedAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.15 * index,
              0.25 + 0.15 * index,
              curve: Curves.easeInOutCubic,
            ),
          ),
        ),
        super(key: key, listenable: animation);
  final Widget child;
  final Animation<double> indexedAnimation;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: min(max(indexedAnimation.value, 0.0), 1.0),
      child: child,
    );
  }
}

class StaggeredAnimationsPage extends StatefulWidget {
  const StaggeredAnimationsPage({Key? key}) : super(key: key);

  @override
  _StaggeredAnimationsPageState createState() =>
      _StaggeredAnimationsPageState(Duration(milliseconds: 1500));
}

class _StaggeredAnimationsPageState
    extends AnimationControllerState<StaggeredAnimationsPage> {
  _StaggeredAnimationsPageState(Duration duration) : super(duration);

  bool _isShowing = false;

  void _toggleAnimation() {
    if (animationController.status == AnimationStatus.dismissed ||
        animationController.status == AnimationStatus.reverse) {
      animationController.forward();
      setState(() => _isShowing = true);
    } else {
      animationController.reverse();
      setState(() => _isShowing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Boil the water',
      'Add salt',
      'Add the pasta',
      'Cook for 10 min',
      'Drain the water',
      'Buon appetito!'
    ];
    return PageScaffold(
        title: 'Staggered animations',
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('How to make pasta',
                  style: Theme.of(context).textTheme.headline5),
            ),
            ElevatedButton(
              onPressed: _toggleAnimation,
              child: Text(_isShowing ? 'Hide' : 'Show',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white)),
            ),
            SizedBox(height: 16),
            for (var title in titles)
              StepWidgetTile(
                animation: animationController,
                title: title,
                index: titles.indexOf(title),
              )
          ],
        ));
  }
}

class StepWidgetTile extends StatelessWidget {
  StepWidgetTile({
    Key? key,
    required this.animation,
    required this.index,
    required this.title,
  }) : super(key: key);
  final Animation<double> animation;
  final int index;
  final String title;

  static final tween = Tween(begin: 0.0, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(children: [
        // only apply animation to selected item
        StaggeredFractionallySizedBoxTransition(
          animation: animation,
          index: index,
          child: Container(color: Theme.of(context).primaryColor),
        ),
        Center(
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.white))),
        Container(
          height: 60,
          color: Colors.transparent,
        ),
      ]),
    );
  }
}
