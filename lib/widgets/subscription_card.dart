// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Components/custom_button.dart';
// import 'package:m3ak_user/Pages/subscription_summery_page.dart';
// import 'package:m3ak_user/data/subscription.dart';
// import 'package:m3ak_user/widgets/error_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../Locale/locale.dart';
// import '../Providers/auth.dart';
// import 'custom_dialog.dart';

// class subscriptionCard extends StatefulWidget {
//   final Package package;
//   final bool showButton;
//   final int? statues;
//   const subscriptionCard({
//     Key? key,
//     required this.package,
//     required this.showButton,
//     this.statues,
//   }) : super(key: key);

//   @override
//   State<subscriptionCard> createState() => _subscriptionCardState();
// }

// class _subscriptionCardState extends State<subscriptionCard> {
//   bool loading = false;
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;

//     final auth = Provider.of<Auth>(context, listen: true);
//     final width = MediaQuery.of(context).size.width;

//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       decoration: BoxDecoration(
//           border: Border.all(
//             color: Theme.of(context).primaryColor,
//           ),
//           color: Colors.grey.withOpacity(.1),
//           borderRadius: BorderRadius.circular(15)),
//       child: Column(children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: width * .5,
//                     child: Text(
//                       widget.package.title!,
//                       // "Yearly Subscription",
//                       style: TextStyle(
//                           color: Theme.of(context).primaryColor, fontSize: 18),
//                     ),
//                   ),
//                   Text(
//                     widget.package.duration!.toString() + " ${locale.days} ",
//                     style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400),
//                   ),
//                   Text(
//                     // 'Renew every year',
//                     widget.package.type!,

//                     style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400),
//                   ),
//                   // Spacer()
//                   Text(
//                     // 'Renew every year',
//                     widget.package.pointPerson!.toString() +
//                         " ${locale.points} ",

//                     style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   borderRadius: BorderRadius.circular(12)),
//               child: Column(children: [
//                 // Text(
//                 //   (double.parse(widget.package.price!) +
//                 //           double.parse(widget.package.price!) / 2)
//                 //       .toString(),
//                 //   style: TextStyle(
//                 //       fontSize: 15,
//                 //       decoration: TextDecoration.lineThrough,
//                 //       color: Colors.grey.withOpacity(.8)),
//                 // ),
//                 Text(
//                   widget.package.price!,
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor.withOpacity(.9)),
//                 ),
//                 Text(
//                   'EGP',
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor.withOpacity(.9)),
//                 ),
//               ]),
//             ),
//           ],
//         ),
//         !widget.showButton
//             ? Text('')
//             : Container(
//                 margin: EdgeInsets.only(right: 20, left: 20, top: 30),
//                 child: loading
//                     ? CircularProgressIndicator(
//                         color: Theme.of(context).primaryColor,
//                       )
//                     : SizedBox(
//                         width: width * .5,
//                         child: CustomButton(
//                           padding: 10,
//                           // textSize: ,
//                           color: Theme.of(context).primaryColor,
//                           label: locale.subscribe_now!,
//                           textColor: Colors.white,
//                           onTap: () {
//                             // if (auth.myPackage != null) {
//                             // showDialog(
//                             //   context: context,
//                             //   barrierDismissible: true,
//                             //   builder: (BuildContext context) {
//                             //     return CustomDialog(
//                             //       title: locale.subscrebtion!,
//                             //       msg: locale.already_subscribed!,
//                             //       icon: Icon(
//                             //         Icons.error_outline_rounded,
//                             //         size: width * .15,
//                             //         color: Colors.red,
//                             //       ),
//                             //       mainAction: SizedBox(
//                             //         width: width * .3,
//                             //         child: TextButton(
//                             //             style: TextButton.styleFrom(
//                             //               padding: EdgeInsets.symmetric(
//                             //                   horizontal: 10, vertical: 14),
//                             //               backgroundColor:
//                             //                   Theme.of(context).primaryColor,
//                             //             ),
//                             //             onPressed: () {
//                             //               print("calling 01029979175");
//                             //               final Uri launchUri = Uri(
//                             //                 scheme: 'tel',
//                             //                 path: '01029979175',
//                             //               );
//                             //               launchUrl(launchUri);
//                             //             },
//                             //             child: Row(
//                             //               mainAxisAlignment:
//                             //                   MainAxisAlignment.center,
//                             //               children: [
//                             //                 Text(
//                             //                   locale.callNow!,
//                             //                   style: Theme.of(context)
//                             //                       .textTheme
//                             //                       .bodyText1!
//                             //                       .copyWith(
//                             //                           color: Colors.white),
//                             //                 ),
//                             //                 SizedBox(
//                             //                   width: 5,
//                             //                 ),
//                             //                 Icon(
//                             //                   Icons.call,
//                             //                   color: Colors.white,
//                             //                 ),
//                             //               ],
//                             //             )),
//                             //       ),
//                             //       secondAction: TextButton(
//                             //           onPressed: () {
//                             //             Navigator.pop(context);
//                             //           },
//                             //           child: Text(
//                             //             locale.cancel!,
//                             //             style: Theme.of(context)
//                             //                 .textTheme
//                             //                 .bodyText1!
//                             //                 .copyWith(
//                             //                     color: Theme.of(context)
//                             //                         .primaryColor),
//                             //           )),
//                             //     );
//                             //   },
//                             // );
//                             // } else {
//                             Navigator.push<void>(
//                               context,
//                               MaterialPageRoute<void>(
//                                 builder: (BuildContext context) =>
//                                     SubscreptionSummryPage(widget.package),
//                               ),
//                             );
//                             // }
//                           },
//                           // onTap: () async {
//                           //   setState(() {
//                           //     loading = true;
//                           //   });
//                           //   var res = await auth.subscribe(widget.package.id);

//                           //   setState(() {
//                           //     loading = false;
//                           //   });
//                           //   if (res) {
//                           //     showDialog(
//                           //       context: context,
//                           //       barrierDismissible: true,
//                           //       builder: (BuildContext context) {
//                           //         return CustomDialog(
//                           //           title: "Your Request sent Successfully",
//                           //           msg: "Admin will review your request",
//                           //         );
//                           //       },
//                           //     );
//                           //   } else {
//                           //     showDialog(
//                           //       context: context,
//                           //       barrierDismissible: true,
//                           //       builder: (BuildContext context) {
//                           //         return ErrorDialog(
//                           //           title: "Error",
//                           //           msg:
//                           //               "Error Occured with your request, try again later!",
//                           //         );
//                           //       },
//                           //     );
//                           //   }
//                           // },

//                           // textSize: 12,
//                           // fontWeight: FontWeight.normal,
//                         ),
//                       ),
//               ),
//         // widget.statues == null
//         //     ? Text('')
//         //     : Container(
//         //         margin: EdgeInsets.only(right: 20, left: 20, top: 10),
//         //         child: SizedBox(
//         //           width: width * .5,
//         //           child: CustomButton(
//         //             padding: 10,
//         //             // textSize: ,
//         //             color: widget.statues! == 0
//         //                 ? Colors.orange
//         //                 : Theme.of(context).primaryColor,
//         //             label:
//         //                 widget.statues! == 0 ? locale.pending : "Subscribe Now",
//         //             textColor: Colors.white,
//         //             onTap: () {},
//         //           ),
//         //         ),
//         //       )
//       ]),
//     );
//   }
// }
