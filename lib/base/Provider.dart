part of 'export.dart';

class Provider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T Function(BuildContext) create;
  final bool Function(T) isDispose;

  Provider({
    Key key,
    this.child,
    @required this.create,
    this.isDispose,
  }) : super(key: key);

  @override
  State createState() => _ProviderState<T>();

  static T of<T extends ChangeNotifier>(BuildContext context) {
    return context.findAncestorStateOfType<_ProviderState<T>>()._state;
  }

  static Widget builder<T extends ChangeNotifier>(
    BuildContext context, {
    @required ValueWidgetBuilder<T> builder,
    Widget child,
  }) {
    final listen = of<T>(context);
    return AnimatedBuilder(
      animation: listen,
      builder: (context, child) => builder(context, listen, child),
      child: child,
    );
  }
}

class _ProviderState<T extends ChangeNotifier> extends State<Provider<T>> {
  T _state;

  @override
  Widget build(BuildContext context) {
    _state ??= widget.create(context);
    return widget.child;
  }

  @override
  void dispose() {
    if (widget.isDispose?.call(_state) != false) {
      _state.dispose();
    }
    super.dispose();
  }
}
