import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _allAvailableColors = <String, MaterialColor>{
  'red': Colors.red,
  'indigo': Colors.indigo,
  'green': Colors.green,
  'brown': Colors.brown,
};

final colorKeyProvider = StateProvider<String>((ref) {
  return _allAvailableColors.keys.first;
});

final colorProvider = Provider<MaterialColor>((ref) {
  final colorKey = ref.watch(colorKeyProvider).state;
  return _allAvailableColors[colorKey]!;
});

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Theme Selection',
      body: Center(
        child: ListView.builder(
          itemCount: _allAvailableColors.length,
          itemBuilder: (context, index) {
            return Consumer(builder: (context, ref, _) {
              final colorName = _allAvailableColors.keys.toList()[index];
              return ThemeListTile(
                color: _allAvailableColors[colorName]!,
                colorName: colorName,
                onSelected: () => ref.read(colorKeyProvider).state = colorName,
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
            foregroundColor: Colors.white, backgroundColor: color, // foreground
          ),
          child: Text(colorName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
