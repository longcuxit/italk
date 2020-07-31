part of 'export.dart';

typedef StackedBarItemBuilder = Widget Function(BuildContext, StackedBarItem);

class StackedBarItem extends StatefulWidget {
  final Widget icon;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  StackedBarItem({
    Key key,
    this.icon,
    this.onDismissed,
    @required this.child,
  }) : super(key: key);

  @override
  _StackedBarItemState createState() => _StackedBarItemState();

  final _key = GlobalKey<AnimatedDropState>();
  final _sizeDuration = const Duration(milliseconds: 200);

  Future show([Duration delayed = Duration.zero]) async {
    await Future.delayed(delayed);
    await _key.currentState?.show();
  }

  Future hide([Duration delayed = Duration.zero]) async {
    await Future.delayed(delayed);
    await _key.currentState?.hide();
    await Future.delayed(_sizeDuration);
  }

  factory StackedBarItem.error({
    Key key,
    String message,
  }) {
    return StackedBarItem(
      key: key,
      icon: Icon(Icons.error_outline),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.error_outline),
          title: Text(message),
        ),
      ),
    );
  }

  factory StackedBarItem.success({
    Key key,
    String message,
  }) {
    return StackedBarItem(
      key: key,
      icon: Icon(Icons.check),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.check),
          title: Text(message),
        ),
      ),
    );
  }
}

class _StackedBarItemState extends State<StackedBarItem>
    with TickerProviderStateMixin {
  bool show = false;

  AnimationController get _controller => widget._key.currentState?.controller;

  void _statusChange(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      setState(() {
        show = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      setState(() {
        show = true;
      });
      _controller?.addStatusListener(_statusChange);
    });
  }

  @override
  void dispose() {
    _controller?.removeStatusListener(_statusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        height: show ? null : 0,
        child: AnimatedDrop(
          key: widget._key,
          offset: const Offset(0, -40),
          builder:(_,__) => widget.child,
        ),
      ),
    );
  }
}
