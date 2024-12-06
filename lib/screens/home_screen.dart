import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tic_tac_game/screens/rules_screen.dart';

import 'game_screen.dart';
import 'solo_game.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController playerOne ;
  final TextEditingController playerTwo ;
   const HomeScreen({super.key, required this.playerOne, required this.playerTwo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#242c45'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Image(image: AssetImage('assets/images/img.png'))),
            const SizedBox(height: 20),
             Text('Tic-Tac-Toe', style: GoogleFonts.eduNswActFoundation(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 120),
            GestureDetector(
              onTap: () {
                addPlayerName(context: context, playerOne: playerOne, playerTwo: playerTwo);
              },
              child: Container(
                width: 300,
                height: 60,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Icon(Icons.person),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text('Play Solo', style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  ],),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                addPlayersName(context: context, playerOne: playerOne, playerTwo: playerTwo);
              },
              child: Container(
                width: 300,
                height: 60,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
        
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                      child: Icon(Icons.group_rounded),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text('Play With a Friend', style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ],),
              ),
            ),
            const SizedBox(height: 60),
        
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RuleScreen()));
              },
              child: Container(
                width: 300,
                height: 60,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: RadialGradient(
                    colors: [
                      HexColor('#a7b8e3'),
                      HexColor('#9bacd8'),
                    ],
                  )
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text('Game Rules', style: GoogleFonts.eduNswActFoundation(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}


Future addPlayersName({
  required BuildContext context,
  required TextEditingController playerOne,
  required TextEditingController playerTwo,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        var formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: AlertDialog(
        title:  Text('Enter Players Names',style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 30, fontWeight: FontWeight.bold),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: playerOne,
              style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),
              decoration:  InputDecoration(
                hintText: 'Player 1',
                hintStyle: GoogleFonts.eduNswActFoundation(),
                suffixIcon: const Icon(Icons.circle_outlined),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter player 1 name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: playerTwo,
              style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),
              decoration:  InputDecoration(
                hintText: 'Player 2',
                hintStyle: GoogleFonts.eduNswActFoundation(),
                suffixIcon: const Icon(Icons.close_rounded),

              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter player 2 name';
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () {
            if( formKey.currentState!.validate()) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GameScreen(playerOne: playerOne , playerTwo: playerTwo)));
            }
          }, child: Text('Start Game', style: GoogleFonts.eduNswActFoundation( color: HexColor('#517e31'),fontSize: 25, fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  });
}


Future addPlayerName({
  required BuildContext context,
  required TextEditingController playerOne,
  required TextEditingController playerTwo,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        var formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: AlertDialog(
            title:  Text('Enter Your Name',style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 30, fontWeight: FontWeight.bold),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: playerOne,
                  style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),
                  decoration:  InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: GoogleFonts.eduNswActFoundation(),
                    suffixIcon: const Icon(Icons.circle_outlined),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Your Name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: playerTwo,
                  style: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),
                  decoration:  InputDecoration(
                    hintText: 'Player 2',
                    hintStyle: GoogleFonts.eduNswActFoundation(),
                    suffixIcon: const Icon(Icons.close_rounded),
                    labelText: 'Bot',
                    labelStyle: GoogleFonts.eduNswActFoundation(color: HexColor('#242c45'), fontSize: 20, fontWeight: FontWeight.bold),
                    enabled: false

                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () {
                if( formKey.currentState!.validate()) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SoloGame(playerOne: playerOne, playerTwo: playerTwo)));
                }
              }, child: Text('Start Game', style: GoogleFonts.eduNswActFoundation( color: HexColor('#517e31'),fontSize: 25, fontWeight: FontWeight.bold),)),
            ],
          ),
        );
      });
}