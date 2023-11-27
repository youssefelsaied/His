import 'package:flutter/material.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';
import '../Routes/routes.dart';
import '../widgets/custom_dialog.dart';

class DeleteDialog extends StatefulWidget {
  final bool member;
  final String id;
  const DeleteDialog({Key? key, required this.id, required this.member})
      : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context, listen: false);

    return CustomDialog(
      title: widget.member ? locale.delete_member! : locale.delete_child!,
      msg: widget.member
          ? locale.delete_member_text!
          : locale.delete_child_text!,
      icon: Icon(
        Icons.error_outline_rounded,
        size: width * .15,
        color: Colors.red,
      ),
      mainAction: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SizedBox(
              width: width * .3,
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    var res;
                    if (widget.member) {
                      // res = await auth.DeleteMember(widget.id);
                    } else {
                      // res = await auth.DeleteChild(widget.id);
                    }
                    setState(() {
                      loading = false;
                    });
                    if (res) {
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        locale.delete!,
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
