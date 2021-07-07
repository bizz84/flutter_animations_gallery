import 'package:flutter/material.dart';

class SplitViewShowMenuButton extends StatelessWidget {
  const SplitViewShowMenuButton(
      {Key? key, required this.isShowing, this.onPressed})
      : super(key: key);
  final bool isShowing;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        child: Icon(
          isShowing ? Icons.arrow_back : Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
