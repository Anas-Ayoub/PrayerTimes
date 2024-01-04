import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameCard extends StatelessWidget {
  final String name;
  final String transliteration;
  final int number;

  NameCard(
      {required this.name,
      required this.transliteration,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 37, 36, 49),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14)),
                color: Colors.amber),
            width: double.infinity,
            height: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                number.toString(),
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontSize: 20,
                    height: 1,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Flexible(
            //flex: 3,
            child: Text(
              name,
              style: GoogleFonts.cairo(color: Colors.white),
              softWrap: true,
            ),
          ),
          Expanded(
            //flex: 1,
            child: Text(
              style: GoogleFonts.cairo(
                  color: const Color.fromARGB(255, 160, 150, 150)),
              transliteration,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
