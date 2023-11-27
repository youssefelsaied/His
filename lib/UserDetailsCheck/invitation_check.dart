import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/custom_button.dart';
import '../Components/entry_field.dart';
import '../Locale/locale.dart';
import '../Providers/global_provider.dart';

class InvitaionCheck extends StatelessWidget {
  const InvitaionCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var global = Provider.of<GlobalProvider>(context);
    final size = MediaQuery.of(context).size;
    final notch = MediaQuery.of(context).padding.top;
    final height = size.height - notch;
    final width = size.width;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        title: Text(
          locale.invitationCode!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Spacer(),
              Text(
                locale.invitationText!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).disabledColor, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 2),
              EntryField(
                prefixIcon: Icons.insert_invitation_rounded,
                hint: locale.invitationCode,
                readOnly: false,
              ),
              SizedBox(height: 20.0),
              CustomButton(
                label: locale.continuee,
                onTap: () {
                  global.nextPage();
                },
              ),
              SizedBox(height: 30.0),
              Text(
                locale.dontHaveInvitationCode!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).disabledColor, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              // Spacer(flex: 1),
              TextButton(
                  onPressed: () {
                    global.nextPage();
                  },
                  child: Text(
                    "skip",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  )),
              Spacer(flex: 12),
            ]),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
