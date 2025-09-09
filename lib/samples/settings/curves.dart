import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/animation_controller_state.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _allCurves = <String, Curve>{
  'linear': Curves.linear,
  'decelerate': Curves.decelerate,
  'fastLinearToSlowEaseIn': Curves.fastLinearToSlowEaseIn,
  'ease': Curves.ease,
  'easeIn': Curves.easeIn,
  'easeInToLinear': Curves.easeInToLinear,
  'easeInSine': Curves.easeInSine,
  'easeInQuad': Curves.easeInQuad,
  'easeInCubic': Curves.easeInCubic,
  'easeInQuart': Curves.easeInQuart,
  'easeInQuint': Curves.easeInQuint,
  'easeInExpo': Curves.easeInExpo,
  'easeInCirc': Curves.easeInCirc,
  'easeInBack': Curves.easeInBack,
  'easeOut': Curves.easeOut,
  'linearToEaseOut': Curves.linearToEaseOut,
  'easeOutSine': Curves.easeOutSine,
  'easeOutQuad': Curves.easeOutQuad,
  'easeOutCubic': Curves.easeOutCubic,
  'easeOutQuart': Curves.easeOutQuart,
  'easeOutQuint': Curves.easeOutQuint,
  'easeOutExpo': Curves.easeOutExpo,
  'easeOutCirc': Curves.easeOutCirc,
  'easeOutBack': Curves.easeOutBack,
  'easeInOut': Curves.easeInOut,
  'easeInOutSine': Curves.easeInOutSine,
  'easeInOutQuad': Curves.easeInOutQuad,
  'easeInOutCubic': Curves.easeInOutCubic,
  'easeInOutQuart': Curves.easeInOutQuart,
  'easeInOutQuint': Curves.easeInOutQuint,
  'easeInOutExpo': Curves.easeInOutExpo,
  'easeInOutCirc': Curves.easeInOutCirc,
  'easeInOutBack': Curves.easeInOutBack,
  'fastOutSlowIn': Curves.fastOutSlowIn,
  'slowMiddle': Curves.slowMiddle,
  'bounceIn': Curves.bounceIn,
  'bounceOut': Curves.bounceOut,
  'bounceInOut': Curves.bounceInOut,
  'elasticIn': Curves.elasticIn,
  'elasticOut': Curves.elasticOut,
  'elasticInOut': Curves.elasticInOut,
};

final curveKeyProvider = StateProvider<String>((ref) {
  return _allCurves.keys.first;
});

final curveProvider = Provider<Curve>((ref) {
  final curveKey = ref.watch(curveKeyProvider);
  return _allCurves[curveKey]!;
});

final animateAllCurvesProvider = StateProvider<bool>((ref) {
  return true;
});

class CurvesPage extends StatefulWidget {
  const CurvesPage({super.key});

  @override
  AnimationControllerState<CurvesPage> createState() =>
      _CurvesPageState(const Duration(milliseconds: 1500));
}

class _CurvesPageState extends AnimationControllerState<CurvesPage> {
  _CurvesPageState(super.duration);

  @override
  void initState() {
    super.initState();
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final animateAllCurves = ref.watch(animateAllCurvesProvider);
      return PageScaffold(
        title: 'Curves',
        actions: [
          IconButton(
            // TODO: Improve icons
            icon: Transform.rotate(
              angle: animateAllCurves ? pi / 2 : 0,
              child: Icon(animateAllCurves ? Icons.bar_chart : Icons.repeat),
            ),
            onPressed: () => ref.read(animateAllCurvesProvider.notifier).state =
                !animateAllCurves,
          ),
        ],
        body: CurvesListView(
          animation: animationController,
          animateAllCurves: animateAllCurves,
        ),
      );
    });
  }
}

class CurvesListView extends ConsumerWidget {
  const CurvesListView(
      {super.key, required this.animation, required this.animateAllCurves});
  final Animation<double> animation;
  final bool animateAllCurves;

  static const separatorHeight = 0.5;
  double scrollOffset(int selectedCurveIndex, double availableHeight) {
    const listTileHeight = CurveListTile.height + separatorHeight;
    final selectedOffset = listTileHeight * selectedCurveIndex;
    final listExtent = listTileHeight * _allCurves.keys.length;
    final maxOffset = listExtent - availableHeight;
    final centeredOffset = (availableHeight - listTileHeight) / 2;
    return max(min(maxOffset, selectedOffset - centeredOffset), 0.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // calculate scroll offset so that the selected curve is vertically centered when the page is first loaded
        final selectedCurveKey = ref.watch(curveKeyProvider);
        final selectedCurveIndex =
            _allCurves.keys.toList().indexOf(selectedCurveKey);
        final availableHeight = constraints.maxHeight;
        final initialScrollOffset =
            scrollOffset(selectedCurveIndex, availableHeight);
        return ListView.separated(
          controller:
              ScrollController(initialScrollOffset: initialScrollOffset),
          itemCount: _allCurves.keys.length,
          itemBuilder: (context, index) {
            final curveKey = _allCurves.keys.toList()[index];
            return CurveListTile(
              curve: _allCurves[curveKey]!,
              title: curveKey,
              showAnimation: animateAllCurves || curveKey == selectedCurveKey,
              isSelected: curveKey == selectedCurveKey,
              animation: animation,
              onSelected: () =>
                  ref.read(curveKeyProvider.notifier).state = curveKey,
            );
          },
          separatorBuilder: (context, index) => Container(
            color: Colors.black12,
            height: separatorHeight,
          ),
        );
      },
    );
  }
}

class CurveListTile extends StatelessWidget {
  CurveListTile({
    super.key,
    required this.curve,
    required this.title,
    required this.showAnimation,
    required this.isSelected,
    required Animation<double> animation,
    this.onSelected,
  })  : curvedAnimation = tween.animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));
  final Curve curve;
  final String title;
  final bool showAnimation;
  final bool isSelected;
  final Animation<double> curvedAnimation;
  final VoidCallback? onSelected;

  static final tween = Tween(begin: 0.0, end: 1.0);
  static const height = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          isSelected ? Theme.of(context).primaryColorLight : Colors.transparent,
      height: height,
      child: Stack(children: [
        // only apply animation to selected item
        if (showAnimation)
          IgnorePointer(
            ignoring: true,
            child: AnimatedBuilder(
              animation: curvedAnimation,
              child: Container(color: Theme.of(context).primaryColor),
              builder: (context, child) {
                return FractionallySizedBox(
                  widthFactor: min(max(curvedAnimation.value, 0.0), 1.0),
                  child: child,
                );
              },
            ),
          ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ),
        GestureDetector(
          onTap: onSelected,
          child: Container(
            height: 60,
            color: Colors.transparent,
          ),
        ),
      ]),
    );
  }
}
