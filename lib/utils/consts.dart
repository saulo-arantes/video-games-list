import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final Options dioOptionsRawg = Options(headers: {
  'User-Agent': 'VGL <https://github.com/saulo-arantes/video-games-list>'
});

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

double statusBarHeight(context) {
  return MediaQuery.of(context).padding.top;
}

final int paginationSize = 10;

final Color mainColor = Colors.black87;

final header1Style = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 26.0
);

final header2Style = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 22.0
);

final header3Style = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 20.0
);

final gameDetailsHeaderStyle = TextStyle(
  color: Colors.black,
  fontSize: 28.0
);

final gameDetailsTextStyle = TextStyle(
  fontFamily: "Baloo Paaji 2",
  color: Colors.black,
  fontSize: 16.0,
  height: 1.3
);

final header3WithshadowStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 24.0,
  height: 1.3,
  shadows: <Shadow>[
    Shadow(
      blurRadius: 10.0,
      color: Colors.black,
      offset: Offset(3.0, 3.0)
    )
  ]
);

final defaultTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0
);

final defaultTextStyleBold = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w700
);

final gameCardMargin = EdgeInsets.only(
  left: 15.0,
  right: 15.0,
  bottom: 15.0
);

final gameCardDialogDescription = EdgeInsets.only(
  left: 15.0,
  right: 15.0,
  bottom: 15.0,
  top: 15.0
);

final gameCardTitlePadding = EdgeInsets.only(
  left: 25.0,
  bottom: 20.0,
  top: 20.0
);

final circularBorder = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

final Map platformsMap = {
  'mac': 'assets/icons/apple.png',
  'linux': 'assets/icons/linux.png',
  'nintendo': 'assets/icons/nintendo-switch.png',
  'playstation': 'assets/icons/ps.png',
  'pc': 'assets/icons/windows.png',
  'xbox': 'assets/icons/xbox.png',
};
