// import 'dart:async';

// import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// import '../Locale/locale.dart';
// import '../Providers/auth.dart';

// class QrPage extends StatefulWidget {
//   const QrPage({Key? key}) : super(key: key);

//   @override
//   State<QrPage> createState() => _QrPageState();
// }

// class _QrPageState extends State<QrPage> {
//   bool _connectionStatus = false;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   @override
//   void initState() {
//     initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

//     super.initState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     ConnectivityResult result = ConnectivityResult.none;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       print(e.toString());
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }

//     return _updateConnectionStatus(result);
//   }

//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     switch (result) {
//       case ConnectivityResult.wifi:
//       case ConnectivityResult.mobile:
//         setState(() => _connectionStatus = true);
//         break;
//       case ConnectivityResult.none:
//         setState(() => _connectionStatus = false);
//         break;
//       default:
//         setState(() => _connectionStatus = true);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final height = size.height;
//     final width = size.width;
//     final auth = Provider.of<Auth>(context, listen: true);

//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: kToolbarHeight + 10,
//         elevation: 2,
//         backgroundColor: auth.myPackage == null
//             ? Colors.red
//             : auth.myPackage!.status == 0
//                 ? Colors.red
//                 : auth.myPackage!.status == 1
//                     ? Colors.orange
//                     : auth.myPackage!.status == 2
//                         ? Colors.green
//                         : auth.myPackage!.status == 3
//                             ? Colors.red
//                             : Theme.of(context).primaryColor,
//         centerTitle: true,
//         title: AutoSizeText(
//           _connectionStatus == false && auth.myPackage == null
//               ? locale.no_intenet!
//               : locale.account! +
//                   " " +
//                   (auth.myPackage == null
//                       ? locale.not_valid!
//                       : auth.myPackage!.status == 0
//                           ? locale.not_valid!
//                           : auth.myPackage!.status == 1
//                               ? locale.pending!
//                               : auth.myPackage!.status == 2
//                                   ? locale.valid!
//                                   : auth.myPackage!.status == 3
//                                       ? locale.not_valid!
//                                       : locale.not_valid!),
//           style: TextStyle(
//               color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
//           maxLines: 1,
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: FadedSlideAnimation(
//         RefreshIndicator(
//           color: Theme.of(context).primaryColor,
//           onRefresh: () async {
//             await auth.getMyPackage();
//             return;
//           },
//           child: Container(
//             // color: Colors.red,
//             child: MediaQuery.removePadding(
//               removeTop: true,
//               context: context,
//               child: ListView(
//                 shrinkWrap: true,
//                 // physics: BouncingScrollPhysics(),
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     // width: 50,
//                     // height: 50,
//                     // color: Colors.red,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(50),
//                       child: Image.asset(
//                         'assets/logo_ma3ak_horizontal.png',
//                         // width: 100,
//                         height: 100,
//                         fit: BoxFit.contain,
//                         // scale: 2,
//                       ),
//                     ),
//                   ),

//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   Center(
//                     child: AutoSizeText(
//                       "Your Qr code",
//                       style:
//                           TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   Center(
//                     child: QrImage(
//                       data: auth.theUser!.memberNum!,
//                       version: QrVersions.auto,
//                       size: 150.0,
//                     ),
//                   ),
//                   Center(
//                     child: AutoSizeText(
//                       locale.accountNumber!,
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                             color: Color(0xff7c7c7c),
//                             // fontSize:
//                           ),
//                     ),
//                   ),
//                   Center(
//                     child: AutoSizeText(
//                       auth.theUser!.memberNum!,
//                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           color: Theme.of(context).primaryColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   AutoSizeText(
//                     "${locale.fullName}",
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           color: Color(0xff7c7c7c),
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   AutoSizeText(
//                     "${auth.theUser!.name!}",
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   AutoSizeText(
//                     locale.mobileNumber!,
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           color: Color(0xff7c7c7c),
//                         ),
//                     textAlign: TextAlign.center,
//                   ),
//                   AutoSizeText(
//                     "${auth.theUser!.phoneNumber!}",
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   auth.myPackage == null
//                       ? Column(
//                           children: [
//                             SizedBox(
//                               height: 20,
//                             ),
//                             AutoSizeText(
//                               _connectionStatus == false
//                                   ? locale.no_intenet!
//                                   : locale.not_sub!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(color: Colors.red, fontSize: 20),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         )
//                       : Column(
//                           children: [
//                             SizedBox(
//                               height: 10,
//                             ),
//                             AutoSizeText(
//                               locale.you_subscription_on!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(color: Color(0xff7c7c7c)),
//                               textAlign: TextAlign.center,
//                             ),
//                             AutoSizeText(
//                               auth.myPackage!.package!.title!,
//                               style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             AutoSizeText(
//                               locale.expiration_date!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(color: Color(0xff7c7c7c)),
//                               textAlign: TextAlign.center,
//                             ),
//                             AutoSizeText(
//                               DateFormat("yyyy/MM/dd")
//                                   .format(auth.myPackage!.endDate!)
//                                   .toString(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(
//                                       color: Theme.of(context).primaryColor,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             AutoSizeText(
//                               locale.subscription_type!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(color: Color(0xff7c7c7c)),
//                               textAlign: TextAlign.center,
//                             ),
//                             AutoSizeText(
//                               auth.myPackage!.package!.type!,
//                               style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             AutoSizeText(
//                               locale.promotion_points!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(
//                                     color: Color(0xff7c7c7c),
//                                   ),
//                               textAlign: TextAlign.center,
//                             ),
//                             AutoSizeText(
//                               auth.myPackage!.package!.pointPerson.toString(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(
//                                       color: Theme.of(context).primaryColor,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),

//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     AutoSizeText("${locale.fullName} : "),
//                   //     AutoSizeText(auth.theUser!.name!),
//                   //   ],
//                   // ),
//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     AutoSizeText("Account Expire Date : "),
//                   //     AutoSizeText("11/02/1023"),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         beginOffset: Offset(0, 0.3),
//         endOffset: Offset(0, 0),
//         slideCurve: Curves.linearToEaseOut,
//       ),
//     );
//   }
// }
