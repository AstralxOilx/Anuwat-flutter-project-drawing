import 'package:flutter/material.dart';

// Define color constants
class ColorPalette { //กำหนดตัวแปรสำหรับสีที่ใช้ในแอพ
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color blue = Colors.blue;
  static const Color yellow = Colors.yellow;
  static const Color pink = Colors.pink;
  static const Color purple = Colors.purple;
  static const Color cyanAccent = Colors.cyanAccent;
  static const Color brown = Colors.brown;
  static const Color orange = Colors.orange;
  static const Color grey = Colors.grey;
  static const Color darkGrey = Color.fromARGB(255, 133, 133, 133);
  static const Color primary = Color.fromARGB(255, 219, 219, 219);
  static const Color toolBg = Color.fromARGB(255, 32, 32, 32);
}

final List<Map<String, Color>> colorOptions = [
  {'Black': ColorPalette.black},
  {'White': ColorPalette.white},
  {'Red': ColorPalette.red},
  {'Green': ColorPalette.green},
  {'Blue': ColorPalette.blue},
  {'Yellow': ColorPalette.yellow},
  {'Pink': ColorPalette.pink},
  {'Purple': ColorPalette.purple},
  {'Cyan Accent': ColorPalette.cyanAccent},
  {'Brown': ColorPalette.brown},
  {'Orange': ColorPalette.orange},
  {'Grey': ColorPalette.grey},
  {'Dark Grey': ColorPalette.darkGrey},
  {'Primary': ColorPalette.primary},
  {'Tool BG': ColorPalette.toolBg},
];
