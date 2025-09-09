import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    this.showDrawerIcon = true,
    this.actions = const [],
    this.floatingActionButton,
    this.body,
  });
  final String title;
  final bool showDrawerIcon;
  final List<Widget> actions;
  final Widget? floatingActionButton;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final hasParentDrawer = Scaffold.maybeOf(context)?.hasDrawer ?? false;
    return Scaffold(
      appBar: AppBar(
        leading: showDrawerIcon && hasParentDrawer
            ? IconButton(
                icon: const Icon(Icons.menu),
                // if the parent Scaffold (not the one just above) has a drawer, open it
                onPressed: () => Scaffold.maybeOf(context)?.openDrawer(),
              )
            : null,
        title: Text(title),
        actions: actions,
        //brightness: Brightness.dark,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
