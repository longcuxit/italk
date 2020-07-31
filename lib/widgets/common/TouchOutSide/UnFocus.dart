part of 'export.dart';

class _UnFocus extends StatefulWidget {
  final Widget child;

  _UnFocus({Key key, @required this.child}) : super(key: key);

  @override
  _UnFocusState createState() => _UnFocusState();
}

class _UnFocusState extends State<_UnFocus> {
  bool _disable = true;
  FocusScopeNode focusScope;

  @override
  void initState() {
    super.initState();
    Timer.run(() => focusScope = FocusScope.of(context));
  }

  FocusNode focused;

  void unFocused() {
    focused?.removeListener(unFocused);
    setState(() {
      focused = null;
      _disable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<Notification>(
      onNotification: (_) {
        if (_disable == focusScope.hasFocus) {
          setState(() => _disable = false);
          Timer.run(() {
            focused = focusScope.focusedChild;
            focused?.addListener(unFocused);
          });
        }
        return false;
      },
      child: TouchOutside(
        onTap: () => focusScope.unfocus(),
        disable: _disable,
        child: widget.child,
      ),
    );
  }
}
