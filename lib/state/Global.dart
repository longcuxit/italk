part of 'export.dart';

class GlobalProvider extends StatelessWidget {
  final Widget child;

  GlobalProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return LoaderState.provider(
      child: I18n.provider(
        child: AuthState.provider(
          child: child,
        ),
      ),
    );
  }
}
