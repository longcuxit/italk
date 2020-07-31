import 'package:flutter/material.dart';
import 'package:italk/base/export.dart';
import 'package:italk/screens/dashboard/export.dart';

class MainScreen extends StatefulWidget {
  final Duration duration;

  MainScreen({
    Key key,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final tabActive = ValueNotifier(0);
  final screens = _routers.map((screen) => screen()).toList();

  @override
  Widget build(BuildContext context) {
    final barItems = screens.map((screen) => screen.barItem(context)).toList();
    return AnimatedBuilder(
      animation: tabActive,
      builder: (context, _) => buildView(context, barItems),
    );
  }

  Widget buildView(
    BuildContext context,
    List<BottomNavigationBarItem> barItems,
  ) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: widget.duration,
        child: screens[tabActive.value],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => tabActive.value = index,
        currentIndex: tabActive.value,
        items: barItems,
      ),
    );
  }
}

class Test extends DashBoardScreen{}
List<TabScreenMixin Function()> _routers = [
  () => DashBoardScreen(),
  () => Test(),
];
