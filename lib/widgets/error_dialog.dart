import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Locale/locale.dart';
import 'custom_dialog.dart';

class ErrorDialog extends StatelessWidget {
  String title;
  String msg;
  ErrorDialog({Key? key, required this.msg, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notch = MediaQuery.of(context).padding.top;
    final height = size.height - notch;
    final width = size.width;
    var locale = AppLocalizations.of(context)!;

    return CustomDialog(
      title: title,
      msg: msg,
      icon: Icon(
        Icons.error_outline_rounded,
        size: width * .15,
        color: Colors.red,
      ),
      secondAction: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            locale.cancel!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
          )),
    );
  }
}
