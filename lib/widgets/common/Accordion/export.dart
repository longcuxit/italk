import 'dart:async';

import 'package:flutter/material.dart';

part 'Item.dart';

class Accordion extends StatefulWidget {
  final List<AccordionItem> children;
  final Duration duration;
  final Curve curve;
  final ValueWidgetBuilder<AnimationController> itemBuilder;
  final bool autoCollapse;

  Accordion({
    Key key,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.autoCollapse = true,
    this.itemBuilder,
    @required this.children,
  }) : super(key: key);

  @override
  AccordionState createState() => AccordionState();

  static AccordionState of(BuildContext context) {
    return context.findAncestorStateOfType<AccordionState>();
  }
}

class AccordionState extends State<Accordion> {
  final selected = ValueNotifier<_AccordionItemState>(null);
  final _itemsState = <_AccordionItemState>[];

  void expand() => _itemsState.forEach((item) => item.active.value = true);

  void collapse() => _itemsState.forEach((item) => item.active.value = false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.children,
    );
  }
}
