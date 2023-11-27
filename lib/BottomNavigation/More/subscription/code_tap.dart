import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Components/custom_button.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/Pages/subscription_pre_summery_page.dart';
import 'package:provider/provider.dart';

import '../../../Locale/locale.dart';
import '../../../Providers/auth.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/subscription_card.dart';

class CodeTap extends StatefulWidget {
  CodeTap({Key? key}) : super(key: key);

  @override
  State<CodeTap> createState() => _CodeTapState();
}

class _CodeTapState extends State<CodeTap> {
  TextEditingController _controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    var locale = AppLocalizations.of(context)!;

    return FadedSlideAnimation(
      Container(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            // Spacer(),
            EntryField(
              label: locale.redeem_a_promo_code!,
              hint: locale.enter_a_promo_code!,
              controller: _controller,
              onValidate: (value) {
                // print(""locale.locale);
                if (value!.isEmpty) {
                  return 'please enter code';
                }
                return null;
              },
            ),

            // Spacer(
            //   flex: 12,
            // ),
            SizedBox(
              height: 10,
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : CustomButton(
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) {
                        // Invalid!
                        return;
                      }
                      setState(() {
                        loading = true;
                      });
                      // final res = await auth
                      //     .checkCode(_controller.text)
                      //     .catchError((e) {
                      //   setState(() {
                      //     loading = false;
                      //   });
                      // });
                      setState(() {
                        loading = false;
                      });
                      if (true) {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                SubscreptionPreSummrayPage(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Promotion Code",
                              msg: "please check your code !",
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
                                    locale.ok!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  )),
                            );
                          },
                        );
                      }
                    },
                  ),
            // Spacer(),
            // Spacer(),
          ]),
        ),
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
