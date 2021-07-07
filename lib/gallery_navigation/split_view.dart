import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/gallery_menu.dart';

class SplitView extends StatefulWidget {
  const SplitView({Key? key, required this.contentBuilder}) : super(key: key);
  final WidgetBuilder contentBuilder;

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  static const duration = Duration(milliseconds: 250);
  static const curve = Curves.easeInOutCubic;

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
          GalleryContainer(),
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
            left: _showMenu ? 0 : -GalleryContainer.width,
            width: GalleryContainer.width,
            top: 0,
            bottom: 0,
            child: GalleryContainer(
              onPageSelected: _toggleMenu,
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            curve: curve,
            left: _showMenu ? GalleryContainer.width : 0,
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

class GalleryToggleButton extends StatelessWidget {
  const GalleryToggleButton({Key? key, required this.isShowing, this.onPressed})
      : super(key: key);
  final bool isShowing;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: Icon(
          isShowing ? Icons.arrow_back : Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GalleryContainer extends StatelessWidget {
  const GalleryContainer({Key? key, this.onPageSelected}) : super(key: key);
  final VoidCallback? onPageSelected;
  static const width = 240.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: GalleryMenu(
        onSelected: (_) => onPageSelected?.call(),
      ),
    );
  }
}
