import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario/Mushrooms.dart';
import 'package:mario/jumpinMario.dart';
import 'bouttons.dart';
import 'mario.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double mariox = 0;
  static double marioy = 1;
  double marioSize = 50;
  double mushroomx = 0.5;
  double mushroomy = 1;
  double time = 0;
  double height = 0;
  double initHeight = marioy;
  bool isJumping = false; // Added to track jumping state
  String direction = 'right';
  bool midRun = false;
  bool midJump = false;


  var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, fontSize: 20),
  );

  void eatMushrooms() {
    if ((mariox - mushroomx).abs() < 0.05 && (marioy - mushroomy).abs() < 0.05) {
      setState(() {
        mushroomx = 2;
        marioSize = 80;
      });
    }
  }



  void preJump() {
    time = 0;
    initHeight = marioy;
  }

  void jump() {
    midJump = true;
    if (!isJumping) { // Check if Mario is not already jumping
      isJumping = true; // Set jumping state to true
      preJump(); // Initialize jump parameters
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if (height <= 0) {
          setState(() {
            midJump = false;
            marioy = initHeight;
            isJumping = false; // Reset jumping state
          });
          timer.cancel();
        } else {
          setState(() {
            marioy = initHeight - height;
          });
        }
      });
    }
  }

  void moveRight(){


    direction = 'right';
    eatMushrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      eatMushrooms();
      if (MyButton().userIsHoldingDown() == true && (mariox +0.02) <1 )
      {
        setState(() {
          mariox += 0.02;
          midRun = !midRun;
        });
      }else{
        timer.cancel();
      }
    });
  }

  void moveLeft(){
    direction = 'left';
    eatMushrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      eatMushrooms();
      if (MyButton().userIsHoldingDown() == true && (mariox -0.02) >-1 )
      {
        setState(() {
          mariox -= 0.02;
          midRun = !midRun;
        });
      }else{
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      alignment: Alignment(mariox,marioy),
                      duration: Duration(milliseconds: 0),
                      child: midJump? jumpinMario(
                        direction: direction,
                        size: marioSize,
                      )
                          :mymario(
                        size: marioSize,
                        direction: direction,
                        midRun: midRun,
                      ), // Call the mymario() method
                    ),
                  ),
                  Container(
                    alignment: Alignment(mushroomx,mushroomy),
                    child:myMushroom(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [Text('MARIO' , style: gameFont,)
                          , SizedBox(height: 8,)
                          ,Text('0000',style: gameFont ) ],),
                        Column(children: [Text('WORLD' , style: gameFont)
                          ,SizedBox(height: 8,)
                          ,Text('1-1' , style: gameFont)],)
                        ,Column(children: [Text('TIME' , style: gameFont) ,
                          SizedBox(height: 8,)
                          ,Text('5555' , style: gameFont)],)
                      ],),
                  )
                ],
              )
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Added comma and fixed MainAxisAlignment
                children: [
                  MyButton(
                    child: Icon(Icons.arrow_back, color:Colors.white), // Fixed typo: icons -> Icons
                    function:moveLeft ,),

                  MyButton(
                    child: Icon(Icons.arrow_upward, color:Colors.white ),
                    function: jump,// Fixed typo: icons -> Icons
                  ),
                  MyButton(
                    child: Icon(Icons.arrow_forward, color:Colors.white), // Fixed typo: icons -> Icons
                    function: moveRight,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
