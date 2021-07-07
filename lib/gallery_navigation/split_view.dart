import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/split_view_show_menu_button.dart';

class SplitView extends StatefulWidget {
  const SplitView({
    Key? key,
    required this.menuBuilder,
    required this.contentBuilder,
    this.breakpoint = 600,
    this.menuWidth = 240,
    this.menuRevealDuration = const Duration(milliseconds: 250),
    this.menuRevealCurve = Curves.easeInOutCubic,
  }) : super(key: key);
  final WidgetBuilder menuBuilder;
  final WidgetBuilder contentBuilder;
  final double breakpoint;
  final double menuWidth;
  final Duration menuRevealDuration;
  final Curve menuRevealCurve;

  @override
  SplitViewState createState() => SplitViewState();
}

class SplitViewState extends State<SplitView> {
  bool _showMenu = false;
  void toggleMenu() {
    setState(() => _showMenu = !_showMenu);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= widget.breakpoint) {
      // wide screen: menu on the left, content on the right
      return Row(
        children: [
          SizedBox(
            width: widget.menuWidth,
            child: widget.menuBuilder(context),
          ),
          Expanded(child: widget.contentBuilder(context)),
        ],
      );
    } else {
      // narrow screen: show content, menu slides in above it
      return Stack(
        children: [
          // TODO: gesture detector to dismiss menu when content area is tapped
          Positioned.fill(
            child: AnimatedOpacity(
              duration: widget.menuRevealDuration,
              curve: widget.menuRevealCurve,
              opacity: _showMenu ? 0.5 : 1.0,
              child: widget.contentBuilder(context),
            ),
          ),
          AnimatedPositioned(
            duration: widget.menuRevealDuration,
            curve: widget.menuRevealCurve,
            left: _showMenu ? 0 : -widget.menuWidth,
            width: widget.menuWidth,
            top: 0,
            bottom: 0,
            child: widget.menuBuilder(context),
          ),
          AnimatedPositioned(
            duration: widget.menuRevealDuration,
            curve: widget.menuRevealCurve,
            left: _showMenu ? widget.menuWidth : 0,
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
