import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customRow(
    {required String text,
    required String image1,
    required String image2,
    required String explainText}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Image(image: AssetImage(image1)),
      const SizedBox(width: 16,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.eduNswActFoundation(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              explainText,
              style: GoogleFonts.eduNswActFoundation(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
       Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Image(image: AssetImage(image2)),
             )
    ],
  );
}
