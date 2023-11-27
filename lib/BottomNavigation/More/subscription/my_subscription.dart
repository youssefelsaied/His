import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Components/custom_button.dart';
import '../../../Locale/locale.dart';
import '../../../Providers/auth.dart';
import '../../../widgets/subscription_card.dart';

class MySubscription extends StatelessWidget {
  const MySubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    var locale = AppLocalizations.of(context)!;

    return FadedSlideAnimation(
      // ListView.builder(
      //   physics: AlwaysScrollableScrollPhysics(),
      //   itemBuilder: (ctx, index) {
      //     return subscriptionCard(
      //       package: auth.myPackage!.package!,
      //       showButton: false,
      //       statues: auth.myPackage!.status,
      //     );
      //   },
      //   itemCount: 1,
      // ),
      Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.vertical -
              MediaQuery.of(context).padding.bottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                color: auth.myPackage!.status == 0
                    ? Colors.red
                    : auth.myPackage!.status == 1
                        ? Colors.orange
                        : auth.myPackage!.status == 2
                            ? Colors.green
                            : auth.myPackage!.status == 3
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                label: auth.myPackage!.status == 0
                    ? locale.not_valid
                    : auth.myPackage!.status == 1
                        ? locale.pending
                        : auth.myPackage!.status == 2
                            ? locale.valid
                            : auth.myPackage!.status == 3
                                ? locale.not_valid
                                : locale.not_valid,
                onTap: () {},
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                // color: Colors.red,
                height: 150,
                child: FadedScaleAnimation(
                  Image.asset(
                    'assets/appIcon.png',
                    scale: 1,
                  ),
                  durationInMilliseconds: 400,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Your subscription on :",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Color(0xff7c7c7c)),
                textAlign: TextAlign.center,
              ),
              Text(
                auth.myPackage!.package!.title!,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Expiration date",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Color(0xff7c7c7c)),
                textAlign: TextAlign.center,
              ),
              Text(
                DateFormat("yyyy/MM/dd")
                    .format(auth.myPackage!.endDate!)
                    .toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Subscription type :",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Color(0xff7c7c7c)),
                textAlign: TextAlign.center,
              ),
              Text(
                auth.myPackage!.package!.type!,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Promotion points:",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xff7c7c7c),
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                "${auth.myPackage!.package!.pointPerson} points",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // Spacer(),
              // CustomButton(
              //   color: auth.myPackage!.status == 0
              //       ? Colors.red
              //       : auth.myPackage!.status == 1
              //           ? Colors.orange
              //           : auth.myPackage!.status == 2
              //               ? Colors.green
              //               : auth.myPackage!.status == 3
              //                   ? Colors.red
              //                   : Theme.of(context).primaryColor,
              //   label: auth.myPackage!.status == 0
              //       ? locale.not_valid
              //       : auth.myPackage!.status == 1
              //           ? locale.pending
              //           : auth.myPackage!.status == 2
              //               ? locale.valid
              //               : auth.myPackage!.status == 3
              //                   ? locale.not_valid
              //                   : locale.not_valid,
              //   onTap: () {},
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Status :",
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyText1!
              //       .copyWith(color: Color(0xff7c7c7c)),
              //   textAlign: TextAlign.center,
              // ),
              // Text(
              //   "pending",
              //   style: TextStyle(
              // color: auth.myPackage!.status == 0
              //     ? Colors.orange
              //     : Theme.of(context).primaryColor,
              //       fontSize: 18),
              //   textAlign: TextAlign.center,
              // ),
              Spacer(),
            ],
          ),
        ),
      ),

      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
