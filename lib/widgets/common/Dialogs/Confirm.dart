part of 'export.dart';

class ConfirmTexts {
  final String title;
  final String message;
  final String yes;
  final String no;

  ConfirmTexts(this.title, this.message, {this.yes, this.no});
}

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onCancel;
  final ConfirmTexts texts;

  ConfirmDialog(
    this.texts, {
    Key key,
    this.onAccept,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context).system;
    return AlertDialog(
      title: Text(texts.title),
      content: Text(texts.message),
      actions: <Widget>[
        FlatButton(
          onPressed: onCancel,
          textTheme: ButtonTextTheme.accent,
          child: Text(texts.no ?? i18n.no),
        ),
        FlatButton(
          onPressed: onAccept,
          textTheme: ButtonTextTheme.primary,
          child: Text(texts.yes ?? i18n.yes),
        ),
      ],
    );
  }
}

Future<bool> showConfirmDialog(
  BuildContext context,
  ConfirmTexts texts, {
  barrierDismissible = false,
  bool useRootNavigator = true,
  bool willPop = false,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final onPress = Navigator.of(
        context,
        rootNavigator: useRootNavigator,
      ).pop;
      return WillPopScope(
        onWillPop: () async => willPop,
        child: ConfirmDialog(
          texts,
          onAccept: () => onPress(true),
          onCancel: () => onPress(false),
        ),
      );
    },
  );
}
