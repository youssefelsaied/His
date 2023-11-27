// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:m3ak_user/BottomNavigation/Medicine/paymob_payment.dart';
// import 'package:m3ak_user/Pages/fawry_payment_page.dart';
// import 'package:m3ak_user/Pages/last_payment_page.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/data/subscription.dart';
// import 'package:m3ak_user/widgets/custom_dialog.dart';
// import 'package:m3ak_user/widgets/error_dialog.dart';
// import 'package:m3ak_user/widgets/loading_dialog.dart';
// import 'package:provider/provider.dart';
// import '../../../../Locale/locale.dart';
// import '../../../../Theme/colors.dart';
// import 'package:flutter/material.dart';

// import 'fawry_payment.dart';

// class ChoosePackagePaymentMethod extends StatefulWidget {
//   Package package;
//   ChoosePackagePaymentMethod(this.package);
//   @override
//   _ChoosePackagePaymentMethodState createState() =>
//       _ChoosePackagePaymentMethodState();
// }

// class PaymentType {
//   int? paymentMethodId;
//   String? icon;
//   String? title;
//   String? subTitle;
//   String? description;
//   String? phoneNumber;

//   PaymentType(
//       {this.paymentMethodId,
//       this.icon,
//       this.title,
//       this.subTitle,
//       this.description,
//       this.phoneNumber});
// }

// class _ChoosePackagePaymentMethodState
//     extends State<ChoosePackagePaymentMethod> {
//   List<PaymentType> paymentModes = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     final auth = Provider.of<Auth>(context, listen: false);

//     auth.avialablePaymentMethods.forEach((element) {
//       paymentModes.add(
//         PaymentType(
//             paymentMethodId: element.id,
//             icon: element.image,
//             title: element.title,
//             description: element.description,
//             phoneNumber: element.phoneNumber),
//       );
//     });
//     paymentModes.add(
//       PaymentType(
//         icon: '',
//         title: "Credit Card",
//         subTitle: "powered by paymob",
//       ),
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     final auth = Provider.of<Auth>(context);
//     // List<PaymentType> paymentModes = [
//     //   PaymentType(
//     //       icon: 'assets/vodafone-png-logo.png',
//     //       title: 'Vodafone Cash',
//     //       description:
//     //           "You can pay for the subscription using the Vodafone Cash wallet on the following number",
//     //       phoneNumber: "01000095624"),
//     //   PaymentType(
//     //       icon: 'assets/etisalat_cash_logo.jpeg',
//     //       title: 'Etisalat Cash',
//     //       description:
//     //           "You can pay for the subscription using the Etisalat Cash wallet on the following number",
//     //       phoneNumber: "01149888466"),
//     //   PaymentType(icon: '', title: "Credit Card", subTitle: "Coming Soon"),
//     // ];

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(Icons.chevron_left)),
//         centerTitle: true,
//         title: Text(
//           locale.selectPaymentMethod!,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText2!
//               .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//         ),
//       ),
//       body: FadedSlideAnimation(
//         SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding:
//                     EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 20),
//                 child: RichText(
//                     text: TextSpan(children: <TextSpan>[
//                   TextSpan(
//                       text: locale.amountToPay!.toUpperCase(),
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontSize: 13.5, color: Color(0xff999999), height: 2)),
//                   TextSpan(
//                       text: '\nEGP ${widget.package.price}',
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontSize: 35,
//                           color: black2,
//                           fontWeight: FontWeight.bold))
//                 ])),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Theme.of(context).backgroundColor,
//                 padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
//                 child: Text(
//                   locale.paymentModes!,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(color: black2),
//                 ),
//               ),
//               Container(
//                 color: Colors.transparent,
//                 child: ListTile(
//                   onTap: () async {
//                     showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (BuildContext context) {
//                         return LoadingDialog(
//                           msg: 'Generating fawry number',
//                         );
//                       },
//                     );

