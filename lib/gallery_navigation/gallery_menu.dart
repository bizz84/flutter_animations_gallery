import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_animations_gallery/samples/animated_positioned.dart';
import 'package:flutter_animations_gallery/samples/ring_animation.dart';
import 'package:flutter_animations_gallery/samples/rotation_transition.dart';
import 'package:flutter_animations_gallery/samples/curves.dart';
import 'package:flutter_animations_gallery/samples/duration.dart';
import 'package:flutter_animations_gallery/samples/staggered_animations.dart';
import 'package:flutter_animations_gallery/samples/theming.dart';
import 'package:flutter_animations_gallery/samples/tickers_stopwatch.dart';
import 'package:flutter_animations_gallery/samples/tween_animation_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availablePages = <String, WidgetBuilder>{
  'Curves': (_) => CurvesPage(),
  'Themes': (_) => ThemeSelectionPage(),
  'AnimatedPositioned': (_) => AnimatedPositionedPage(),
  'TweenAnimationBuilder (rotation)': (_) => TweenAnimationBuilderPage(),
  'RotationTransition': (_) => RotationTransitionPage(),
  'Stopwatch': (_) => StopwatchPage(),
  'Staggered Animations': (_) => StaggeredAnimationsPage(),
  'Animated Ring': (_) => AnimatedRingPage(),
  'Duration': (_) => DurationPage(),
};

final settingsGroupKeys = <String>['Curves', 'Themes', 'Duration'];
final implicitGroupKeys = <String>[
  'AnimatedPositioned',
  'TweenAnimationBuilder (rotation)'
];
final explicitGroupKeys = <String>[
  'RotationTransition',
  'Staggered Animations',
  'Animated Ring'
];
final tickerGroupKeys = <String>['Stopwatch'];

final selectedPageKeyProvider = StateProvider<String>((ref) {
  return availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageKeyProvider).state;
  return availablePages[selectedPageKey]!;
});

class GalleryMenu extends ConsumerWidget {
  GalleryMenu({Key? key}) : super(key: key);

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageKeyProvider).state != pageName) {
      ref.read(selectedPageKeyProvider).state = pageName;
      // dismiss drawer if we have one
      if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageKeyProvider);
    final selectedPageName = selectedPage.state;
    return PageScaffold(
      title: 'Gallery',
      showDrawerIcon: false,
      body: ListView(
        children: <Widget>[
          ListSectionHeader(title: 'Settings'),
          for (var pageName in settingsGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
          ListSectionHeader(title: 'Implicit Animations'),
          for (var pageName in implicitGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
          ListSectionHeader(title: 'Explicit Animations'),
          for (var pageName in explicitGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
          ListSectionHeader(title: 'Tickers'),
          for (var pageName in tickerGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
        ],
      ),
    );
  }
}

class PageListTile extends StatelessWidget {
  const PageListTile(
      {Key? key,
      required this.selectedPageName,
      required this.pageName,
      this.onPressed})
      : super(key: key);
  final String selectedPageName;
  final String pageName;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Opacity(
        opacity: selectedPageName == pageName ? 1.0 : 0.0,
        child: Icon(Icons.check),
      ),
      title: Text(pageName),
      onTap: onPressed,
    );
  }
}

class ListSectionHeader extends StatelessWidget {
  const ListSectionHeader({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 32,
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border(
          top: BorderSide(color: Colors.black26, width: 0.5),
          bottom: BorderSide(color: Colors.black26, width: 0.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(title, textAlign: TextAlign.left),
      ),
    );
  }
}
