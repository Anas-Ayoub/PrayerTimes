import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextPrayerCounter extends StatefulWidget {
  final Map<String, String> prayerTimes;

  NextPrayerCounter({required this.prayerTimes});

  @override
  _NextPrayerCounterState createState() => _NextPrayerCounterState();
}

class _NextPrayerCounterState extends State<NextPrayerCounter> {
  late Timer _timer;
  late String timeDifference;
  late String upcomingPrayer;
  var arabicNames = {
    "Fajr": "الفجر",
    "Dhuhr": "الظهر",
    "Asr": "العصر",
    "Maghrib": "المغرب",
    "Isha": "العشاء",
  };

  @override
  void initState() {
    super.initState();
    updateDifference();

    // Set up a periodic timer to update the time difference every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateDifference();
    });
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double timeIndicator = 10;

    return Center(
      child: Container(
        //decoration: BoxDecoration(border: Border.all(width: 5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              timeDifference,
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontSize: 35,
                height: 1.2,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ساعات',
                  style: GoogleFonts.cairo(
                    fontSize: timeIndicator,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                    width: 18), // Adjust the width based on your preference
                Text(
                  'دقائق',
                  style: GoogleFonts.cairo(
                    fontSize: timeIndicator,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                    width: 22), // Adjust the width based on your preference
                Text(
                  'ثواني',
                  style: GoogleFonts.cairo(
                    fontSize: timeIndicator,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // Add more rows or widgets as needed
          ],
        ),
      ),
    );
  }

  void updateDifference() {
    if (widget.prayerTimes.isNotEmpty) {
      setState(() {
        // Get the current local time
        DateTime now = DateTime.now();
        String currentTime =
            "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}";

        // Find the upcoming prayer time
        upcomingPrayer = findUpcomingPrayer(currentTime);

        // Calculate the time difference with the Arabic name
        timeDifference = calculateTimeDifference(
            widget.prayerTimes[upcomingPrayer]!, arabicNames[upcomingPrayer]!);
      });
    }
  }

  String calculateTimeDifference(String targetTime, String arabicPrayerName) {
    DateTime now = DateTime.now();
    List<String> targetTimeParts = targetTime.split(':');
    DateTime targetDateTime = DateTime(now.year, now.month, now.day,
        int.parse(targetTimeParts[0]), int.parse(targetTimeParts[1]));

    if (targetDateTime.isBefore(now)) {
      // If the target time is before the current time, add a day to the target time
      targetDateTime = targetDateTime.add(Duration(days: 1));
    }

    Duration difference = targetDateTime.difference(now);

    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return '$arabicPrayerName\n${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String findUpcomingPrayer(String currentTime) {
    List<String> prayers = widget.prayerTimes.keys.toList();

    prayers.sort((a, b) {
      DateTime aTime = DateTime.parse("2023-01-01 ${widget.prayerTimes[a]}:00");
      DateTime bTime = DateTime.parse("2023-01-01 ${widget.prayerTimes[b]}:00");
      return aTime.compareTo(bTime);
    });

    for (String prayer in prayers) {
      if (currentTime.compareTo(widget.prayerTimes[prayer]!) < 0) {
        return prayer;
      }
    }

    // If no upcoming prayer is found, return the first prayer of the day
    return prayers.first;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
