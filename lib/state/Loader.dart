part of 'export.dart';

class LoaderState extends ValueNotifier<bool> {
  final _loadings = <Future>[];

  LoaderState([bool value = false]) : super(value);

  Future<void> push(Future future) async {
    value = (_loadings..add(future)).isNotEmpty;

    await future.whenComplete(() => _loadings.remove(future));

    value = (_loadings..remove(future)).isNotEmpty;
  }

  static Provider provider({Key key, Widget child}) {
    return Provider<LoaderState>(
      key: key,
      create: () => LoaderState(),
      child: child,
    );
  }

  static LoaderState of(BuildContext context) =>
      Provider.of<LoaderState>(context);

  static Widget builder(
    BuildContext context, {
    @required ValueWidgetBuilder<LoaderState> builder,
    Widget child,
  }) {
    return Provider.builder<LoaderState>(
      context,
      builder: builder,
      child: child,
    );
  }
}
