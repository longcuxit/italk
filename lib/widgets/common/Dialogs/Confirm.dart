part of 'export.dart';

class ConfirmTexts {
  final String title;
  final String message;
  final String yes;
  final String no;

  ConfirmTexts(this.title, this.message, {this.yes, this.no});
}

class ConfirmDialog extends AlertDialog {
  final VoidCallback onAccept;
  final VoidCallback onCancel;

  ConfirmDialog(
    ConfirmTexts texts, {
    Key key,
    this.onAccept,
    this.onCancel,
  }) : super(
          title: Text(texts.title),
          content: Text(texts.message),
          actions: <Widget>[
            FlatButton(
              onPressed: onCancel,
              textTheme: ButtonTextTheme.accent,
              child: Text(texts.no ?? 'Yes'),
            ),
            RaisedButton(
              onPressed: onAccept,
              textTheme: ButtonTextTheme.primary,
              child: Text(texts.yes ?? 'No'),
            ),
          ],
        );
}

Future<bool> showConfirmDialog(
  BuildContext context,
  ConfirmTexts texts, {
  barrierDismissible = false,
  bool useRootNavigator = true,
  RoutePopDisposition noMethod = RoutePopDisposition.doNotPop,
  RoutePopDisposition yesMethod = RoutePopDisposition.pop,
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
      return ConfirmDialog(
        texts,
        onAccept: () => onPress(true),
        onCancel: () => onPress(false),
      );
    },
  );
}
