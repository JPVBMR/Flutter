import 'package:flutter/material.dart';
import 'package:first_app/jbcustom_container.dart'; /* Import custom container widget class created */

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: JBCustomContainer(gradientColorsToUse: [
          Color.fromARGB(255, 0, 80, 47),
          Color.fromARGB(255, 0, 165, 137),
        ]),
      ),
    ),
  );
}
