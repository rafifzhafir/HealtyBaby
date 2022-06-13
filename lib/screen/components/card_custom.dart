import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final Widget child;
  const CardCustom({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        elevation: 5,
        child: child);
  }
}
