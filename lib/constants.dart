import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// API URLs
const API_URL = "https://news.grgsuman.com.np/api/";
const API_HOME = API_URL + "home";
const API_WEBSITE = API_URL + "websites/";

const kGrey1 = Color(0xFF9F9F9F);
const kGrey2 = Color(0xFF6D6D6D);
const kGrey3 = Color(0xFFEAEAEA);
const kBlack = Color(0xFF1C1C1C);

const kFallbackImageSource = 'assets/newspaper.png';
const kDrawerImageSource = 'assets/drawer_bg.png';

var kDrawerkHeaderStyle = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 10.0,
        color: kBlack,
        offset: Offset(5.0, 5.0),
      ),
    ],
  ),
);

var kNonActiveTabStyle = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: kGrey2,
    fontWeight: FontWeight.bold,
  ),
);

var kHeaderStyle = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: kBlack,
    fontWeight: FontWeight.bold,
  ),
);

var kHeaderButton = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: Colors.blue,
    fontWeight: FontWeight.normal,
  ),
);

var kCategoryTitle = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 18.0,
    color: kGrey2,
    fontWeight: FontWeight.bold,
  ),
);

var kCategorySubtitle = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: kGrey2,
    fontWeight: FontWeight.normal,
  ),
);

var kDetailContent = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 12.0,
    color: kGrey2,
  ),
);

var kTitleCard = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: kGrey2,
    fontWeight: FontWeight.bold,
  ),
);

var kDescriptionStyle = GoogleFonts.raleway(
  textStyle: TextStyle(
    fontSize: 15.0,
    height: 2.0,
  ),
);
