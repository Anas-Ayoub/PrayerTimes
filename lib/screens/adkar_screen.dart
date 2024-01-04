import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayertime/data/adkar.dart';
import 'package:prayertime/screens/prayers_screen.dart';
import 'package:prayertime/widgets/Adkar_list.dart';

class AdkarScreen extends StatefulWidget {
  const AdkarScreen({super.key, required this.setArrowShow});
  final Function(bool) setArrowShow;
  static late Function() empty;
  static List<dynamic>? data;

  @override
  State<AdkarScreen> createState() => _AdkarScreenState();
}

class _AdkarScreenState extends State<AdkarScreen> {
  getAdkarList(int id) {
    setState(() {
      AdkarScreen.data = AdkarData.getArrayById(id);
      print("LENGHT IS : " + AdkarScreen.data!.length.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    AdkarScreen.empty = () {
      setState(() {
        AdkarScreen.data = null;
        PrayerScreen.setArrowShow(false);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories =
        AdkarData.getCategoriesOrderedByLength();

    return AdkarScreen.data == null
        ? Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    widget.setArrowShow(true),
                    getAdkarList(categories[index]['id'])
                  },
                  child: Card(
                    color: Color.fromARGB(255, 37, 36, 49),
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            categories[index]['category'],
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Card(
                          color: Colors.amber,
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: Text(
                                index.toString(),
                                style: GoogleFonts.cairo(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ), //Text(categories[index]['category'])
                  ),
                );
              },
            ),
          )
        : AdkarList(adkarList: AdkarScreen.data!);
  }
}

/*
              onTap: () {
                // Handle tapping on a category (navigate to another screen, etc.)
                int categoryId = categories[index]['id'];
                List<Map<String, dynamic>> categoryArray =
                    AdkarData.getArrayById(categoryId);
                // Do something with the categoryArray
              },
*/