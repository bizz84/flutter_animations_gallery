import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final durationValues = [
  150,
  250,
  400,
  650,
  1000,
];

final durationIndexProvider = StateProvider<int>((ref) {
  return 1;
});

final durationProvider = Provider<Duration>((ref) {
  final durationIndex = ref.watch(durationIndexProvider).state;
  return Duration(milliseconds: durationValues[durationIndex]);
});

class DurationPage extends ConsumerWidget {
  const DurationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final durationIndex = ref.watch(durationIndexProvider).state;
    final durationValue = durationValues[durationIndex];
    return PageScaffold(
      title: 'Duration',
      body: Center(
        child: Row(children: [
          const Spacer(),
          SizedBox(
            width: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Use the slider to choose the duration of the implicit animations in the app:',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 32.0),
                Text(
                  '$durationValue ms',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Slider(
                  min: 0,
                  max: durationValues.length - 1,
                  value: durationIndex.toDouble(),
                  onChanged: (value) =>
                      ref.read(durationIndexProvider).state = value.toInt(),
                  divisions: 4,
                ),
              ],
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
