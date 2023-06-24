import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animations_gallery/custom_button.dart';
import 'package:flutter_animations_gallery/gallery_navigation/page_scaffold.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  /// Global key used to manipulate the state of the StopwatchTickerUI
  final _tickerUIKey = GlobalKey<StopwatchTickerUIState>();
  bool _isRunning = false;

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
    });
    _tickerUIKey.currentState?.toggleRunning(_isRunning);
  }

  void _reset() {
    setState(() {
      _isRunning = false;
    });
    _tickerUIKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Stopwatch with Ticker',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ticker dependent UI
              StopwatchTickerUI(
                key: _tickerUIKey,
              ),
              const SizedBox(height: 32),
              // start/stop button
              CustomButton(
                onPressed: _toggleRunning,
                title: _isRunning ? 'Stop' : 'Start',
              ),
              const SizedBox(height: 32),
              // reset button
              CustomButton(
                onPressed: _reset,
                title: 'Reset',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget that manages the Ticker and only rebuilds the UI that depends on it
class StopwatchTickerUI extends StatefulWidget {
  const StopwatchTickerUI({Key? key}) : super(key: key);

  @override
  StopwatchTickerUIState createState() => StopwatchTickerUIState();
}

class StopwatchTickerUIState extends State<StopwatchTickerUI>
    with SingleTickerProviderStateMixin {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _previouslyElapsed + _currentlyElapsed;
  late final Ticker _ticker;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _currentlyElapsed = elapsed;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void toggleRunning(bool isRunning) {
    setState(() {
      if (isRunning) {
        _ticker.start();
      } else {
        _ticker.stop();
        _previouslyElapsed += _currentlyElapsed;
        _currentlyElapsed = Duration.zero;
      }
    });
  }

  void reset() {
    _ticker.stop();
    setState(() {
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElapsedTimeText(
      elapsed: _elapsed,
    );
  }
}

class ElapsedTimeText extends StatelessWidget {
  const ElapsedTimeText({Key? key, required this.elapsed}) : super(key: key);
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final hundreds = (elapsed.inMilliseconds / 10) % 100;
    final seconds = elapsed.inSeconds % 60;
    final minutes = elapsed.inMinutes % 60;
    final hundredsStr = hundreds.toStringAsFixed(0).padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');
    const digitWidth = 24.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeDigit(minutesStr.substring(0, 1), width: digitWidth),
        TimeDigit(minutesStr.substring(1, 2), width: digitWidth),
        const TimeDigit(':', width: 6),
        TimeDigit(secondsStr.substring(0, 1), width: digitWidth),
        TimeDigit(secondsStr.substring(1, 2), width: digitWidth),
        const TimeDigit('.', width: 6),
        TimeDigit(hundredsStr.substring(0, 1), width: digitWidth),
        TimeDigit(hundredsStr.substring(1, 2), width: digitWidth),
      ],
    );
  }
}

class TimeDigit extends StatelessWidget {
  const TimeDigit(this.text, {Key? key, required this.width}) : super(key: key);
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: const TextStyle(fontSize: 40),
        textAlign: TextAlign.center,
      ),
    );
  }
}
