import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/auth.dart';
import '../../../widgets/subscription_card.dart';

class SubscriptionTap extends StatelessWidget {
  const SubscriptionTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);

    return FadedSlideAnimation(
      ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return Text("data");
        },
        itemCount: auth.avialablePackages.length,
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
