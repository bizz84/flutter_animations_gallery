import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_animations_gallery/samples/animated_positioned.dart';
import 'package:flutter_animations_gallery/samples/animation_controller_rotation.dart';
import 'package:flutter_animations_gallery/samples/curves.dart';
import 'package:flutter_animations_gallery/samples/staggered_animations.dart';
import 'package:flutter_animations_gallery/samples/theming.dart';
import 'package:flutter_animations_gallery/samples/tickers_stopwatch.dart';
import 'package:flutter_animations_gallery/samples/tween_animation_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availablePages = <String, WidgetBuilder>{
  'Curves': (_) => CurvesPage(),
  'Theming': (_) => ThemeSelectionPage(),
  'AnimatedPositioned': (_) => AnimatedPositionedPage(),
  'TweenAnimationBuilder (rotation)': (_) => TweenAnimationBuilderPage(),
  'AnimationController (rotation)': (_) => AnimationControllerRotationPage(),
  'Stopwatch with Ticker': (_) => StopwatchPage(),
  'Staggered Animations': (_) => StaggeredAnimationsPage(),
};

final selectedPageKeyProvider = StateProvider<String>((ref) {
  return availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageKeyProvider).state;
  return availablePages[selectedPageKey]!;
});

class GalleryMenu extends ConsumerWidget {
  GalleryMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageKeyProvider);
    final selectedPageName = selectedPage.state;
    return PageScaffold(
      title: 'Gallery',
      showDrawerIcon: false,
      body: ListView(
        children: <Widget>[
          for (var pageName in availablePages.keys)
            ListTile(
              leading: Opacity(
                opacity: selectedPageName == pageName ? 1.0 : 0.0,
                child: Icon(Icons.check),
              ),
              title: Text(pageName),
              onTap: () {
                if (ref.read(selectedPageKeyProvider).state != pageName) {
                  ref.read(selectedPageKeyProvider).state = pageName;
                  // dismiss drawer if we have one
                  if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
                    Navigator.of(context).pop();
                  }
                }
              },
            )
        ],
      ),
    );
  }
}
