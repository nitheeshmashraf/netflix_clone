import 'package:flutter/material.dart';

class GradientOverlay extends StatelessWidget {
  const GradientOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: double.infinity,
        height: size.height * 0.75,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.8, 0.9],
          colors: [
            Colors.transparent,
            Colors.black,
          ],
        )),
        child: Center(
          child: Container(),
        ),
      ),
    );
  }
}
