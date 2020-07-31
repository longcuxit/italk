import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:italk/base/export.dart';
import 'package:italk/widgets/common/Animations/export.dart';

part 'Item.dart';

class StackedBar extends StatefulWidget {
  final Widget child;
  final EdgeInsets insets;

  StackedBar({
    Key key,
    this.child,
    this.insets = const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
  })  : assert(!insets.isNull),
        super(key: key);

  @override
  _StackedBarState createState() => _StackedBarState();

  static Future<T> error<T>(String message, [BuildContext context]) {
    return of(context).push(
      StackedBarItem.error(message: message),
      const Duration(seconds: 3),
    );
  }

  static Future<T> success<T>(String message, [BuildContext context]) {
    return of(context).push(
      StackedBarItem.success(message: message),
      const Duration(seconds: 3),
    );
  }

  static _StackedBarState of(BuildContext context) {
    return context.findAncestorStateOfType<_StackedBarState>();
  }
}

class _StackedBarState extends State<StackedBar> {
  final _items = ValueNotifier<List<StackedBarItem>>([]);

  Future<void> push(StackedBarItem item, [Duration life]) async {
    _items.value = (_items.value..add(item)).sublist(0);
    if (life != null) {
      await item.hide(life);
      remove(item);
    }
  }

  void remove(StackedBarItem item) {
    _items.value = [..._items.value..remove(item)];
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
        widget.child,
        Positioned(
          top: insets.top,
          left: insets.left,
          right: insets.right,
          bottom: insets.bottom,
          child: ValueListenableBuilder(
            valueListenable: _items,
            builder: (_, value, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _items.value
                    .map(
                      (item) => Dismissible(
                        key: ObjectKey(item),
                        onDismissed: (_) => remove(item),
                        child: Material(
                          color: Colors.transparent,
                          child: item,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
