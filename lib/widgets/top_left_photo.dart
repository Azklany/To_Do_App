import 'package:flutter/material.dart';

class TopLeftPhoto extends StatelessWidget {
  const TopLeftPhoto({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Image.asset(
            "assets/shape.png",
            width: 120,
            height: 100,
        )
      ],
    );
  }
}
