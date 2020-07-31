import 'package:flutter/material.dart';
import 'package:italk/screens/Splash.dart';
import 'package:italk/screens/main/export.dart';
import 'package:italk/state/export.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    home: SplashScreen(
      future: Future.delayed(const Duration(seconds: 3)),
      child: MainScreen(),
    ),
    builder: (BuildContext context, Widget navigator) {
      return GlobalProvider(child: navigator);
    },
  ));
}
