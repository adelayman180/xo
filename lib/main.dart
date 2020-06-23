import 'package:flutter/material.dart';
import './home_page.dart';
import './choise_page.dart';
import './play_page.dart';

main(List<String> args) {
  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.blueGrey[600], accentColor: Colors.blueGrey[900]),
    routes: {
      '/': (_) => HomePage(),
      'choise': (_) => ChoisePage(),
      'play': (_) => PlayPage(),
    },
  ));
}
