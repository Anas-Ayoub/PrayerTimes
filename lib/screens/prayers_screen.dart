import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayertime/screens/adkar_screen.dart';
import 'package:prayertime/screens/asmaa_screen.dart';
import 'package:prayertime/services/prayer_api.dart';
import 'package:prayertime/widgets/button_navbar.dart';
import 'package:prayertime/widgets/header_Image.dart';
import 'package:prayertime/widgets/prayer_card.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({Key? key}) : super(key: key);
  static late Function(bool b) setArrowShow;
  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  bool showArrow = false;
  late Future<Map<String, String>> prayerTimesFuture;
  Map<String, String>? prayerTimesTZ;
  Map<int, String> getTitle = {
    0: "أوقات الصلاة",
    1: "أسماء الله الحسنى",
    2: "أذكار"
  };
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[];
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();

    PrayerScreen.setArrowShow = (b) {
      setState(() {
        showArrow = b;
      });
    };
    prayerTimesFuture = getTimingsForDate(currentDate);

    // Fetch prayer times and update the instance variable
    prayerTimesFuture.then((data) {
      setState(() {
        prayerTimesTZ = data;
      });
    });

    // Initialize _widgetOptions after getting prayerTimes
    _widgetOptions.addAll([
      Expanded(
        child: FutureBuilder<Map<String, String>>(
          future: prayerTimesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("lib/assets/icons/WMDx.gif"),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            }

            var prayerTimes = removeTimeZoneAndFilter(snapshot.data!);
            var arabicNames = {
              "Fajr": "الفجر",
              "Dhuhr": "الظهر",
              "Asr": "العصر",
              "Maghrib": "المغرب",
              "Isha": "العشاء",
            };

            return ListView.builder(
              itemCount: prayerTimes.length,
              itemBuilder: (context, index) {
                List<String> keysList = prayerTimes.keys.toList();
                String key = keysList[index];
                var time = prayerTimes![key]?.split(' ')[0] ?? '';
                var arabicName = arabicNames[key] ?? '';
                return PrayerCard(
                  keyName: key,
                  arabicName: arabicName,
                  time: time,
                );
              },
            );
          },
        ),
      ),
      NamesList(),
      AdkarScreen(setArrowShow: PrayerScreen.setArrowShow),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String? title = getTitle[_selectedIndex];

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            showArrow = false;
            _selectedIndex = index;
          });
        },
      ),
      backgroundColor: Color.fromARGB(192, 26, 24, 24),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            prayerTimesTZ == null
                ? HeaderImage(
                    prayerTimes: removeTimeZoneAndFilter(prayerTimesTZ),
                    showCounter: false,
                  )
                : HeaderImage(
                    prayerTimes: removeTimeZoneAndFilter(prayerTimesTZ),
                    showCounter: true,
                  ),
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(0, 0),
                ),
              ], color: Color.fromARGB(255, 44, 43, 59)),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: showArrow
                        ? IconButton(
                            onPressed: () {
                              AdkarScreen.empty();
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 38,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  Center(
                    child: Text(
                      title ?? "",
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            _widgetOptions.elementAt(_selectedIndex),
          ],
        ),
      ),
    );
  }
}

Map<String, String> removeTimeZoneAndFilter(Map<String, String>? inputMap) {
  List<String> validTimes = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];
  Map<String, String> outputMap = {};
  if (inputMap != null) {
    validTimes.forEach((time) {
      if (inputMap.containsKey(time)) {
        String cleanedValue =
            inputMap[time]!.replaceAll(RegExp(r'\s*\(\+\d+\)'), '').trim();
        outputMap[time] = cleanedValue;
      }
    });
  }
  return outputMap;
}
