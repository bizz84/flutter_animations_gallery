import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/page_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final allDarkColors = <String, MaterialColor>{
  'red': Colors.red,
  'indigo': Colors.indigo,
  'green': Colors.green,
  'brown': Colors.brown,
};

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Theme Selection',
      body: Center(
        child: ListView.builder(
          itemCount: allDarkColors.length,
          itemBuilder: (context, index) {
            return Consumer(builder: (context, ref, _) {
              final colorName = allDarkColors.keys.toList()[index];
              return ThemeListTile(
                color: allDarkColors[colorName]!,
                colorName: colorName,
                onSelected: () => ref.read(themeIndexProvider).state = index,
              );
            });
          },
        ),
      ),
    );
  }
}

class ThemeListTile extends StatelessWidget {
  const ThemeListTile(
      {Key? key, required this.color, required this.colorName, this.onSelected})
      : super(key: key);
  final MaterialColor color;
  final String colorName;
  final VoidCallback? onSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onSelected,
          style: ElevatedButton.styleFrom(
            primary: color, // background
            onPrimary: Colors.white, // foreground
          ),
          child: Text(colorName,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white)),
        ),
      ),
    );
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        height: 60,
        color: color,
      ),
    );
  }
}
