import 'package:flutter/material.dart';

class CommonHeaderWrap extends StatelessWidget {
  const CommonHeaderWrap({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: child,
    );
  }
}
