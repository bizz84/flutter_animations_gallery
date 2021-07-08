import 'package:flutter/material.dart';

class SplitView extends StatefulWidget {
  const SplitView({
    Key? key,
    required this.menuBuilder,
    required this.contentBuilder,
    this.breakpoint = 600,
    this.menuWidth = 240,
  }) : super(key: key);
  final WidgetBuilder menuBuilder;
  final WidgetBuilder contentBuilder;
  final double breakpoint;
  final double menuWidth;

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
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: widget.contentBuilder(context),
        drawer: Drawer(
          child: widget.menuBuilder(context),
        ),
      );
    }
  }
}
