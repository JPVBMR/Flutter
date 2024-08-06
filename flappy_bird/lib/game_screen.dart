import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flappy_bird/bird_widget.dart';
import 'package:flappy_bird/pipe_widget.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;
  Timer? timer;
  bool gameHasStarted = false;
  int score = 0;

  // Pipes
  static List<double> pipeX = [2, 3.5];
  static double pipeWidth = 60;
  List<double> pipeHeight = [200, 150]; // Random heights for the example

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void startGame() {
    gameHasStarted = true;
    score = 0;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      this.timer = timer;
      setState(() {
        time += 0.05;
        height = gravity * time * time + velocity * time;
        birdY = initialPos - height;

        // Move pipes
        for (int i = 0; i < pipeX.length; i++) {
          pipeX[i] -= 0.05;
        }

        // Reset pipes
        for (int i = 0; i < pipeX.length; i++) {
          if (pipeX[i] < -1.5) {
            pipeX[i] += 3;
            pipeHeight[i] =
                100 + Random().nextInt(200).toDouble(); // Randomize pipe height
          }
        }

        // Check for collision
        if (birdY > 1 || birdY < -1) {
          timer.cancel();
          resetGame();
        }

        for (int i = 0; i < pipeX.length; i++) {
          if (pipeX[i] < 0.1 && pipeX[i] > -0.1) {
            if (birdY < -1 + pipeHeight[i] / 400 ||
                birdY > 1 - pipeHeight[i] / 400) {
              timer.cancel();
              resetGame();
            }
          }
        }

        // Update score
        score += 1;
      });
    });
  }

  void resetGame() {
    setState(() {
      birdY = 0;
      initialPos = birdY;
      height = 0;
      time = 0;
      pipeX = [2, 3.5];
      pipeHeight = [200, 150]; // Reset to initial heights
      gameHasStarted = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Bird(birdY: birdY),
                      for (int i = 0; i < pipeX.length; i++)
                        Pipe(
                            pipeX: pipeX[i],
                            pipeHeight: pipeHeight[i],
                            isBottomPipe: false),
                      for (int i = 0; i < pipeX.length; i++)
                        Pipe(
                            pipeX: pipeX[i],
                            pipeHeight: 400 - pipeHeight[i],
                            isBottomPipe: true),
                      Container(
                        alignment: Alignment(0, -0.3),
                        child: gameHasStarted
                            ? const Text("")
                            : const Text(
                                "TAP TO PLAY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                      // Score box
                      Container(
                        alignment: Alignment(-1, -1),
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Score: $score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
