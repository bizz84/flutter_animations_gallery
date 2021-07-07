import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/split_view_show_menu_button.dart';

class SplitView extends StatefulWidget {
  const SplitView(
      {Key? key, required this.menuBuilder, required this.contentBuilder})
      : super(key: key);
  final WidgetBuilder menuBuilder;
  final WidgetBuilder contentBuilder;

  @override
  SplitViewState createState() => SplitViewState();
}

class SplitViewState extends State<SplitView> {
  static const duration = Duration(milliseconds: 250);
  static const curve = Curves.easeInOutCubic;
  static const menuContainerWidth = 240.0;
  static const splitViewBreakpoint = 600.0;

  bool _showMenu = false;
  void toggleMenu() {
    setState(() => _showMenu = !_showMenu);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= splitViewBreakpoint) {
      // wide screen: return split-view menu on the left, content on the right
      return Row(
        children: [
          SizedBox(
            width: menuContainerWidth,
            child: widget.menuBuilder(context),
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
            left: _showMenu ? 0 : -menuContainerWidth,
            width: menuContainerWidth,
            top: 0,
            bottom: 0,
            child: widget.menuBuilder(context),
          ),
          AnimatedPositioned(
            duration: duration,
            curve: curve,
            left: _showMenu ? menuContainerWidth : 0,
            bottom: 0,
            child: SafeArea(
              child: SplitViewShowMenuButton(
                isShowing: _showMenu,
                onPressed: toggleMenu,
              ),
            ),
          ),
        ],
      );
    }
  }
}
