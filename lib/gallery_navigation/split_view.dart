import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_page_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplitView extends ConsumerWidget {
  const SplitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPageBuilder = ref.watch(selectedPageBuilderProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    // check if >= 600
    return Row(
      children: [
        SizedBox(
          width: 240,
          child: GalleryPageSelector(),
        ),
        Container(
          width: 0.5,
          color: Colors.black12,
        ),
        Expanded(
          child: selectedPageBuilder(context),
        ),
      ],
    );
  }
}
