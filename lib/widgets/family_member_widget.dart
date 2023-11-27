// import 'dart:io';

// import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Dialogs/deleteDialog.dart';
// import 'package:m3ak_user/Pages/sub_category_page.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/data/menu.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../BottomNavigation/Data/data.dart';
// import '../Components/custom_button.dart';
// import '../Locale/locale.dart';
// import '../Pages/sub_sub_category_page.dart';
// import '../Routes/routes.dart';
// import '../Theme/colors.dart';

// class FamilyMemberWidget extends StatefulWidget {
//   const FamilyMemberWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<FamilyMemberWidget> createState() => _FamilyMemberWidgetState();
// }

// class _FamilyMemberWidgetState extends State<FamilyMemberWidget> {
//   openwhatsapp() async {
//     var whatsapp = "+201067777202";
//     var whatsappURl_android =
//         "whatsapp://send?phone=" + whatsapp + "&text=hello";
//     var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
//     if (Platform.isIOS) {
//       // for iOS phone only
//       if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
//         // ignore: deprecated_member_use
//         await launchUrl(Uri.parse(whatappURL_ios),
//             mode: LaunchMode.externalApplication);
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
//       }
//     } else {
//       // android , web
//       if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
//         await launchUrl(Uri.parse(whatsappURl_android),
//             mode: LaunchMode.externalApplication);
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
//       }
//     }
//   }

