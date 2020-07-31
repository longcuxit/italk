part of 'export.dart';

class AccordionItem extends StatefulWidget {
  final Widget title;
  final Widget content;

  AccordionItem({
    Key key,
    @required this.title,
    this.content,
  }) : super(key: key);

  @override
  _AccordionItemState createState() => _AccordionItemState();

  static _AccordionItemState of(BuildContext context) {
    return context.findAncestorStateOfType<_AccordionItemState>();
  }
}

class _AccordionItemState extends State<AccordionItem>
    with SingleTickerProviderStateMixin {
  final active = ValueNotifier(false);

  AnimationController controller;
  AccordionState _parentState;

  AccordionState get parentState => _parentState ??= Accordion.of(context);

  Accordion get parent => parentState.widget;

  void _setActive() {
    controller.animateTo(
      active.value ? 1 : 0,
      duration: parentState.widget.duration,
      curve: parentState.widget.curve,
    );
  }

  void _parentChanged() {
    final selected = parentState.selected.value == this;
    if (selected || parent.autoCollapse) {
      active.value = selected;
    }
  }

  bool toggle() {
    active.value = !active.value;
    if (active.value) parentState.selected.value = this;
    return active.value;
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this);
    active.addListener(_setActive);
    Timer.run(() {
      parentState
        ..selected.addListener(_parentChanged)
        .._itemsState.add(this);
    });
    super.initState();
  }

  @override
  void dispose() {
    active.dispose();
    parentState
      ..selected.removeListener(_parentChanged)
      .._itemsState.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkWell(
          onTap: () => !controller.isAnimating ? toggle() : null,
          child: widget.title,
        ),
        AnimatedBuilder(
          animation: controller,
          builder: (_, child) => SizeTransition(
            sizeFactor: controller,
            child: child,
          ),
          child: widget.content,
        ),
      ],
    );
    return parent.itemBuilder?.call(context, controller, item) ?? item;
  }
}
