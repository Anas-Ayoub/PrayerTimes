import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayertime/services/prayer_api.dart';
import 'package:prayertime/widgets/next_prayer_counter.dart';

class HeaderImage extends StatefulWidget {
  final Map<String, String> prayerTimes;
  final bool showCounter;

  HeaderImage({required this.prayerTimes, required this.showCounter});

  @override
  State<HeaderImage> createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  Future<String> hijriDateFuture = getHijriFormattedDate();
  Future<String> gregorianDateFuture = getGregorianFormattedDate();
  String? hijriDate;
  String? gregorianDate;
  @override
  void initState() {
    super.initState();
    hijriDateFuture.then((value) => hijriDate = value);
    gregorianDateFuture.then((value) => gregorianDate = value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.dstATop,
          ),
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'lib/assets/images/sunrise1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (widget.showCounter)
          Positioned(
            top: 0,
            bottom: 25,
            left: 0,
            right: 0,
            child: Center(
              child: NextPrayerCounter(prayerTimes: widget.prayerTimes),
            ),
          ),
        if (!widget.showCounter)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                "lib/assets/icons/WMDx.gif",
                height: 40,
                width: 40,
              ),
            ),
          ),
        Positioned(
          top: 0,
          left: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'lib/assets/icons/giphy.gif',
                height: 32,
                width: 32,
              ),
              //SizedBox(width: 1),
              Text(
                "Casablanca",
                style: GoogleFonts.abel(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: hijriDate == null
              ? const Text("")
              : Text(
                  hijriDate!,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: gregorianDate == null
              ? const Text("")
              : Text(
                  gregorianDate!,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}
