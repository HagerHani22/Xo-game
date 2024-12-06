import 'dart:developer' as dev;
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home_screen.dart';

class GameScreen extends StatefulWidget {
  final TextEditingController playerOne;
  final TextEditingController playerTwo;
   const GameScreen({super.key, required this.playerOne, required this.playerTwo});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> elements = ["", "", "", "", "", "", "", "", ""];
  late ConfettiController confettiController;
  AudioPlayer player = AudioPlayer();

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool oTurn = true;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#242c45'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: HexColor('#3e4d6a'),
            ),
            child: IconButton(onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(playerOne: widget.playerOne,
                          playerTwo: widget.playerTwo)), (route) => false);
              widget.playerOne.clear();
              widget.playerTwo.clear();
            }, icon: const Icon(Icons.home, color: Colors.white, size: 30,)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: HexColor('#3e4d6a'),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(image: AssetImage(
                              'assets/images/oplayer.png'),
                            height: 40,
                            width: 40,),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
                            child: Row(children: [
                              Text('${widget.playerOne.text} : ',
                                style: GoogleFonts.eduNswActFoundation(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                              const Spacer(),
                              Text(oScore.toString(),
                                style: GoogleFonts.eduNswActFoundation(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                            ],),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 80,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: HexColor('#3e4d6a'),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(image: AssetImage(
                              'assets/images/xplayer.png'),
                            height: 40,
                            width: 40,),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
                            child: Row(children: [
                              Text('${widget.playerTwo.text} : ',
                                style: GoogleFonts.eduNswActFoundation(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                              const Spacer(),
                              Text(xScore.toString(),
                                style: GoogleFonts.eduNswActFoundation(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                            ],),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text('${oTurn ? widget.playerOne.text : widget.playerTwo
                    .text} Turn ', style: GoogleFonts.eduNswActFoundation(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Stack(
                  children: [
                    Container(
                      height: 380,
                      width: 450,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: HexColor('#3e4d6a'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 10, bottom: 10),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                tappedBox(index);
                              },
                              child: elements[index] == '' ? Container(
                                height: 80,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: HexColor('#242c45'),
                                ),
                              ) : Container(
                                height: 80,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: HexColor('#242c45'),
                                ),
                                child: Image(
                                  image: AssetImage(elements[index]),),
                              ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    clearBoard();
                    setState(() {
                      oScore = 0;
                      xScore = 0;
                    });
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0,
                              vertical: 8.0),
                          child: Icon(Icons.replay_rounded),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text('Restart Game',
                            style: GoogleFonts.eduNswActFoundation(
                                color: HexColor('#242c45'),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),),
                        ),
                      ],),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkWinner() {
    if (elements[0] != "" && elements[0] == elements[1] &&
        elements[1] == elements[2]) {
      showWinnerDialog(
          elements[0] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[3] != "" && elements[3] == elements[4] &&
        elements[4] == elements[5]) {
      showWinnerDialog(
          elements[3] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[6] != "" && elements[6] == elements[7] &&
        elements[7] == elements[8]) {
      showWinnerDialog(
          elements[6] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[0] != "" && elements[0] == elements[3] &&
        elements[3] == elements[6]) {
      showWinnerDialog(
          elements[0] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[1] != "" && elements[1] == elements[4] &&
        elements[4] == elements[7]) {
      showWinnerDialog(
          elements[1] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[2] != "" && elements[2] == elements[5] &&
        elements[5] == elements[8]) {
      showWinnerDialog(
          elements[2] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[0] != "" && elements[0] == elements[4] &&
        elements[4] == elements[8]) {
      showWinnerDialog(
          elements[0] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (elements[2] != "" && elements[2] == elements[4] &&
        elements[4] == elements[6]) {
      showWinnerDialog(
          elements[2] == "assets/images/O.png" ? widget.playerOne.text : widget
              .playerTwo.text);
    }
    else if (filledBoxes == 9) {
      showDrawDialog();
    }
  }

  String playerTurn() {
    return oTurn ? widget.playerOne.text : widget.playerTwo.text;
  }


  void tappedBox(int index) {
    setState(() {
      if (elements[index] == "" && oTurn) {
        elements[index] = "assets/images/O.png";
        filledBoxes++;
        oTurn = false;
      }
      else if (elements[index] == "" && oTurn == false) {
        elements[index] = "assets/images/X.png";
        filledBoxes++;
        oTurn = true;
      }
      checkWinner();
    });
  }

  void showWinnerDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            confettiController.play();
            try {
              await player.play(
                  AssetSource('sound/mixkit-girls-audience-applause-510.wav'));
            } catch (e) {
              debugPrint('Error playing sound: $e');
            }
          });
          return AlertDialog(
            title: Center(child: Text("Congratulations",
              style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),)),
            content: Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: 300,
                  child: Center(
                    child: ConfettiWidget(
                        confettiController: confettiController,
                        blastDirection: pi / 2,
                        maxBlastForce: 5,
                        minBlastForce: 1,
                        emissionFrequency: 0.03,
                        numberOfParticles: 10,
                        gravity: 0
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Center(child: Text(" $winner is Winner \n       🎉👏👏🎉",
                    style: GoogleFonts.eduNswActFoundation(
                        color: HexColor('#242c45'),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Play Again",
                  style: GoogleFonts.eduNswActFoundation(
                      color: HexColor('#517e31'),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),),
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    if (winner == widget.playerOne.text) {
      oScore++;
      dev.log(oScore.toString());
    } else if (winner == widget.playerTwo.text) {
      xScore++;
      dev.log(xScore.toString());
    }
  }

  void showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            try {
              await player.play(
                  AssetSource('sound/mixkit-horror-lose-2028.wav'));
            } catch (e) {
              debugPrint('Error playing sound: $e');
            }
          });
          return AlertDialog(
            title: Center(child: Text("Game Over",
              style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),)),
            content: Center(
              child: Text("It's a Draw",
                style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again',
                  style: GoogleFonts.eduNswActFoundation(
                      color: HexColor('#517e31'),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
              )
            ],
          );
        });
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        elements[i] = '';
      }
    });
    filledBoxes = 0;
  }

}

