import 'package:flutter/material.dart';
import 'package:evex/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xFF1C1C1E, {
    50: Color.fromRGBO(28, 28, 30, .1),
    100: Color.fromRGBO(28, 28, 30, .2),
    200: Color.fromRGBO(28, 28, 30, .3),
    300: Color.fromRGBO(28, 28, 30, .4),
    400: Color.fromRGBO(28, 28, 30, .5),
    500: Color.fromRGBO(28, 28, 30, .6),
    600: Color.fromRGBO(28, 28, 30, .7),
    700: Color.fromRGBO(28, 28, 30, .8),
    800: Color.fromRGBO(28, 28, 30, .9),
    900: Color.fromRGBO(28, 28, 30, 1),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evex',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: HomePage(),
    );
  }
}