//                     bool res = await auth.GetFawryPaymentRefrenceNumber(
//                             itemId: widget.package.id.toString(),
//                             itemDescription: widget.package.title!,
//                             price: double.parse(widget.package.price!)
//                                 .toStringAsFixed(2),
//                             quantity: 1)
//                         .catchError((e, b) {
//                       print(e);
//                       print("something went wrong");
//                       return false;
//                     });
//                     if (auth.FawryCode != null && res) {
//                       Navigator.pop(context);
//                       Navigator.push<void>(
//                         context,
//                         MaterialPageRoute<void>(
//                             builder: (BuildContext context) => FawryPaymentPage(
//                                   widget.package,
//                                 )),
//                       );
//                     } else {
//                       print("something went wrong");
//                       Navigator.pop(context);
//                       showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (BuildContext context) {
//                           return ErrorDialog(
//                             msg: "Something went Wrong",
//                             title: 'Generating fawry number',
//                           );
//                         },
//                       );
//                     }
//                   },
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 16, vertical: 7),
//                   leading: SizedBox(
//                     width: 40,
//                     height: 40,
//                     child: FadedScaleAnimation(
//                       Image.asset(
//                         "assets/fawry-1.png",
//                         scale: 2,
//                       ),
//                       durationInMilliseconds: 400,
//                     ),
//                   ),
//                   title: Text(
//                     "Fawry",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   subtitle: Text(
//                     "Refrence Number",
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey.withOpacity(.9),
//                         fontSize: 10),
//                   ),
//                 ),
//               ),
//               Divider(
//                 thickness: 4,
//                 height: 4,
//               ),
//               ListView.builder(
//                   itemCount: auth.avialablePaymentMethods.length + 1,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Container(
//                           color: paymentModes[index].subTitle == null
//                               ? Colors.transparent
//                               : Theme.of(context).backgroundColor,
//                           child: ListTile(
//                             onTap: () async {
//                               if (index !=
//                                   auth.avialablePaymentMethods.length) {
//                                 Navigator.push<void>(
//                                   context,
//                                   MaterialPageRoute<void>(
//                                       builder: (BuildContext context) =>
//                                           LastPaymentPage(
//                                             widget.package,
//                                             paymentModes[index].icon!,
//                                             paymentModes[index].title!,
//                                             paymentModes[index].description!,
//                                             paymentModes[index].phoneNumber!,
//                                             paymentModes[index]
//                                                 .paymentMethodId!,
//                                           )),
//                                 );
//                               } else {
//                                 await auth.getFirstToken(
//                                     double.parse(widget.package.price!));

//                                 Navigator.push<void>(
//                                   context,
//                                   MaterialPageRoute<void>(
//                                       builder: (BuildContext context) =>
//                                           PaymobPayment()),
//                                 );

//                                 // String fawryUrl = await auth.GetFawryPaymentUrl(
//                                 //   itemId: widget.package.id.toString(),
//                                 //   itemDescription:
//                                 //       widget.package.title.toString(),
//                                 //   price: double.parse(widget.package.price!)
//                                 //       .toStringAsFixed(2),
//                                 //   quantity: 1,
//                                 // );
//                                 // if (fawryUrl == "false") {
//                                 //   print("No internit connection");
//                                 // } else {
//                                 //   // InAppWebView.op
//                                 //   // Navigator.push<void>(
//                                 //   //   context,
//                                 //   //   MaterialPageRoute<void>(
//                                 //   //       builder: (BuildContext context) =>
//                                 //   //           FawryPayment(
//                                 //   //             fawryUrl: fawryUrl,
//                                 //   //           )),
//                                 //   // );
//                                 // }
//                               }
//                             },
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 7),
//                             leading: SizedBox(
//                               width: 40,
//                               child: paymentModes[index].icon == ''
//                                   ? CircleAvatar(
//                                       backgroundColor: Colors.grey[100],
//                                       child: Icon(
//                                         Icons.credit_card,
//                                         size: 20,
//                                         color: Colors.lightGreen,
//                                       ))
//                                   : FadedScaleAnimation(
//                                       Image.network(
//                                         paymentModes[index].icon!,
//                                         scale: 3,
//                                       ),
//                                       durationInMilliseconds: 400,
//                                     ),
//                             ),
//                             title: Text(
//                               paymentModes[index].title!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(fontWeight: FontWeight.w600),
//                             ),
//                             subtitle: paymentModes[index].subTitle == null
//                                 ? null
//                                 : Text(
//                                     paymentModes[index].subTitle!,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.grey.withOpacity(.8),
//                                             fontSize: 10),
//                                   ),
//                           ),
//                         ),
//                         Divider(
//                           thickness: 4,
//                           height: 4,
//                         ),
//                       ],
//                     );
//                   }),
//               Container(
//                 height: 20,
//                 // color: Theme.of(context).backgroundColor,
//               ),
//             ],
//           ),
//         ),
//         beginOffset: Offset(0, 0.3),
//         endOffset: Offset(0, 0),
//         slideCurve: Curves.linearToEaseOut,
//       ),
//     );
//   }
// }
// //done
