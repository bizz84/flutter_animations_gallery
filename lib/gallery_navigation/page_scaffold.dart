import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    Key? key,
    required this.title,
    this.showDrawerIcon = true,
    this.actions = const [],
    required this.body,
  }) : super(key: key);
  final String title;
  final bool showDrawerIcon;
  final List<Widget> actions;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: showDrawerIcon
            ? IconButton(
                icon: Icon(Icons.menu),
                // the parent Scaffold has a drawer, not the one on this widget
                onPressed: () => Scaffold.of(context).openDrawer(),
              )
            : null,
        title: Text(title),
        actions: actions,
      ),
      body: body,
    );
  }
}
