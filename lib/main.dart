import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_menu.dart';
import 'package:flutter_animations_gallery/gallery_navigation/split_view.dart';
import 'package:flutter_animations_gallery/samples/settings/theming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
          menuBuilder: (context) => const GalleryMenu(),
          contentBuilder: (context) => selectedPageBuilder(context),
        ),
      ),
    );
  }
}
