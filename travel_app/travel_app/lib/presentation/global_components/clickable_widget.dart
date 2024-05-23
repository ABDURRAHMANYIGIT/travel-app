import 'package:flutter/material.dart';

class ClickableWidget extends StatelessWidget {
  const ClickableWidget({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
