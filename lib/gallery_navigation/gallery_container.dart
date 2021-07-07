import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_menu.dart';

class GalleryContainer extends StatelessWidget {
  const GalleryContainer({Key? key, this.onPageSelected}) : super(key: key);
  final VoidCallback? onPageSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: GalleryMenu(onPageSelected: onPageSelected),
    );
  }
}
