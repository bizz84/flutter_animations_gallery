import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_menu.dart';
import 'package:flutter_animations_gallery/gallery_navigation/split_view.dart';
import 'package:flutter_animations_gallery/samples/theming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch all application state variables
    final color = ref.watch(colorProvider);
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: color,
      ),
      home: Builder(
        builder: (context) => SplitView(
          contentBuilder: (context) => selectedPageBuilder(context),
        ),
      ),
      //  Builder(
      //   builder: (context) => selectedPageBuilder(context),
      // ),
    );
  }
}
