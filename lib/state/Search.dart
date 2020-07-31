part of 'export.dart';

class SearchState extends ChangeNotifier {
  static SearchState of(BuildContext context) =>
      Provider.of<SearchState>(context);

  static Provider provider({Key key, Widget child}) {
    return Provider<SearchState>(
      key: key,
      create: () => SearchState(),
      child: child,
    );
  }
}
