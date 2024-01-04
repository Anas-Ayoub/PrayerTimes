import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdkarList extends StatelessWidget {
  const AdkarList({super.key, required this.adkarList});

  final List<dynamic> adkarList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            //color: const Color.fromARGB(104, 33, 149, 243),
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 5, left: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 53, 51, 63),
                        border: Border.all(color: Colors.blue, width: 1.5),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      child: Center(
                        child: Text(
                          "عدد\nالتكرير",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 5, left: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 53, 51, 63),
                        border: Border.all(color: Colors.blue, width: 1.5),
                        /*boxShadow: [
                          BoxShadow(color: Colors.blue, blurRadius: 10)
                        ],*/
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      child: Center(
                        child: Text(
                          "الأذكار",
                          textAlign: TextAlign.end,
                          style: GoogleFonts.cairo(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: adkarList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 3.5),
                  color: const Color.fromARGB(255, 53, 51, 63),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 12),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(207, 33, 149, 243),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        height: 45,
                        width: 45,
                        child: Center(
                          child: Text(
                            adkarList[index]['count'].toString(),
                            style: GoogleFonts.cairo(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      //Container()
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 8, top: 8, bottom: 8),
                          child: Text(
                            adkarList[index]['text'],
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
