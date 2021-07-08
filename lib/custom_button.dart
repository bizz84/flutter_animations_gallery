import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(title,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
