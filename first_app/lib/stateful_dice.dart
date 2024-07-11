import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

/* Private State Class */
class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-2.png';

  /* Methods/Functions */
  void onPressRollDice() {
    /* Generate a random number [0-6] */
    var randomNumber = Random().nextInt(6) + 1;
    setState(() {
      activeDiceImage =
          'assets/images/dice-$randomNumber.png'; // Use StatefulWidget
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      /* Vertically Centered */
      children: [
        Image.asset(
          activeDiceImage,
          width: 200,
        ),
        /* Padding Option 2: const SizedBox(height: 20) */
        TextButton(
          onPressed: onPressRollDice,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(top: 20),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 25,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
