import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:m3ak_user/data/family_user.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';
import '../Routes/routes.dart';
import '../Theme/colors.dart';
import '../widgets/custom_dialog.dart';

class AddFamilyMemberDialog extends StatefulWidget {
  final FamilyUserMember user;
  AddFamilyMemberDialog({Key? key, required this.user}) : super(key: key);

  @override
  State<AddFamilyMemberDialog> createState() => _AddFamilyMemberDialogState();
}

class _AddFamilyMemberDialogState extends State<AddFamilyMemberDialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context, listen: false);

    return GestureDetector(
      onTap: (() {
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: FadedSlideAnimation(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              FadedScaleAnimation(
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    width * .125,
                  ),
                  child: widget.user.image == ''
                      ? Image.asset(
                          // 'assets/img_orderplaced.png',
                          'assets/appIcon.png',
                          height: width * .25,
                          width: width * .25,
                        )
                      : Image.network(
                          widget.user.image,
                          height: width * .25,
                          width: width * .25,
                          fit: BoxFit.cover,
                        ),
                ),
                durationInMilliseconds: 400,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Are you sure you want to add ",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18, color: black2),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.user.name,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18.2),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "as a member to your family",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 18, color: black2),
                // textAlign: TextAlign.center,
              ),

              SizedBox(height: 15.0),
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                  : TextButton(
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        // final res = await auth.InviteFamily(widget.user.id);
                        setState(() {
                          loading = false;
                        });
                        if (true) {
                          //  await auth.getPendingFamilyRequests();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Add",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      )),

              //  SizedBox(width: width * .45, child: mainAction!),

              TextButton(
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
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
