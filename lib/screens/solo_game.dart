import 'dart:developer' as dev;
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'home_screen.dart';

class SoloGame extends StatefulWidget {
  final TextEditingController playerOne;
  final TextEditingController playerTwo;

  const SoloGame({super.key, required this.playerOne, required this.playerTwo});

  @override
  State<SoloGame> createState() => _SoloGameState();
}

class _SoloGameState extends State<SoloGame> {
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
            child: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            playerOne: widget.playerOne,
                            playerTwo: widget.playerTwo)),
                    (route) => false);
                widget.playerOne.clear();
                widget.playerTwo.clear();
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
            ),
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
                          const Image(
                            image: AssetImage('assets/images/oplayer.png'),
                            height: 40,
                            width: 40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Text(
                                  '${widget.playerOne.text} : ',
                                  style: GoogleFonts.eduNswActFoundation(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  oScore.toString(),
                                  style: GoogleFonts.eduNswActFoundation(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
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
                          const Image(
                            image: AssetImage('assets/images/xplayer.png'),
                            height: 40,
                            width: 40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Text(
                                  'Bot : ',
                                  style: GoogleFonts.eduNswActFoundation(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  xScore.toString(),
                                  style: GoogleFonts.eduNswActFoundation(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${oTurn ? widget.playerOne.text : 'Bot'} Turn ',
                  style: GoogleFonts.eduNswActFoundation(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                tappedBox(index);
                              },
                              child: elements[index] == ''
                                  ? Container(
                                      height: 80,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: HexColor('#242c45'),
                                      ),
                                    )
                                  : Container(
                                      height: 80,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: HexColor('#242c45'),
                                      ),
                                      child: Image(
                                        image: AssetImage(elements[index]),
                                      ),
                                    ),
                            ),
                          );
                        },
                        itemCount: 9,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
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

  void tappedBox(int index) {
    // If the selected box is already filled, return
    if (elements[index] != '') return;

    setState(() {
      // Update the box with the current player's symbol
      elements[index] = oTurn ? 'assets/images/O.png' : 'assets/images/X.png';
      filledBoxes++;
    });

    // Check if the player has won
    if (checkWinner(elements[index])) {
      showWinnerDialog(oTurn ? widget.playerOne.text : "Bot");
      return;
    }
    // Check for a draw
    if (filledBoxes == 9) {
      showDrawDialog();
      return;
    }
    // Switch turn
    oTurn = !oTurn;

    // If it's the bot's turn
    if (!oTurn) {
      Future.delayed(const Duration(milliseconds: 500), () {
        botMove();
      });
    }
  }

  void botMove() {
    int bestMove = getBestMove();
    setState(() {
      elements[bestMove] = 'assets/images/X.png';
      filledBoxes++;
    });

    // Check if the bot has won
    if (checkWinner(elements[bestMove])) {
      showWinnerDialog('Bot');
      return;
    }
    // Check for a draw
    if (filledBoxes == 9) {
      showDrawDialog();
      return;
    }

    // Switch back to the player's turn
    oTurn = true;
  }

// Calculate the bot's move
  int getBestMove() {
    // Check for a winning move
    for (int i = 0; i < 9; i++) {
      if (elements[i] == '') {
        elements[i] = 'assets/images/X.png';
        if (checkWinner('assets/images/X.png')) {
          elements[i] = ''; // Undo move
          return i;
        }
        elements[i] = ''; // Undo move
      }
    }

    // Check for a blocking move
    for (int i = 0; i < 9; i++) {
      if (elements[i] == '') {
        elements[i] = 'assets/images/O.png';
        if (checkWinner('assets/images/O.png')) {
          elements[i] = ''; // Undo move
          return i;
        }
        elements[i] = ''; // Undo move
      }
    }

    // Default to center, corners, or random move
    List<int> priorityMoves = [4, 0, 2, 6, 8, 1, 3, 5, 7];
    for (int move in priorityMoves) {
      if (elements[move] == '') {
        return move;
      }
    }

    return -1; // Should never reach here
  }

// Function to check for a winner
  bool checkWinner(String playerSymbol) {
    // Define winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var combo in winningCombinations) {
      if (elements[combo[0]] == playerSymbol &&
          elements[combo[1]] == playerSymbol &&
          elements[combo[2]] == playerSymbol) {
        return true;
      }
    }
    return false;
  }

// Show win dialog
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
    } else if (winner == "Bot") {
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
            content: Text("It's a Draw",
              style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),
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
// Clear the board
  void clearBoard() {
    setState(() {
      elements = ["", "", "", "", "", "", "", "", ""];
      filledBoxes = 0;
      oTurn = true;
    });
  }

}
