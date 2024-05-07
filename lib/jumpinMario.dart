import 'dart:math';

import 'package:flutter/material.dart';
class jumpinMario extends StatelessWidget {
  const jumpinMario({super.key , this.direction , this.size});
  final direction;
  final size ;
  @override
  Widget build(BuildContext context) {
    if (direction == 'right'){
      return Container(
        width: size,
        height: size,
        child: Image.asset("lib/assets/Jumpingmario.png"),
      );
    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: Image.asset("lib/assets/Jumpingmario.png"),
        ),
      );
    }
  }
}
