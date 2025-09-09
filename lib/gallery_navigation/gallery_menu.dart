import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_animations_gallery/samples/implicit/animated_container.dart';
import 'package:flutter_animations_gallery/samples/implicit/animated_positioned.dart';
import 'package:flutter_animations_gallery/samples/explicit/ring_animation.dart';
import 'package:flutter_animations_gallery/samples/explicit/rotation_transition.dart';
import 'package:flutter_animations_gallery/samples/settings/curves.dart';
import 'package:flutter_animations_gallery/samples/settings/duration.dart';
import 'package:flutter_animations_gallery/samples/explicit/scale_transition.dart';
import 'package:flutter_animations_gallery/samples/explicit/staggered_animations.dart';
import 'package:flutter_animations_gallery/samples/settings/theming.dart';
import 'package:flutter_animations_gallery/samples/tickers/tickers_stopwatch.dart';
import 'package:flutter_animations_gallery/samples/implicit/tween_animation_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availablePages = <String, WidgetBuilder>{
  // settings
  'Curves': (_) => const CurvesPage(),
  'Themes': (_) => const ThemeSelectionPage(),
  'Duration': (_) => const DurationPage(),
  // implicit animations
  'AnimatedContainer': (_) => const AnimatedContainerPage(),
  'AnimatedPositioned': (_) => const AnimatedPositionedPage(),
  'TweenAnimationBuilder (translation)': (_) =>
      const TweenAnimationBuilderPage(),
  // explicit animations
  'ScaleTransition': (_) => const ScaleTransitionPage(),
  'RotationTransition': (_) => const RotationTransitionPage(),
  'Animated Ring': (_) => const AnimatedRingPage(),
  'Staggered Animations': (_) => const StaggeredAnimationsPage(),
  // tickers
  'Stopwatch': (_) => const StopwatchPage(),
};

final settingsGroupKeys = <String>[
  'Curves',
  'Themes',
  'Duration',
];
final implicitGroupKeys = <String>[
  'AnimatedContainer',
  'AnimatedPositioned',
  'TweenAnimationBuilder (translation)',
];
final explicitGroupKeys = <String>[
  'ScaleTransition',
  'RotationTransition',
  'Staggered Animations',
  'Animated Ring',
];
final tickerGroupKeys = <String>[
  'Stopwatch',
];

final selectedPageKeyProvider = StateProvider<String>((ref) {
  return availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageKeyProvider);
  return availablePages[selectedPageKey]!;
});

class GalleryMenu extends ConsumerWidget {
  const GalleryMenu({super.key});

  void _selectPage(BuildContext context, WidgetRef ref, String pageName) {
    if (ref.read(selectedPageKeyProvider) != pageName) {
      ref.read(selectedPageKeyProvider.notifier).state = pageName;
      // dismiss drawer if we have one
      if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageName = ref.watch(selectedPageKeyProvider);
    return PageScaffold(
      title: 'Gallery',
      showDrawerIcon: false,
      body: ListView(
        children: <Widget>[
          const ListSectionHeader(title: 'Settings'),
          for (var pageName in settingsGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
          const ListSectionHeader(title: 'Implicit Animations'),
          for (var pageName in implicitGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
          const ListSectionHeader(title: 'Explicit Animations'),
          for (var pageName in explicitGroupKeys)
            PageListTile(
              selectedPageName: selectedPageName,
              pageName: pageName,
              onPressed: () => _selectPage(context, ref, pageName),
            ),
          const ListSectionHeader(title: 'Tickers'),
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
      {super.key,
      required this.selectedPageName,
      required this.pageName,
      this.onPressed});
  final String selectedPageName;
  final String pageName;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Opacity(
        opacity: selectedPageName == pageName ? 1.0 : 0.0,
        child: const Icon(Icons.check),
      ),
      title: Text(pageName),
      onTap: onPressed,
    );
  }
}

class ListSectionHeader extends StatelessWidget {
  const ListSectionHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 32,
      decoration: const BoxDecoration(
        color: Colors.black12,
        border: Border(
          top: BorderSide(color: Colors.black26, width: 0.5),
          bottom: BorderSide(color: Colors.black26, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(title, textAlign: TextAlign.left),
      ),
    );
  }
}
