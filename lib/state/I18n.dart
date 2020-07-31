part of 'export.dart';

class I18n extends ValueNotifier {
  I18n() : super(I18nData());

  static I18nData of(BuildContext context) => Provider.of<I18n>(context).value;

  static Provider provider({Key key, Widget child}) {
    return Provider<I18n>(
      key: key,
      create: (_) => I18n(),
      child: child,
    );
  }
}

mixin I18nStateMixin<T extends StatefulWidget> on State<T> {
  I18nData _i18n;

  I18nData get i18n => _i18n ??= I18n.of(context);
}
