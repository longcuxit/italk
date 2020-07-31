part of 'export.dart';

class TimerControl implements Timer {
  final VoidCallback _callback;
  final Duration duration;

  Timer timer;
  int startAt;
  Duration _duration;

  TimerControl(this.duration, this._callback) {
    reset();
  }

  @override
  void cancel() {
    timer.cancel();
  }

  void pause() {
    final now = DateTime.now().millisecondsSinceEpoch;
    _duration -= Duration(milliseconds: now - startAt);
    timer.cancel();
    timer = null;
  }

  void resume() {
    startAt = DateTime.now().millisecondsSinceEpoch;
    timer = Timer(_duration, _callback);
  }

  void reset() {
    _duration = duration;
    resume();
  }

  @override
  bool get isActive => timer?.isActive ?? false;

  @override
  int get tick => timer.tick;

  bool get isCompleted => timer?.isActive == false;
}

class _Item extends StatefulWidget {
  final _dropKey = GlobalKey<AnimatedDropState>();
  final Widget child;
  final VoidCallback onDismissed;

  final Duration autoDismiss;
  _Item({
    @required this.child,
    this.onDismissed,
    this.autoDismiss = const Duration(seconds: 3),
  });

  @override
  final GlobalKey<_ItemState> key = GlobalKey<_ItemState>();

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  TimerControl timer;
  final _completer = Completer();

  AnimationController get _controller =>
      widget._dropKey.currentState?.controller;

  Future<void> dismiss() async {
    if (_completer.isCompleted || _controller == null) {
      return dispose();
    }
    await _controller.reverse().whenComplete(dispose);
  }

  @override
  void initState() {
    if (widget.autoDismiss != null) {
      timer = TimerControl(widget.autoDismiss, dismiss);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_completer.isCompleted) {
      return;
    }
    timer.cancel();
    _controller?.stop();
    _completer.complete();
    widget.onDismissed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => timer.pause(),
      onPointerUp: (_) => timer.reset(),
      child: Dismissible(
        key: ObjectKey(this),
        onDismissed: (_) => dispose(),
        confirmDismiss: (_) async {
          if (_completer.isCompleted) {
            return false;
          }
          _controller?.stop();
          return true;
        },
        child: AnimatedDrop(
          key: widget._dropKey,
          builder: (_, child) {
            return Align(
              widthFactor: 1,
              heightFactor: _controller.value,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
