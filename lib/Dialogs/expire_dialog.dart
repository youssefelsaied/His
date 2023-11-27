import 'package:flutter/material.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';
import '../Routes/routes.dart';
import '../widgets/custom_dialog.dart';

class ExpireDialog extends StatelessWidget {
  const ExpireDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context, listen: false);

    return CustomDialog(
      title: (!auth.myPackage!.endDate!.isAfter(DateTime.now()))
          ? locale.your_sub_is_expired!
          : locale.your_sub_is_to_expire!,
      msg: (!auth.myPackage!.endDate!.isAfter(DateTime.now()))
          ? "0 " + locale.days_left!
          : (auth.myPackage!.endDate!.difference(DateTime.now()).inDays)
                  .toString() +
              " " +
              locale.days_left!,
      icon: Icon(
        Icons.error_outline_rounded,
        size: width * .15,
        color: Colors.red,
      ),
      mainAction: SizedBox(
        width: width * .3,
        child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.subscreptionPage);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  locale.upgrade!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ],
            )),
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
