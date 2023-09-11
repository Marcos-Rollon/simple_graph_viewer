import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color main = Color(0xFF293B6A);
  static const Color secondary = Color(0xFF8D99AE);
  static const Color background = Color.fromARGB(255, 10, 13, 22);
  static const Color enfasis = Color(0xff7899D4);

  static const Color successGreen = Color(0xff44CF6C);
  static const Color warningYellow = Color(0xffE3B505);
  static const Color errorRed = Color.fromRGBO(222, 82, 70, 1);

  static const Color white = Colors.white;
  static const Color black = Color.fromARGB(255, 24, 24, 24);
  static const Color lightBlack = Color.fromARGB(255, 44, 49, 57);
  static const Color transparent = Colors.transparent;

  static const Color mainTextColor = AppColors.white;
  static const Color secondaryTextColor = Color.fromARGB(255, 185, 185, 185);
  static const Color enfasisTextColor = Color(0xff3AD890);

  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF004949),
      Color.fromARGB(255, 9, 102, 102),
    ],
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 76, 100, 100),
      Color.fromARGB(255, 97, 100, 100),
    ],
  );

  // DEBUG
  static const Color mainDebug = Color(0xFFF1F1F1);
  static const Color secondaryDebug = Color(0xFFC6C6C6);
  static const Color pinkDebug = Color.fromARGB(30, 255, 0, 200);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