//   bool acceptLoading = false;
//   bool rejectLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     final auth = Provider.of<Auth>(context);
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Container(
//       padding: EdgeInsets.only(
//         left: width * .025,
//         right: width * .025,
//       ),
//       child: RefreshIndicator(
//         color: Theme.of(context).primaryColor,
//         onRefresh: () async {
//           var getPendingFamilyRequests = auth.getPendingFamilyRequests();
//           var getFamilyMembers = auth.getFamilyMembers();
//           var getFamilyChildren = auth.getFamilyChildren();
//           List responses = await Future.wait(
//               [getPendingFamilyRequests, getFamilyChildren, getFamilyMembers]);
//           responses;
//           return;
//         },
//         child: ListView(
//           // mainAxisSize: MainAxisSize.max,
//           children: [
//             auth.userPendingRequests.isEmpty
//                 ? Container()
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AutoSizeText(
//                         locale.pending_requests!,
//                         style: TextStyle(color: Colors.black87, fontSize: 15),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         itemCount: auth.userPendingRequests.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                       top: 8.0,
//                                       bottom: 18.0,
//                                       // left: width * .025,
//                                       // right: width * .025,
//                                     ),
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         // Navigator.pushNamed(
//                                         //     context, PageRoutes.doctorInfo);
//                                         FocusManager.instance.primaryFocus
//                                             ?.unfocus();
//                                         await Future.delayed(
//                                             Duration(microseconds: 500));
//                                       },
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           FadedScaleAnimation(
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 width * .125,
//                                               ),
//                                               child: auth
//                                                           .userPendingRequests[
//                                                               index]
//                                                           .image ==
//                                                       ''
//                                                   ? Image.asset(
//                                                       // 'assets/img_orderplaced.png',
//                                                       'assets/appIcon.png',
//                                                       height: width * .15,
//                                                       width: width * .15,
//                                                     )
//                                                   : Image.network(
//                                                       auth
//                                                           .userPendingRequests[
//                                                               index]
//                                                           .image,
//                                                       height: width * .15,
//                                                       width: width * .15,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                             ),
//                                             durationInMilliseconds: 400,
//                                           ),
//                                           Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: width * .05),
//                                               width: width * .7,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   AutoSizeText(
//                                                     auth
//                                                         .userPendingRequests[
//                                                             index]
//                                                         .name,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             color: black2,
//                                                             height: 1.7,
//                                                             fontSize: 17,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                   ),
//                                                   AutoSizeText(
//                                                     auth
//                                                         .userPendingRequests[
//                                                             index]
//                                                         .phoneNumber,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                           color: black2,
//                                                           height: 1.7,
//                                                           fontSize: 13,
//                                                         ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       acceptLoading
//                                                           ? CircularProgressIndicator(
//                                                               color: Theme.of(
//                                                                       context)
//                                                                   .primaryColor,
//                                                             )
//                                                           : CustomButton(
//                                                               label: locale
//                                                                   .accept!,
//                                                               padding: 10,
//                                                               onTap: () async {
//                                                                 setState(() {
//                                                                   acceptLoading =
//                                                                       true;
//                                                                 });
//                                                                 //accept
//                                                                 await auth.UpdateInvitationStatues(
//                                                                     auth
//                                                                         .userPendingRequests[
//                                                                             index]
//                                                                         .id,
//                                                                     2);
//                                                                 auth.getMyPackage();
//                                                                 await auth
//                                                                     .getFamilyMembers();
//                                                                 setState(() {
//                                                                   acceptLoading =
//                                                                       false;
//                                                                 });
//                                                               },
//                                                             ),
//                                                       SizedBox(
//                                                         width: width * .05,
//                                                       ),
//                                                       rejectLoading
//                                                           ? CircularProgressIndicator(
//                                                               color: Colors.red,
//                                                             )
//                                                           : CustomButton(
//                                                               color: Colors.red,
//                                                               label: locale
//                                                                   .reject!,
//                                                               padding: 10,
//                                                               onTap: () async {
//                                                                 setState(() {
//                                                                   rejectLoading =
//                                                                       true;
//                                                                 });
//                                                                 //Reject
//                                                                 await auth.UpdateInvitationStatues(
//                                                                     auth
//                                                                         .userPendingRequests[
//                                                                             index]
//                                                                         .id,
//                                                                     0);
//                                                                 setState(() {
//                                                                   rejectLoading =
//                                                                       false;
//                                                                 });
//                                                               },
//                                                             ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               )),
//                                           // Container(
//                                           //     alignment: Alignment.center,
//                                           //     width: width * .1,
//                                           //     child: Icon(
//                                           //       index % 3 == 1
//                                           //           ? Icons.timer
//                                           //           : index % 2 == 1
//                                           //               ? Icons.check_box
//                                           //               : Icons.add_box_rounded,
//                                           //       color: index % 3 == 1
//                                           //           ? Colors.orange
//                                           //           : index % 2 == 1
//                                           //               ? Theme.of(context).primaryColor
//                                           //               : Colors.red,
//                                           //       size: 38,
//                                           //     ))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Divider(
//                                       height: 2,
//                                       thickness: 1,
//                                       color: Colors.grey),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//             auth.familyMembers.isEmpty
//                 ? Center(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         AutoSizeText("No family Members"),
//                       ],
//                     ),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       AutoSizeText(
//                         locale.family_members!,
//                         style: TextStyle(color: Colors.black87, fontSize: 15),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         itemCount: auth.familyMembers.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                       top: 8.0,
//                                       bottom: 18.0,
//                                       // left: width * .025,
//                                       // right: width * .025,
//                                     ),
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         // Navigator.pushNamed(
//                                         //     context, PageRoutes.doctorInfo);
//                                         FocusManager.instance.primaryFocus
//                                             ?.unfocus();
//                                         await Future.delayed(
//                                             Duration(microseconds: 500));
//                                       },
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           FadedScaleAnimation(
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                 width * .125,
//                                               ),
//                                               child: auth.familyMembers[index]
//                                                           .image ==
//                                                       ''
//                                                   ? Image.asset(
//                                                       // 'assets/img_orderplaced.png',
//                                                       'assets/appIcon.png',
//                                                       height: width * .15,
//                                                       width: width * .15,
//                                                     )
//                                                   : Image.network(
//                                                       auth.familyMembers[index]
//                                                           .image,
//                                                       height: width * .15,
//                                                       width: width * .15,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                             ),
//                                             durationInMilliseconds: 400,
//                                           ),
//                                           Container(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: width * .05),
//                                               width: width * .65,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   AutoSizeText(
//                                                     auth.familyMembers[index]
//                                                         .name,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                             color: black2,
//                                                             height: 1.7,
//                                                             fontSize: 17,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                   ),
//                                                   AutoSizeText(
//                                                     auth.familyMembers[index]
//                                                         .phoneNumber,
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText1!
//                                                         .copyWith(
//                                                           color: black2,
//                                                           height: 1.7,
//                                                           fontSize: 13,
//                                                         ),
//                                                   ),
//                                                 ],
//                                               )),
//                                           auth.myPackage!.transaction!
//                                               ? Container(
//                                                   // width: width * .1,
//                                                   child: IconButton(
//                                                       onPressed: () {
//                                                         showDialog(
//                                                           context: context,
//                                                           barrierDismissible:
//                                                               false,
//                                                           builder: (BuildContext
//                                                               context) {
//                                                             return DeleteDialog(
//                                                               id: auth
//                                                                   .familyMembers[
//                                                                       index]
//                                                                   .id,
//                                                               member: true,
//                                                             );
//                                                           },
//                                                         );
//                                                       },
//                                                       icon: Icon(
//                                                         Icons.delete,
//                                                         color: Colors.red,
//                                                       )),
//                                                 )
//                                               : Container()
//                                           // Container(
//                                           //     alignment: Alignment.center,
//                                           //     width: width * .1,
//                                           //     child: Icon(
//                                           //       index % 3 == 1
//                                           //           ? Icons.timer
//                                           //           : index % 2 == 1
//                                           //               ? Icons.check_box
//                                           //               : Icons.add_box_rounded,
//                                           //       color: index % 3 == 1
//                                           //           ? Colors.orange
//                                           //           : index % 2 == 1
//                                           //               ? Theme.of(context).primaryColor
//                                           //               : Colors.red,
//                                           //       size: 38,
//                                           //     ))
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   index == auth.familyMembers.length - 1
//                                       ? Container()
//                                       : Divider(
//                                           height: 2,
//                                           thickness: 1,
//                                           color: Colors.grey),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
