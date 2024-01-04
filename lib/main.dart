import 'package:flutter/material.dart';
import 'package:prayertime/data/adkar.dart';
import 'package:prayertime/screens/prayers_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdkarData.loadAdkarData();
  runApp(
    const MaterialApp(
      home: PrayerScreen(),
    ),
  );
}
