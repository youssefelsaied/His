import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/my_subscription.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import 'subscription/subscription_tap.dart';

class SubscreptionPage extends StatefulWidget {
  @override
  State<SubscreptionPage> createState() => _SubscreptionPageState();
}

class _SubscreptionPageState extends State<SubscreptionPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // final auth = Provider.of<Auth>(context, listen: false);

    // _tabController = TabController(
    //     length: auth.myPackage == null ||
    //             auth.myPackage!.status == 0 ||
    //             auth.myPackage!.status == 3 ||
    //             auth.myPackage!.status == 4
    //         ? 2
    //         : 1,
    //     vsync: this);
    // _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context);
    _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.subscrebtion!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        bottom: TabBar(
          indicatorPadding: EdgeInsets.all(5),
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                locale.subscrebtion!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                locale.promotion!, //
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ),
            // Add Tabs here
          ],
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        physics: BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: [SubscriptionTap(), CodeTap()],
      ),
    );
  }
}
