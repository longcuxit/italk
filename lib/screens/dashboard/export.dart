import 'package:flutter/material.dart';
import 'package:italk/base/export.dart';
import 'package:italk/widgets/common/Dialogs/export.dart';

import '../../widgets/common/TouchOutSide/export.dart';

class DashBoardScreen extends StatefulWidget with TabScreenMixin {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          print(await showConfirmDialog(
            context,
            ConfirmTexts('Are you sure?', 'Delete?'),
          ));
        },
        child: const Text('confirm'),
      ),
    );
  }
}
