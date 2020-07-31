part of 'export.dart';

class SizeChangedNotification extends LayoutChangedNotification {
  final Size current;
  final Size old;

  SizeChangedNotification(this.current, this.old);

  @override
  String toString() {
    return 'SizeChangedNotification(current: $current, old: $old)';
  }
}

class SizeChangedNotifier extends SingleChildRenderObjectWidget {
  const SizeChangedNotifier({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  _RenderSizeChanged createRenderObject(BuildContext context) {
    return _RenderSizeChanged(onChanged: (size, old) {
      SizeChangedNotification(size, old).dispatch(context);
    });
  }
}

class _RenderSizeChanged extends RenderProxyBox {
  _RenderSizeChanged({
    RenderBox child,
    @required this.onChanged,
  })  : assert(onChanged != null),
        super(child);
  final Function(Size, Size) onChanged;

  Size _oldSize;

  @override
  void performLayout() {
    super.performLayout();
    if (_oldSize != null && size != _oldSize) {
      onChanged(size, _oldSize);
    }
    _oldSize = size;
  }
}
