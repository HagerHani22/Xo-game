import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tic_tac_game/components/components.dart';

class RuleScreen extends StatelessWidget {
  const RuleScreen({super.key});

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
              child: IconButton(onPressed: () => Navigator.pop(context) , icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30,))),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Game Rules", style: GoogleFonts.eduNswActFoundation(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Divider(indent: 5, endIndent: 200,),
              ),
            customRow(text: 'WIN', image1: 'assets/images/win.png', image2: 'assets/images/crossWin.png', explainText: 'Get 3 marks in a row,Player wins,Game ends.'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(indent: 5, endIndent: 10, color: Colors.white,),
            ),
            customRow(text: 'DEFEAT', image1: 'assets/images/defeat.png', image2: 'assets/images/lineDefate.png', explainText: 'Opponent gets 3 marks in a row,Player loses,Game ends.'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(indent: 5, endIndent: 10, color: Colors.white,),
            ),
            customRow(text: 'DRAW', image1: 'assets/images/draw.png', image2: 'assets/images/draw2.png', explainText: 'Board full,no 3 in a row,No winner,Game ends.'),
          ],
        ),
      ),
    );
  }
}
