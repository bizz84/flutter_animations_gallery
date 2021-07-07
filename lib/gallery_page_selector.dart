import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/samples/animated_positioned.dart';
import 'package:flutter_animations_gallery/samples/curves.dart';
import 'package:flutter_animations_gallery/samples/scattered_animations.dart';
import 'package:flutter_animations_gallery/samples/theming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availablePages = <String, WidgetBuilder>{
  'Curves': (_) => CurvesPage(),
  'Theming': (_) => ThemeSelectionPage(),
  'AnimatedPositioned': (_) => AnimatedPositionedPage(),
  'Staggered Animations': (_) => StaggeredAnimationsPage(),
};

final selectedPageKeyProvider = StateProvider<String>((ref) {
  return availablePages.keys.first;
});

final selectedPageBuilderProvider = Provider<WidgetBuilder>((ref) {
  final selectedPageKey = ref.watch(selectedPageKeyProvider).state;
  return availablePages[selectedPageKey]!;
});

class GalleryPageSelector extends StatelessWidget {
  GalleryPageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Column(children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(child: GalleryPagesList()),
        ]),
      ),
    );
  }
}

class GalleryPagesList extends ConsumerWidget {
  const GalleryPagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageKeyProvider);
    final selectedPageName = selectedPage.state;
    return ListView(
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
              }
            },
          )
      ],
    );
  }
}
