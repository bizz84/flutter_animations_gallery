import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_page_selector.dart';
import 'package:flutter_animations_gallery/samples/theming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animations_gallery/samples/curves.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeIndex = ref.watch(themeIndexProvider);
    final colorKey = allDarkColors.keys.toList()[themeIndex.state];
    final selectedPage = ref.watch(selectedPageProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: allDarkColors[colorKey],
      ),
      home: Builder(
        builder: (context) => availablePages[selectedPage.state]!(context),
      ),
    );
  }
}
