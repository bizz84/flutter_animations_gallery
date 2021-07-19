import 'package:flutter/material.dart';

class SplitView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= breakpoint) {
      // wide screen: menu on the left, content on the right
      return Row(
        children: [
          SizedBox(
            width: menuWidth,
            child: menuBuilder(context),
          ),
          Container(width: 0.5, color: Colors.black),
          Expanded(child: contentBuilder(context)),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: contentBuilder(context),
        drawer: Drawer(
          child: menuBuilder(context),
        ),
      );
    }
  }
}
