import 'dart:math';

import 'package:flutter/material.dart';

class mymario extends StatelessWidget {
  const mymario({super.key, this.direction , this.size,this.midRun});
  final direction;
  final midRun;
  final size ;

  @override
  Widget build(BuildContext context) {
    if (direction == 'right'){
      return Container(
        width: size,
        height: size,
          child: midRun
          ? Image.asset('lib/assets/moving.png')
          :Image.asset('lib/assets/standingmario.png'),
      );

    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midRun
              ? Image.asset('lib/assets/moving.png')
              :Image.asset('lib/assets/standingmario.png'),
        ),
      );
    }
  }
}
