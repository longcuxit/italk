part of 'export.dart';


class AnimatedDrop extends StatefulWidget {
  final Widget child;
  final Offset offset;
  final Duration duration;
  final RangeValues initRun;
  final TransitionBuilder builder;

  AnimatedDrop({
    Key key,
    this.child,
    this.offset = const Offset(0, -100),
    this.duration,
    this.initRun = const RangeValues(0, 1),
    @required this.builder,
  }) : super(key: key);

  @override
  AnimatedDropState createState() => AnimatedDropState();
}

class AnimatedDropState extends State<AnimatedDrop>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 200),
      vsync: this,
    );

    offset = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(controller);

    if (widget.initRun != null) {
      controller
        ..value = widget.initRun.start
        ..animateTo(widget.initRun.end);
    }
    super.initState();
  }

  Future show() => controller.forward();

  Future hide() => controller.reverse();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => Opacity(
        opacity: controller.value,
        child: Transform.translate(
          offset: offset.value,
          child: widget.builder(context, child),
        ),
      ),
      child: widget.child,
    );
  }
}
