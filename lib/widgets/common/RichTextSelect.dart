import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextSelectController extends ValueNotifier<String> {
  RichTextSelectController(String value) : super(format(value));

  static String format(String from) {
    return from?.replaceAll(',', '');
  }

  bool equal(String string) => value == format(string);

  @override
  set value(String newValue) {
    super.value = format(newValue);
  }
}

class RichTextSelect extends StatelessWidget {
  final List<String> text;
  final RichTextSelectController controller;

  RichTextSelect({
    Key key,
    this.text,
    this.controller,
  }) : super(key: key);

  static const space = '\u202F';
  static const emptySpace = '\u200B';

  @override
  Widget build(BuildContext context) {
    final style = () {
      final theme = Theme.of(context);
      final style = theme.textTheme.caption;
      final styleSelected = style.copyWith(
          color: Colors.white,
          background: Paint()
            ..color = Colors.blue
            ..style = PaintingStyle.fill
            ..strokeJoin = StrokeJoin.round);
      return (bool selected) => selected ? styleSelected : style;
    }();

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, value, __) {
        return RichText(
          text: TextSpan(
            children: text.map((word) {
              return TextSpan(
                style: style(controller.equal(word)),
                text: '$space$word$space',
                recognizer: TapGestureRecognizer()
                  ..onTap = () => controller.value = word,
              );
            }).fold([], (list, element) {
              return list..add(element)..add(const TextSpan(text: emptySpace));
            }),
          ),
        );
      },
    );
  }
}
