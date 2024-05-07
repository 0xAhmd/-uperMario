import 'package:flutter/material.dart';

class myMushroom extends StatelessWidget {
  const myMushroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      child: Image.asset('lib/assets/mushroom.png'),
    ) ;
  }
}
