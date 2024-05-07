import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function;
  static bool holdingBoutton = false;
  MyButton({this.child , this.function});

  bool userIsHoldingDown(){
    return holdingBoutton;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details){
        holdingBoutton = true;
        function();
        },
      onTapUp:(details){
        holdingBoutton = false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.brown[300],
          child: child,
        ),
      ),
    );
  }
}
