part of 'export.dart';

mixin TabScreenMixin implements Widget {
  BottomNavigationBarItem barItem(BuildContext context) {
    return BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: const Text('Tabbar Item'),
    );
  }
}
