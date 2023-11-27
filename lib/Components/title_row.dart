import '../../../../Locale/locale.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final bool? showViewAll;

  TitleRow(this.title, this.onTap, this.showViewAll);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsetsDirectional.only(start: 20.0),
      title: Text(
        title!,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: lightGreyColor, fontSize: 14.5),
      ),
      trailing: onTap != null || showViewAll!
          ? TextButton(
              onPressed: onTap as void Function()?,
              child: Text(
                AppLocalizations.of(context)!.viewAll!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 14.5),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
