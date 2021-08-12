import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [drawBackgroundGradient(context), drawBackgroundCircles()],
    );
  }
}

Stack drawBackgroundCircles() {
  return Stack(
    children: [
      Positioned(
        top: 70,
        left: 10,
        child: Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white54,
          ),
        ),
      ),
      Positioned(
        top: 20,
        left: 35,
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white54,
          ),
        ),
      ),
      Positioned(
        top: -20,
        right: -25,
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white54,
          ),
        ),
      ),
      Positioned(
        top: -30,
        right: 40,
        child: Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white54,
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 20,
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white54,
          ),
        ),
      ),
      Positioned(
        bottom: 60,
        right: 20,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white54,
          ),
        ),
      ),
    ],
  );
}

Container drawBackgroundGradient(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(110, 53, 76, 1),
          Color.fromRGBO(130, 147, 153, 1),
        ],
      ),
    ),
  );
}
