import 'package:flutter/widgets.dart';

class AppWidget {
  static TextStyle HeadLineTextFieldstyle() {
    return const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0), // Blue (logo color)
      fontSize: 25.0,
      fontFamily: 'Pacifico-Regular',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle SimpleTextFieldstyle() {
    return const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 20.0,
      fontFamily: 'Pacifico-Regular',
    );
  }

  static TextStyle LogoTextStyle() {
    return const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1C4BA0),
      fontFamily: 'Pacifico-Regular',
    );
  }

  static TextStyle OrderTextStyle() {
    return const TextStyle(
      fontSize: 20,
      color: Color.fromARGB(197, 0, 0, 0),
      fontFamily: 'Pacifico-Regular',
    );
  }
}
