part of 'export.dart';

class AuthState extends ChangeNotifier {
  ModelAuth state;

  Future login(String username, String password) async {}

  void logout() {}

  static AuthState of(BuildContext context) => Provider.of<AuthState>(context);

  static Provider provider({Key key, Widget child}) {
    return Provider<AuthState>(
      key: key,
      create: () => AuthState(),
      child: child,
    );
  }
}
