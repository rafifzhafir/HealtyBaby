import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final String urlIcon;
  final Color color;

  const CardMenu({
    Key? key,
    required this.name,
    required this.urlIcon,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Image.asset(urlIcon),
            ),
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 13),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
