import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class PrayerCard extends StatelessWidget {
  final String keyName;
  final String arabicName;
  final String time;

  const PrayerCard({
    required this.keyName,
    required this.arabicName,
    required this.time,
  });

  static const Map<String, List<String>> prayerTypeImages = {
    "Fajr": ["lib/assets/images/dawn1.jpg"],
    "Dhuhr": ["lib/assets/images/dhuhr1.jpg"],
    "Asr": ["lib/assets/images/asr1.jpg"],
    "Maghrib": ["lib/assets/images/maghrib1.jpg"],
    "Isha": ["lib/assets/images/isha1.jpg"],
  };

  String getRandomImageForPrayer(String prayerType) {
    final List<String>? images = prayerTypeImages[prayerType];
    if (images != null && images.isNotEmpty) {
      final Random random = Random();
      final int randomIndex = random.nextInt(images.length);
      return images[randomIndex];
    }
    return "lib/assets/images/sunrise1.jpg"; // Return a default image if the list is empty or null
  }

  @override
  Widget build(BuildContext context) {
    double dimmer = 0.4;
    if (keyName == "Isha") {
      dimmer = 0;
    }
    const cardBorderRadious = 10.0;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            cardBorderRadious), // Adjust the radius as needed
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cardBorderRadious),
        child: SizedBox(
          height: 90,
          child: Stack(
            children: [
              Image.asset(
                getRandomImageForPrayer(keyName),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cardBorderRadious),
                    color: Colors.black.withOpacity(dimmer),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          '$keyName  |   $arabicName',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            color: Colors.white,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          time,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
