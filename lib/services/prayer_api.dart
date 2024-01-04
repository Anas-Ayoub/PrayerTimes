import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:prayertime/data/prayer.dart';

var targetDate =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
var prayerTimings;
const req =
    'http://api.aladhan.com/v1/calendar/2024/1?latitude=33.58844012740967&longitude=-7.498331324332838&method=21';

Future<PrayerTimings> fetchData() async {
  final response = await http.get(Uri.parse(req));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    return PrayerTimings.fromJson(jsonData);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Map<String, String>> getTimingsForDate(DateTime targetDate) async {
  try {
    prayerTimings ??= await fetchData();

    final PrayerData matchingDateEntry = prayerTimings.data.firstWhere(
      (entry) =>
          _parseDate(entry.date.gregorian.date).isAtSameMomentAs(targetDate),
    );
    print(matchingDateEntry.timings);
    return matchingDateEntry.timings;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

Future<String> getHijriFormattedDate() async {
  try {
    prayerTimings ??= await fetchData();

    final PrayerData matchingDateEntry = prayerTimings.data.firstWhere(
      (entry) =>
          _parseDate(entry.date.gregorian.date).isAtSameMomentAs(targetDate),
    );

    final Hijri hijri = matchingDateEntry.date.hijri;

    final String formattedDate =
        '${hijri.year}   ${hijri.weekday['ar']}   ${hijri.month.ar ?? ''}';

    return formattedDate;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

Future<String> getGregorianFormattedDate() async {
  try {
    prayerTimings ??= await fetchData();

    final PrayerData matchingDateEntry = prayerTimings.data.firstWhere(
      (entry) =>
          _parseDate(entry.date.gregorian.date).isAtSameMomentAs(targetDate),
    );

    final Gregorian gregorian = matchingDateEntry.date.gregorian;

    final String formattedDate =
        '${gregorian.year}   ${gregorian.month.en}   ${gregorian.day}';

    return formattedDate;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}

DateTime _parseDate(String dateString) {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  return dateFormat.parse(dateString);
}
