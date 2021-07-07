import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/samples/curves.dart';
import 'package:flutter_animations_gallery/samples/theming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availablePages = <String, WidgetBuilder>{
  'Curves': (_) => CurvesPage(),
  'Theming': (_) => ThemeSelectionPage(),
};

final selectedPageProvider = StateProvider<String>((ref) {
  return availablePages.keys.first;
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
    final selectedPage = ref.watch(selectedPageProvider);
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
              if (ref.read(selectedPageProvider).state != pageName) {
                ref.read(selectedPageProvider).state = pageName;
              }
            },
          )
      ],
    );
  }
}
