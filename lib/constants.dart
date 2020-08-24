import 'package:flutter/material.dart';

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

var kDrawerkHeaderStyle = TextStyle(
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
);

var kNonActiveTabStyle = TextStyle(
  fontSize: 14.0,
  color: kGrey2,
  fontWeight: FontWeight.bold,
);

var kHeaderStyle = TextStyle(
  fontSize: 16.0,
  color: kBlack,
  fontWeight: FontWeight.bold,
);

var kHeaderButton = TextStyle(
  fontSize: 16.0,
  color: Colors.blue,
  fontWeight: FontWeight.normal,
);

var kCategoryTitle = TextStyle(
  fontSize: 18.0,
  color: kGrey2,
  fontWeight: FontWeight.bold,
);

var kCategorySubtitle = TextStyle(
  fontSize: 14.0,
  color: kGrey2,
  fontWeight: FontWeight.normal,
);

var kDetailContent = TextStyle(
  fontSize: 12.0,
  color: kGrey2,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.normal,
  fontFamily: 'Raleway',
);

var kTitleCard = TextStyle(
  fontSize: 16.0,
  color: kGrey2,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.none,
  fontFamily: 'Raleway',
);

var kDescriptionStyle = TextStyle(
  fontSize: 15.0,
  height: 2.0,
);
