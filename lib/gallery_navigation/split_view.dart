import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_container.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_toggle_button.dart';

class SplitView extends StatefulWidget {
  const SplitView({Key? key, required this.contentBuilder}) : super(key: key);
  final WidgetBuilder contentBuilder;

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  static const duration = Duration(milliseconds: 250);
  static const curve = Curves.easeInOutCubic;
  static const galleryContainerWidth = 240.0;

  bool _showMenu = false;
  void _toggleMenu() {
    setState(() => _showMenu = !_showMenu);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 600) {
      // wide screen: return split-view menu on the left, content on the right
      return Row(
        children: [
          SizedBox(
            width: galleryContainerWidth,
            child: GalleryContainer(
              onPageSelected: _toggleMenu,
            ),
          ),
          Expanded(child: widget.contentBuilder(context)),
        ],
      );
    } else {
      // narrow screen: menu slides in/out above the content view
      return Stack(
        children: [
          Positioned.fill(
            child: AnimatedOpacity(
              duration: duration,
              curve: curve,
              opacity: _showMenu ? 0.5 : 1.0,
              child: widget.contentBuilder(context),
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            curve: curve,
            left: _showMenu ? 0 : -galleryContainerWidth,
            width: galleryContainerWidth,
            top: 0,
            bottom: 0,
            child: GalleryContainer(
              onPageSelected: _toggleMenu,
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            curve: curve,
            left: _showMenu ? galleryContainerWidth : 0,
            bottom: 0,
            child: SafeArea(
              child: GalleryToggleButton(
                isShowing: _showMenu,
                onPressed: _toggleMenu,
              ),
            ),
          ),
        ],
      );
    }
  }
}
