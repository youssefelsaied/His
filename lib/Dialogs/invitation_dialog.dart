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

class InvitationDialog extends StatefulWidget {
  const InvitationDialog({Key? key}) : super(key: key);

  @override
  State<InvitationDialog> createState() => _InvitationDialogState();
}

class _InvitationDialogState extends State<InvitationDialog> {
  TextEditingController _controller = TextEditingController();
  openwhatsapp(String phoneNumber) async {
    var whatsapp = "+2" + phoneNumber;
    var whatsappURl_android = "whatsapp://send?phone=" +
        whatsapp +
        "&text=Hi we are inviting you to Ma3ak app download now from links below";
    var whatappURL_ios =
        "https://wa.me/$whatsapp?text=${Uri.parse("Hi we are inviting you to Ma3ak app download now from links below")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
        // ignore: deprecated_member_use
        await launchUrl(Uri.parse(whatappURL_ios),
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
        await launchUrl(Uri.parse(whatsappURl_android),
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

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
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                Container(
                    child: Icon(
                  Icons.group_add_outlined,
                  size: 50,
                )),
                durationInMilliseconds: 400,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Invite new member",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18.2),
              ),
              SizedBox(
                height: 20,
              ),
              Text("all beloved ones are welcome ,invite by phone number",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 20, color: black2)),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EntryField(
                  hint: locale.mobileNumber.toString(),
                  prefixIcon: Icons.phone_iphone,
                  numbersOnly: true,
                  textInputType: TextInputType.number,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  controller: _controller,
                  onValidate: (value) {
                    // print(""locale.locale);
                    if (value!.isEmpty) {
                      return locale.youMustEnter.toString() +
                          " " +
                          locale.mobileNumber.toString().toLowerCase();
                    } else if ((value.contains(' '))) {
                      return locale.please_remove_spaces;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
                    if (_controller.text.isEmpty ||
                        _controller.text.length < 11) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("please enter valid phone number")));
                    } else {
                      openwhatsapp(_controller.text);
                    }
                  },
                  child: Text(
                    "Invite",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor),
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
