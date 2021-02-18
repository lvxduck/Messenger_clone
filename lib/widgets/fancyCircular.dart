import 'package:flutter/material.dart';

const TWO_PI = 3.14 * 2;

class FancyCircular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    return Center(
      child: Container(
        width: size,
        height: size,
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return SweepGradient(
                    startAngle: 0.0,
                    endAngle: TWO_PI,
                    stops: [0.7, 0.7],
                    // 0.0 , 0.5 , 0.5 , 1.0
                    center: Alignment.center,
                    colors: [Colors.blue, Colors.yellow]).createShader(rect);
              },
              child: Container(
                width: size,
                height: size,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
            Center(
              child: Container(
                width: size - 40,
                height: size - 40,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  "RPS",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
