part of 'export.dart';

class SettingState extends ChangeNotifier {
  static SettingState of(BuildContext context) =>
      Provider.of<SettingState>(context);

  static Provider provider({Key key, Widget child}) {
    return Provider<SettingState>(
      key: key,
      create: () => SettingState(),
      child: child,
    );
  }
}
