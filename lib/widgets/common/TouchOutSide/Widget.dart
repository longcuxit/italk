part of 'export.dart';

class TouchOutside extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onStart;
  final bool disable;

  TouchOutside({
    Key key,
    @required this.child,
    this.onTap,
    this.onStart,
    this.disable = false,
  })  : assert(disable != null),
        super(key: key);

  static Widget unFocus({Key key, Widget child}) =>
      _UnFocus(key: key, child: child);

  @override
  _TouchOutsideState createState() => _TouchOutsideState();

  static Widget provider({Key key, Widget child}) {
    return _Provider(key: key, child: child);
  }
}

class _TouchOutsideState extends State<TouchOutside> {
  final globalKey = GlobalKey();

  _ProviderState _provider;

  _ProviderState get provider =>
      _provider ??= context.findAncestorStateOfType<_ProviderState>();

  @override
  void initState() {
    super.initState();
    provider.handlers[globalKey] = this;
  }

  @override
  void dispose() {
    provider.handlers.remove(globalKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: globalKey, child: widget.child);
  }
}
