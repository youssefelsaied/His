import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/entry_field.dart';
import '../Providers/auth.dart';
import '../Routes/routes.dart';
import '../Theme/colors.dart';
import '../widgets/custom_dialog.dart';

class UpdateDialog extends StatefulWidget {
  final bool soft;
  const UpdateDialog({Key? key, required this.soft}) : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final auth = Provider.of<Auth>(context, listen: false);

    return GestureDetector(
      onTap: (() {
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: Container(
          // height: height * .7,
          width: width * .8,
          child: FadedSlideAnimation(
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                FadedScaleAnimation(
                  Container(
                    child: Image.asset(
                      "assets/family.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  durationInMilliseconds: 400,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "it's time to update",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 18.2),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("update now",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 20, color: black2)),
                SizedBox(height: 20),
                TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Update",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    )),

                //  SizedBox(width: width * .45, child: mainAction!),
                SizedBox(height: 10),

                widget.soft
                    ? TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          locale.cancel!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ))
                    : Container(),
              ],
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }
}
