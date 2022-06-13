import 'package:flutter/material.dart';
import 'package:mini_project/screen/constants/color.dart';

class FloatingBtn extends StatelessWidget {
  final VoidCallback onPressed;
  const FloatingBtn({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: kPrimaryColor,
      child: const Icon(Icons.add),
    );
  }
}
