// import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Dialogs/add_family_member_dialog.dart';
// import 'package:provider/provider.dart';

// import '../Components/entry_field.dart';
// import '../Locale/locale.dart';
// import '../Providers/auth.dart';
// import '../Providers/menu_provider.dart';
// import '../Theme/colors.dart';
// import 'brand_info_page.dart';

// class SearchFamilyMembers extends StatefulWidget {
//   const SearchFamilyMembers({Key? key}) : super(key: key);

//   @override
//   State<SearchFamilyMembers> createState() => _SearchFamilyMembersState();
// }

// class _SearchFamilyMembersState extends State<SearchFamilyMembers> {
//   @override
//   void initState() {
//     final auth = Provider.of<Auth>(context, listen: false);
//     auth.FamilyUserMembers = [];

//     super.initState();
//   }

//   bool showSearch = false;
//   void search(String value) {
//     var locale = AppLocalizations.of(context)!;
//     final auth = Provider.of<Auth>(context, listen: false);
//     final menu = Provider.of<MenuProvider>(context, listen: false);

//     if (value == '') {
//       ScaffoldMessenger.of(context).clearSnackBars();

//       setState(() {
//         showSearch = false;
//         auth.clearSearchUsers();
//       });
//     } else {
//       if (value.length < 11) {
//         auth.clearSearchUsers();
//         // ScaffoldMessenger.of(context)
//         //     .showSnackBar(SnackBar(content: Text(locale.phoneVerification!)));
//         setState(() {
//           showSearch = false;
//         });
//       } else {
//         ScaffoldMessenger.of(context).clearSnackBars();
//         auth.searchUsersbyPhone(value);
//         setState(() {
//           showSearch = true;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final height = size.height - notch;
//     final width = size.width;
//     final menu = Provider.of<MenuProvider>(context, listen: true);
//     final auth = Provider.of<Auth>(context, listen: true);

//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Container(
//           height: size.height,
//           child: Column(children: [
//             SizedBox(
//               height: notch,
//             ),
//             SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: SizedBox(
//                 height: height,
//                 child: Column(children: [
//                   FadedScaleAnimation(
//                     Container(
//                       height: height * .1,
//                       padding:
//                           const EdgeInsets.only(top: 20.0, left: 15, right: 15),
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText1!
//                             .copyWith(fontSize: 14.5),
//                         // initialValue: '',
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none),
//                           hintText: locale.search!,
//                           filled: true,
//                           fillColor: Theme.of(context).backgroundColor,
//                           prefixIcon: IconButton(
//                               onPressed: () {
//                                 FocusManager.instance.primaryFocus?.unfocus();

