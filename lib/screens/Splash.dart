import 'package:flutter/material.dart';
import 'package:italk/widgets/Loading/export.dart';

class SplashScreen extends StatefulWidget {
  final Future future;
  final Widget child;

  SplashScreen({@required this.future, @required this.child});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _step = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _step = 1);
      Future.wait([
        widget.future,
        Future.delayed(const Duration(seconds: 2)),
      ]).whenComplete(() => setState(() => _step = 2));
    });
  }

  Widget get child {
    if (_step == 0) return const SizedBox();
    if (_step == 1) return const LoadingInitialize();
    return widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
