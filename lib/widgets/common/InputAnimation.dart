
import 'dart:async';

import 'package:flutter/material.dart';

class InputAnimationController extends ChangeNotifier {
  _InputAnimationState _state;

  void add(String string) => _state.add(string);

  void remove() => _state.remove();

  void clear() => _state.clear();

  String get value => _state._values.fold('', (t, n) => t + n);
}

class InputAnimation extends StatefulWidget {
  final InputAnimationController controller;
  final FocusNode focusNode;
  final bool secure;
  final ValueWidgetBuilder itemBuilder;
  final MainAxisAlignment alignment;
  final TextInputType keyboardType;

  InputAnimation({
    Key key,
    this.controller,
    this.focusNode,
    this.secure = false,
    this.itemBuilder,
    this.alignment = MainAxisAlignment.center,
    this.keyboardType,
  }) : super(key: key);

  @override
  _InputAnimationState createState() => _InputAnimationState();
}

class _InputAnimationState extends State<InputAnimation>
    with TickerProviderStateMixin {
  final List<Widget> _visibleItems = [];
  final List<Widget> _removing = [];
  final List<String> _values = [];
  String _waitAdding = '';
  Timer _waitAddTimer;

  int num = 0;

  @override
  void initState() {
    widget.controller?._state = this;
    super.initState();
  }

  void _waitAdd() {
    if (_waitAdding.isEmpty) return;
    final char = _waitAdding.substring(0, 1);
    _waitAdding = _waitAdding.substring(1);

    if (widget.secure && _visibleItems.isNotEmpty) {
      (_visibleItems.last.key as GlobalKey<_ItemState>)
          .currentState
          ?.secureEnable();
    }
    _values.add(char);
    _visibleItems.add(_Item(
      key: GlobalKey<_ItemState>(),
      secure: widget.secure,
      builder: widget.itemBuilder,
      child: Text(char),
    ));
    setState(() {});

    if (_waitAdding.isNotEmpty) {
      _waitAddTimer = Timer(const Duration(milliseconds: 150), _waitAdd);
    }
  }

  void add(String string) {
    _waitAdding += string;
    if (_waitAddTimer?.isActive != true) Timer.run(_waitAdd);
  }

  void remove() {
    if (_values.isEmpty) return;
    _values.removeLast();
    final last = _visibleItems.lastWhere((item) {
      return !_removing.contains(item);
    });
    _removing.add(last);
    final state = (last.key as GlobalKey<_ItemState>).currentState;
    state.remove().whenComplete(() {
      setState(() {
        _visibleItems.remove(last);
        _removing.remove(last);
      });
    });
  }

  void clear() {
    _values.clear();
    int i = 0;
    for (final item in _visibleItems) {
      final state = (item.key as GlobalKey<_ItemState>).currentState;
      Timer(
        Duration(milliseconds: 30 * i),
        () => state.remove().whenComplete(() {
          if (item == _visibleItems.last) {
            _visibleItems.clear();
            _removing.clear();
          }
        }),
      );
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget texts = Row(
      mainAxisAlignment: widget.alignment,
      children: _visibleItems,
    );
    if (widget.keyboardType == null) return texts;
    return Stack(
      children: <Widget>[
        texts,
        Opacity(
          opacity: 0,
          child: TextField(
            keyboardType: widget.keyboardType,
          ),
        ),
      ],
    );
  }
}

class _Item extends StatefulWidget {
  final Widget child;
  final bool secure;
  final ValueWidgetBuilder builder;

  _Item({
    Key key,
    this.child,
    this.secure,
    this.builder,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<_Item> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController secureController;
  Timer _secureTimer;
  bool removed = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    secureController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    Timer.run(() => controller.animateTo(1.0));
    if (widget.secure) {
      _secureTimer = Timer(
        const Duration(seconds: 1),
        secureEnable,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    secureController.dispose();
    _secureTimer?.cancel();
    super.dispose();
  }

  Future remove() {
    controller.stop();
    _secureTimer?.cancel();
    return controller.animateTo(0.0);
  }

  void secureEnable() {
    _secureTimer?.cancel();
    secureController.animateTo(1.0);
  }

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;
    final dotSize = (style.fontSize ?? 40.0) / 4.0;

    Widget child = AnimatedBuilder(
      animation: secureController,
      builder: (_, child) {
        return Transform.scale(
          scale: 1 - secureController.value,
          child: child,
        );
      },
      child: widget.child,
    );

    if (widget.secure) {
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
          AnimatedBuilder(
            animation: secureController,
            builder: (_, child) {
              return Transform.scale(
                scale: secureController.value,
                child: child,
              );
            },
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dotSize / 2),
                color: style.color ?? Colors.white,
              ),
            ),
          ),
        ],
      );
    }

    child = AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return SizedBox(
          width: dotSize * 2.2 * controller.value,
          child: Transform.scale(
            scale: controller.value,
            child: child,
          ),
        );
      },
      child: child,
    );

    if (widget.builder != null) child = widget.builder(context, 0, child);

    return child;
  }
}
