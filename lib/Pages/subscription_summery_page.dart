// import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
// import 'package:flutter/material.dart';

// import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
// import 'package:m3ak_user/Checkout/confirm_order.dart';
// import 'package:m3ak_user/widgets/subscription_card.dart';
// import 'package:provider/provider.dart';

// import '../../Locale/locale.dart';
// import '../../Providers/auth.dart';
// import '../BottomNavigation/Medicine/select_package_payment_method.dart';
// import '../Components/custom_button.dart';
// import '../data/subscription.dart';

// class SubscreptionSummryPage extends StatefulWidget {
//   @override
//   final Package package;
//   SubscreptionSummryPage(this.package);
//   State<SubscreptionSummryPage> createState() => _SubscreptionSummryPageState();
// }

// class _SubscreptionSummryPageState extends State<SubscreptionSummryPage>
//     with TickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     // _tabController.animateTo(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;

//     return Scaffold(
//         appBar: AppBar(
//           // leading: IconButton(
//           //     onPressed: () => Navigator.pop(context),
//           //     icon: Icon(Icons.chevron_left)),
//           title: Text(
//             locale.subscrebtion!,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2!
//                 .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//           ),
//           textTheme: Theme.of(context).textTheme,
//           centerTitle: true,
//         ),
//         body: FadedSlideAnimation(
//           Padding(
//             padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//             child: SingleChildScrollView(
//               child: Container(
//                 height: MediaQuery.of(context).size.height -
//                     AppBar().preferredSize.height -
//                     MediaQuery.of(context).padding.vertical,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Container(
//                       // color: Colors.red,
//                       height: 150,
//                       child: FadedScaleAnimation(
//                         Image.asset(
//                           'assets/appIcon.png',
//                           scale: 1,
//                         ),
//                         durationInMilliseconds: 400,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Text(
//                       locale.subscrebtion!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(color: Color(0xff7c7c7c)),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       widget.package.title!,
//                       style: TextStyle(
//                           color: Theme.of(context).primaryColor, fontSize: 18),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       locale.expiration_date!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(color: Color(0xff7c7c7c)),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       DateFormat("yyyy/MM/dd")
//                           .format(DateTime.now()
//                               .add(Duration(days: widget.package.duration!)))
//                           .toString(),
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           color: Theme.of(context).primaryColor, fontSize: 18),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       locale.subscription_type!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(color: Color(0xff7c7c7c)),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       widget.package.type!,
//                       style: TextStyle(
//                           color: Theme.of(context).primaryColor, fontSize: 18),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       locale.promotion_points!,
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                             color: Color(0xff7c7c7c),
//                           ),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       "${widget.package.pointPerson} " + locale.points!,
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           color: Theme.of(context).primaryColor, fontSize: 18),
//                       textAlign: TextAlign.center,
//                     ),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     Spacer(),
//                     CustomButton(
//                       label: locale.checkout,
//                       onTap: () {
//                         Navigator.push<void>(
//                           context,
//                           MaterialPageRoute<void>(
//                             builder: (BuildContext context) =>
//                                 ChoosePackagePaymentMethod(widget.package),
//                           ),
//                         );
//                       },
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           beginOffset: Offset(0, 0.3),
//           endOffset: Offset(0, 0),
//           slideCurve: Curves.linearToEaseOut,
//         ));
//   }
// }