//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.arrow_back_ios,
//                                 size: 20,
//                               )),
//                           suffixIcon: Icon(Icons.search),
//                         ),
//                         onChanged: (v) {
//                           search(v);
//                         },
//                       ),
//                     ),
//                     durationInMilliseconds: 300,
//                   ),
//                   auth.searchLoading
//                       ? Container(
//                           height: height * .9,
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircularProgressIndicator(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         )
//                       : auth.FamilyUserMembers.isEmpty
//                           ? Container(
//                               height: height * .9,
//                               child: Center(
//                                 child: Column(children: [
//                                   Spacer(
//                                     flex: 8,
//                                   ),
//                                   Icon(
//                                     Icons.person,
//                                     size: 100,
//                                     color: Colors.grey,
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     locale.no_users!,
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   Spacer(
//                                     flex: 8,
//                                   ),
//                                 ]),
//                               ),
//                             )
//                           : Column(
//                               children: [
//                                 // Container(
//                                 //   height: height * .15,
//                                 //   child: Column(children: [
//                                 //     SizedBox(
//                                 //         height: height * .03,
//                                 //         child: AutoSizeText(
//                                 //             "your family members")),
//                                 //     SizedBox(
//                                 //       height: height * .01,
//                                 //     ),
//                                 //     SizedBox(
//                                 //       width: width,
//                                 //       height: height * .1,
//                                 //       child: ListView.builder(
//                                 //         scrollDirection: Axis.horizontal,
//                                 //         itemCount: 5,
//                                 //         itemBuilder: (ctx, index) {
//                                 //           return Padding(
//                                 //             padding: const EdgeInsets.symmetric(
//                                 //                 horizontal: 8.0),
//                                 //             child: Stack(
//                                 //               children: [
//                                 //                 ClipRRect(
//                                 //                   borderRadius:
//                                 //                       BorderRadius.circular(50),
//                                 //                   child: FancyShimmerImage(
//                                 //                     imageUrl:
//                                 //                         auth.theUser!.image!,
//                                 //                     height: height * .1,
//                                 //                     width: height * .1,
//                                 //                     boxFit: BoxFit.cover,
//                                 //                     shimmerBaseColor:
//                                 //                         Colors.grey.shade400,
//                                 //                     shimmerHighlightColor:
//                                 //                         Colors.grey.shade100,
//                                 //                     // shimmerBackColor: randomColor(),
//                                 //                   ),
//                                 //                 ),
//                                 //                 Positioned(
//                                 //                     bottom: 0,
//                                 //                     right: 0,
//                                 //                     child: Icon(
//                                 //                       index % 3 == 1
//                                 //                           ? Icons.timer
//                                 //                           : index % 2 == 1
//                                 //                               ? Icons.check_box
//                                 //                               : Icons
//                                 //                                   .add_box_rounded,
//                                 //                       color: index % 3 == 1
//                                 //                           ? Colors.orange
//                                 //                           : index % 2 == 1
//                                 //                               ? Theme.of(
//                                 //                                       context)
//                                 //                                   .primaryColor
//                                 //                               : Colors.red,
//                                 //                       size: 25,
//                                 //                     ))
//                                 //               ],
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //       ),
//                                 //     ),
//                                 //     SizedBox(
//                                 //       height: height * .01,
//                                 //     ),
//                                 //   ]),
//                                 // ),
//                                 // SizedBox(
//                                 //   height: height * .01,
//                                 //   width: width * .9,
//                                 //   child: Divider(
//                                 //     color: Colors.grey,
//                                 //     height: height * .01,
//                                 //     thickness: 1,
//                                 //   ),
//                                 // ),

//                                 Container(
//                                   height: height * .9,
//                                   // color: Colors.red,
//                                   child: MediaQuery.removePadding(
//                                     context: context,
//                                     removeTop: true,
//                                     child: ListView.separated(
//                                       physics: AlwaysScrollableScrollPhysics(),
//                                       itemCount: auth.FamilyUserMembers.length,
//                                       itemBuilder: (context, index) {
//                                         return Column(
//                                           children: [
//                                             Stack(
//                                               children: [
//                                                 Column(
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                         top: 8.0,
//                                                         bottom: 18.0,
//                                                         left: width * .025,
//                                                         right: width * .025,
//                                                       ),
//                                                       child: GestureDetector(
//                                                         onTap: () async {
//                                                           // Navigator.pushNamed(
//                                                           //     context, PageRoutes.doctorInfo);
//                                                           FocusManager.instance
//                                                               .primaryFocus
//                                                               ?.unfocus();
//                                                           await Future.delayed(
//                                                               Duration(
//                                                                   microseconds:
//                                                                       500));
//                                                         },
//                                                         child: Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             FadedScaleAnimation(
//                                                               ClipRRect(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                   width * .125,
//                                                                 ),
//                                                                 child: auth
//                                                                             .FamilyUserMembers[
//                                                                                 index]
//                                                                             .image ==
//                                                                         ''
//                                                                     ? Image
//                                                                         .asset(
//                                                                         // 'assets/img_orderplaced.png',
//                                                                         'assets/appIcon.png',
//                                                                         height: width *
//                                                                             .25,
//                                                                         width: width *
//                                                                             .25,
//                                                                       )
//                                                                     : Image
//                                                                         .network(
//                                                                         auth.FamilyUserMembers[index]
//                                                                             .image,
//                                                                         height: width *
//                                                                             .25,
//                                                                         width: width *
//                                                                             .25,
//                                                                         fit: BoxFit
//                                                                             .cover,
//                                                                       ),
//                                                               ),
//                                                               durationInMilliseconds:
//                                                                   400,
//                                                             ),
//                                                             Container(
//                                                                 padding: EdgeInsets
//                                                                     .symmetric(
//                                                                         horizontal:
//                                                                             width *
//                                                                                 .05),
//                                                                 width:
//                                                                     width * .6,
//                                                                 child: Column(
//                                                                   crossAxisAlignment:
//                                                                       CrossAxisAlignment
//                                                                           .start,
//                                                                   children: [
//                                                                     AutoSizeText(
//                                                                       auth
//                                                                           .FamilyUserMembers[
//                                                                               index]
//                                                                           .name,
//                                                                       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                                                                           color:
//                                                                               black2,
//                                                                           height:
//                                                                               1.7,
//                                                                           fontSize:
//                                                                               17,
//                                                                           fontWeight:
//                                                                               FontWeight.bold),
//                                                                     ),
//                                                                     AutoSizeText(
//                                                                       auth
//                                                                           .FamilyUserMembers[
//                                                                               index]
//                                                                           .phoneNumber,
//                                                                       style: Theme.of(
//                                                                               context)
//                                                                           .textTheme
//                                                                           .bodyText1!
//                                                                           .copyWith(
//                                                                             color:
//                                                                                 black2,
//                                                                             height:
//                                                                                 1.7,
//                                                                             fontSize:
//                                                                                 13,
//                                                                           ),
//                                                                     ),
//                                                                   ],
//                                                                 )),
//                                                             Container(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 width:
//                                                                     width * .1,
//                                                                 child:
//                                                                     IconButton(
//                                                                   onPressed:
//                                                                       () {
//                                                                     if (auth.FamilyUserMembers[index]
//                                                                             .invitationStatus ==
//                                                                         0) {
//                                                                       if ((auth
//                                                                               .FamilyUserMembers[index]
//                                                                               .phoneNumber !=
//                                                                           auth.theUser!.phoneNumber)) {
//                                                                         print(
//                                                                             "i can send");
//                                                                         showDialog(
//                                                                           context:
//                                                                               context,
//                                                                           barrierDismissible:
//                                                                               false,
//                                                                           builder:
//                                                                               (BuildContext context) {
//                                                                             return AddFamilyMemberDialog(
//                                                                               user: auth.FamilyUserMembers[index],
//                                                                             );
//                                                                           },
//                                                                         );
//                                                                       } else {
//                                                                         print(
//                                                                             "i can't send it's me");
//                                                                       }
//                                                                       //send invite
//                                                                     }
//                                                                   },
//                                                                   icon: Icon(
//                                                                     auth.FamilyUserMembers[index].phoneNumber ==
//                                                                             auth
//                                                                                 .theUser!.phoneNumber
//                                                                         ? Icons
//                                                                             .person
//                                                                         : auth.FamilyUserMembers[index].invitationStatus ==
//                                                                                 0
//                                                                             ? Icons.add_box_rounded
//                                                                             : auth.FamilyUserMembers[index].invitationStatus == 1
//                                                                                 ? Icons.timer
//                                                                                 : Icons.check,
//                                                                     color: auth.FamilyUserMembers[index].invitationStatus ==
//                                                                             0
//                                                                         ? Colors
//                                                                             .red
//                                                                         : auth.FamilyUserMembers[index].invitationStatus ==
//                                                                                 1
//                                                                             ? Colors.orange
//                                                                             : Theme.of(context).primaryColor,
//                                                                     size: 38,
//                                                                   ),
//                                                                 ))
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Divider(
//                                                       height: 6,
//                                                       thickness: 6,
//                                                       color: Theme.of(context)
//                                                           .backgroundColor,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                       separatorBuilder: (context, index) =>
//                                           SizedBox(
//                                         height: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                 ]),
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }
