// import 'dart:io';
// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:m3ak_user/Dialogs/invitation_dialog.dart';
// import 'package:m3ak_user/Pages/add_child_page_first.dart';
// import 'package:m3ak_user/Pages/search_family_members.dart';
// import 'package:m3ak_user/widgets/family_child_widget.dart';
// import 'package:m3ak_user/widgets/family_member_widget.dart';
// import 'package:provider/provider.dart';
// import '../../Locale/locale.dart';
// import '../../Providers/auth.dart';

// class FamilyPage extends StatefulWidget {
//   @override
//   _FamilyPageState createState() => _FamilyPageState();
// }

// class _FamilyPageState extends State<FamilyPage> with TickerProviderStateMixin {
//   late TabController _tabController;
//   final picker = ImagePicker();
//   File? editedImg;
//   TextEditingController firstNameController = TextEditingController();

//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   void _showAddOptiosSheet(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;

//     if (Platform.isIOS) {
//       showCupertinoModalPopup(
//         context: context,
//         builder: (context) => CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               child: Text(
//                 locale.add_family_member!,
//                 style: TextStyle(color: Theme.of(context).primaryColor),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.push<void>(
//                   context,
//                   MaterialPageRoute<void>(
//                     builder: (BuildContext context) => SearchFamilyMembers(),
//                   ),
//                 ); // _getImage(ImageSource.camera);
//               },
//             ),
//             // CupertinoActionSheetAction(
//             //   child: Text(
//             //     'Add Related Member',
//             //     style: TextStyle(color: Theme.of(context).primaryColor),
//             //   ),
//             //   onPressed: () {
//             //     Navigator.pop(context);
//             //     Navigator.push<void>(
//             //       context,
//             //       MaterialPageRoute<void>(
//             //         builder: (BuildContext context) => SearchFamilyMembers(),
//             //       ),
//             //     );
//             //   },
//             // ),
//             CupertinoActionSheetAction(
//               child: Text(
//                 locale.add_child!,
//                 style: TextStyle(color: Theme.of(context).primaryColor),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.push<void>(
//                   context,
//                   MaterialPageRoute<void>(
//                     builder: (BuildContext context) => AddChildPageFirst(),
//                   ),
//                 );
//               },
//             ),
//             CupertinoActionSheetAction(
//               child: Text(
//                 locale.invite_new_member!,
//                 style: TextStyle(color: Theme.of(context).primaryColor),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 showDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   builder: (BuildContext context) {
//                     return InvitationDialog();
//                   },
//                 );
//                 // _getImage(ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//       );
//     } else {
//       showModalBottomSheet(
//         // barrierColor: Theme.of(context).primaryColor,
//         context: context,
//         builder: (context) => Wrap(children: [
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text(
//               locale.add_family_member!,
//               style: TextStyle(color: Theme.of(context).primaryColor),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push<void>(
//                 context,
//                 MaterialPageRoute<void>(
//                   builder: (BuildContext context) => SearchFamilyMembers(),
//                 ),
//               );
//             },
//           ),
//           // ListTile(
//           //   leading: Icon(Icons.person),
//           //   title: Text(
//           //     'Add Related Member',
//           //     style: TextStyle(color: Theme.of(context).primaryColor),
//           //   ),
//           //   onTap: () {
//           //     Navigator.pop(context);
//           //     Navigator.push<void>(
//           //       context,
//           //       MaterialPageRoute<void>(
//           //         builder: (BuildContext context) => SearchFamilyMembers(),
//           //       ),
//           //     );
//           //   },
//           // ),
//           ListTile(
//             leading: Icon(Icons.child_care),
//             title: Text(
//               locale.add_child!,
//               style: TextStyle(color: Theme.of(context).primaryColor),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push<void>(
//                 context,
//                 MaterialPageRoute<void>(
//                   builder: (BuildContext context) => AddChildPageFirst(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.group_add),
//             title: Text(
//               locale.invite_new_member!,
//               style: TextStyle(color: Theme.of(context).primaryColor),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               showDialog(
//                 context: context,
//                 barrierDismissible: true,
//                 builder: (BuildContext context) {
//                   return InvitationDialog();
//                 },
//               );
//             },
//           ),
//         ]),
//       );
//     }
//   }

//   // Future<void> save() async {
//   //   final auth = Provider.of<Auth>(context, listen: false);
//   //   try {
//   //     print("it should edit ");
//   //     showDialog(
//   //       context: context,
//   //       barrierDismissible: true,
//   //       builder: (BuildContext context) {
//   //         return SaveLoading(
//   //           title: "editing Profile",
//   //         );
//   //       },
//   //     );
//   //     auth.theUser!.firstName = firstNameController.text;
//   //     auth.theUser!.lastName = lastNameController.text;
//   //     // auth.theUser!.email = emailController.text;
//   //     // auth.theUser!.name = name.text;
//   //     await auth
//   //         .editProfile(
//   //       editedImg,
//   //     )
//   //         .then((_) {
//   //       Navigator.of(context).pop();
//   //       Navigator.of(context).pop();
//   //     }).onError((error, stackTrace) {
//   //       Navigator.of(context).pop();

//   //       showDialog(
//   //         context: context,
//   //         barrierDismissible: true,
//   //         builder: (BuildContext context) {
//   //           return ErrorDialog(
//   //             title: "Error",
//   //             msg: "Error Occured with your request, try again later!",
//   //           );
//   //         },
//   //       );
//   //     });
//   //   } catch (error) {
//   //     Navigator.of(context).pop();

//   //     showDialog(
//   //       context: context,
//   //       barrierDismissible: true,
//   //       builder: (BuildContext context) {
//   //         return ErrorDialog(
//   //           title: "Error",
//   //           msg: "Error Occured with your request, try again later!",
//   //         );
//   //       },
//   //     );
//   //   }
//   // }

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);

//     super.initState();
//   }

//   // CityElement? city;

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     final auth = Provider.of<Auth>(context);
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     // print("The user image is${auth.theUser!.image}h");

//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () => Navigator.pop(context)),
//           centerTitle: true,
//           title: Text(
//             locale.family!,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2!
//                 .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//           ),
//           textTheme: Theme.of(context).textTheme,
//         ),
//         body: FadedSlideAnimation(
//           Column(
//             // physics: NeverScrollableScrollPhysics(),
//             // shrinkWrap: true,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                 height: height * .3,
//                 child: Stack(
//                   children: [
//                     Image.asset(
//                       "assets/family.jpeg",
//                       fit: BoxFit.cover,
//                     ),
//                     Container(
//                       color: Colors.black45,
//                     ),
//                     Positioned(
//                         top: width * .05,
//                         bottom: width * .05,
//                         width: width,
//                         child: Container(
//                           alignment: Alignment.center,
//                           // decoration: BoxDecoration(
//                           //   borderRadius: BorderRadius.circular(100),
//                           //   color: Colors.black45,
//                           // ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               AutoSizeText(
//                                 auth.theUser!.username!,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                               SizedBox(
//                                 height: height * .01,
//                               ),
//                               AutoSizeText(
//                                 auth.familyMembers.length.toString() +
//                                     " " +
//                                     locale.members!,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         )),
//                     auth.myPackage!.transaction!
//                         ? Positioned(
//                             bottom: width * .05,
//                             right: width * .05,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 color: Colors.black45,
//                               ),
//                               child: IconButton(
//                                   onPressed: () {
//                                     _showAddOptiosSheet(context);
//                                   },
//                                   icon: Icon(
//                                     Icons.group_add_outlined,
//                                     color: Colors.white,
//                                   )),
//                             ))
//                         : Container()
//                   ],
//                 ),
//               ),
//               TabBar(
//                 indicatorPadding: EdgeInsets.all(5),
//                 controller: _tabController,
//                 indicatorColor: Theme.of(context).primaryColor,
//                 tabs: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 18.0),
//                     child: AutoSizeText(
//                       locale.members!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText2!
//                           .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
//                       maxLines: 1,
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.symmetric(vertical: 18.0),
//                   //   child: AutoSizeText(
//                   //     "Related",
//                   //     style: Theme.of(context)
//                   //         .textTheme
//                   //         .bodyText2!
//                   //         .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
//                   //     maxLines: 1,
//                   //   ),
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 18.0),
//                     child: AutoSizeText(
//                       locale.children!,
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText2!
//                           .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
//                       maxLines: 1,
//                     ),
//                   ),
//                   // Add Tabs here
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   physics: BouncingScrollPhysics(),
//                   dragStartBehavior: DragStartBehavior.down,
//                   children: [
//                     FamilyMemberWidget(),
//                     // RelatedMemberWidget(),
//                     FamilyChildWidget()
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           beginOffset: Offset(0, 0.3),
//           endOffset: Offset(0, 0),
//           slideCurve: Curves.linearToEaseOut,
//         ));
//   }
// }
