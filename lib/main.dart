import 'package:flutter/material.dart';

import 'screens/Splash.dart';
import 'screens/main/export.dart';
import 'state/export.dart';
import 'widgets/common/TouchOutSide/export.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    home: SplashScreen(
      future: Future.delayed(const Duration(seconds: 1)),
      child: MainScreen(),
    ),
    builder: (BuildContext context, Widget navigator) {
      return TouchOutside.provider(child: GlobalProvider(child: navigator));
    },
  ));
}
