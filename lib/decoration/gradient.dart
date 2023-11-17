import 'package:flutter/material.dart';

class GradientDecoration extends StatelessWidget {
  const GradientDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 0, 112, 204),
              Color.fromARGB(255, 165, 198, 255),
            ]),
      )),
    );
  }
}
