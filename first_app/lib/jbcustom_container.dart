import 'package:flutter/material.dart';
import 'package:first_app/jbcustom_text.dart';

/* Global Variable Declarations/Initialization */
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class JBCustomContainer extends StatelessWidget {
  /*Constructor(s):  [OR:  JBCustomContainer({key}) : super(key: key); ]*/
  const JBCustomContainer({super.key, required this.gradientColorsToUse});

  /* Class Properties/Variables */
  final List<Color> gradientColorsToUse;

  /* Build is called from the Stateless Widget and overrided by this method */
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColorsToUse,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/dice-2.png',
          width: 200,
        ),
      ),
    );
  }
}
