import 'package:flutter/material.dart';

class Pipe extends StatelessWidget {
  final double pipeX;
  final double pipeHeight;
  final bool isBottomPipe;

  Pipe({
    required this.pipeX,
    required this.pipeHeight,
    required this.isBottomPipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      alignment: Alignment(pipeX, isBottomPipe ? 1 : -1),
      child: Transform(
        alignment: Alignment.center,
        transform: isBottomPipe
            ? Matrix4.identity()
            : Matrix4.rotationZ(3.14159), // Rotate 180 degrees
        child: Image.asset(
          'assets/pipe.png',
          width: 80,
          height: pipeHeight,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
