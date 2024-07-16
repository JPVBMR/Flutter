import 'package:flutter/material.dart';

class MealItemProperty extends StatelessWidget {
  const MealItemProperty({
    super.key,
    required this.iconToShow,
    required this.labelToShow,
  });

  final IconData iconToShow;
  final String labelToShow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconToShow,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(
          labelToShow,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
