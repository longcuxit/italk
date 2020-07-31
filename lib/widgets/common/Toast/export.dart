import 'dart:async';

import 'package:flutter/material.dart';
import 'package:italk/widgets/common/Animations/export.dart';

part 'FakeItem.dart';

class Toast extends StatefulWidget {
  final Widget child;
  final EdgeInsets insets;

  Toast({
    Key key,
    this.insets = const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
    this.child,
  }) : super(key: key);

  @override
  ToastState createState() => ToastState();

  static ToastState of(BuildContext context) {
    return context.findAncestorStateOfType<ToastState>();
  }

  static void empty(BuildContext context) {
    of(context).empty();
  }
}

class ToastState extends State<Toast> {
  final _items = ValueNotifier<List<_Item>>([]);

  Future<void> push(
    Widget widget, [
    Duration autoDismiss = const Duration(seconds: 3),
  ]) async {
    _Item item;
    item = _Item(
      onDismissed: () => _remove(item),
      autoDismiss: autoDismiss,
      child: widget,
    );
    _items.value = [..._items.value..add(item)];
  }

  void _remove(_Item item) {
    _items.value = [..._items.value..remove(item)];
  }

  void empty() {
    for(final item in _items.value) {
      item.key.currentState.dismiss();
    }
  }

  @override
  void dispose() {
    _items.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final insets = widget.insets;

    return Stack(
      children: <Widget>[
        Positioned.fill(child: widget.child),
        Padding(
          padding: insets,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 360),
              child: ValueListenableBuilder(
                valueListenable: _items,
                builder: (_, value, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _items.value.map((item) {
                      return Material(
                        key: ObjectKey(item),
                        color: Colors.transparent,
                        child: item,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
