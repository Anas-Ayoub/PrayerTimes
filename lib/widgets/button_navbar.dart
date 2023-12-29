import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTabChange;
  final Color navBarColor = Color.fromARGB(255, 44, 43, 59);
  BottomNavBar({
    required this.selectedIndex,
    required this.onTabChange,
  });
//reemKufi, amiriQuran

  final TextStyle optionStyle = GoogleFonts.cairo(
      color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CircleNavBar(
        activeIcons: [
          Image.asset(
            'lib/assets/icons/praying.png',
          ),
          Image.asset(
            'lib/assets/icons/belief.png',
          ),
          Image.asset(
            'lib/assets/icons/hands.png',
          ),
        ],
        inactiveIcons: [
          Text(
            'أوقات\nالصلاة',
            textAlign: TextAlign.center,
            style: optionStyle,
          ),
          Text(
            "أسماء الله\nالحسنى",
            textAlign: TextAlign.center,
            style: optionStyle,
          ),
          Text(
            "أذكار",
            textAlign: TextAlign.center,
            style: optionStyle,
          ),
        ],
        color: navBarColor,
        circleColor: navBarColor,
        height: 60,
        circleWidth: 60,
        activeIndex: selectedIndex,
        elevation: 20,
        onTap: onTabChange,
      ),
    );
  }
}

//'أوقات الصلاة'
