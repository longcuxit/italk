part of 'export.dart';

class _Provider extends StatefulWidget {
  final Widget child;

  _Provider({Key key, this.child}) : super(key: key);

  @override
  _ProviderState createState() => _ProviderState();
}

enum _Types { start, tap }

class _ProviderState extends State<_Provider> {
  bool isTap = false;
  final Map<GlobalKey, _TouchOutsideState> handlers = {};

  Rect _getRect(RenderBox box) {
    final size = box.size;
    final pos = box.localToGlobal(Offset.zero);
    return Rect.fromLTWH(pos.dx, pos.dy, size.width, size.height);
  }

  void check(Offset offset, _Types type) {
    handlers.forEach((key, handle) {
      if (handle.widget.disable == true) return;
      final rect = _getRect(key.currentContext.findRenderObject());
      if (!rect.contains(offset)) {
        switch (type) {
          case _Types.start:
            handle.widget.onStart?.call();
            break;
          case _Types.tap:
            handle.widget.onTap?.call();
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (pointer) {
        isTap = true;
        check(pointer.position, _Types.start);
      },
      onPointerMove: (_) => isTap = false,
      onPointerUp: (pointer) {
        if (isTap) check(pointer.position, _Types.tap);
      },
      child: widget.child,
    );
  }
}
