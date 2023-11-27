import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/Checkout/confirm_order.dart';
import 'package:m3ak_user/Pages/subscription_summery_page.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../BottomNavigation/Medicine/select_package_payment_method.dart';
import '../Components/custom_button.dart';

class SubscreptionPreSummrayPage extends StatefulWidget {
  @override
  State<SubscreptionPreSummrayPage> createState() =>
      _SubscreptionPreSummrayPageState();
}

class _SubscreptionPreSummrayPageState extends State<SubscreptionPreSummrayPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () => Navigator.pop(context),
          //     icon: Icon(Icons.chevron_left)),
          title: Text(
            "Subscreption Card",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          Container(
            // padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // subscriptionCard(
                    //   package: auth.packageCode!.package!,
                    //   showButton: true,
                    // ),
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
                    //   label: locale.checkout,
                    //   onTap: () {
                    //     Navigator.push<void>(
                    //       context,
                    //       MaterialPageRoute<void>(
                    //         builder: (BuildContext context) =>
                    //             SubscreptionSummryPage(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}
