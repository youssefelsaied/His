// import 'dart:core';
// import 'dart:math';

// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:m3ak_user/Pages/brand_info_page.dart';
// import 'package:m3ak_user/data/menu.dart';
// import 'package:provider/provider.dart';
// import '../../../../Locale/locale.dart';
// import '../../../../Routes/routes.dart';
// import '../../../../Theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../Providers/auth.dart';
// import '../Providers/menu_provider.dart';
// import '../data/brands_by_category.dart';

// class SubCategoryPage extends StatefulWidget {
//   final Category? category;
//   final int? subCategoryId;
//   final String code;
//   final bool fromSubSub;
//   final String subCategoryTitle;
//   SubCategoryPage(this.category, this.code, this.fromSubSub, this.subCategoryId,
//       this.subCategoryTitle);
//   @override
//   _SubCategoryPageState createState() => _SubCategoryPageState();
// }

// class _SubCategoryPageState extends State<SubCategoryPage> {
//   @override
//   void initState() {
//     super.initState();
//     final menu = Provider.of<MenuProvider>(context, listen: false);
//     final auth = Provider.of<Auth>(context, listen: false);
//     if (widget.fromSubSub) {
//       menu.getBrandsBySubCategoryIdFirstTime(
//           auth.theUser!.token, widget.subCategoryId!, widget.code);
//     } else {
//       menu.getBrandsByCategoryIdFirstTime(
//           auth.theUser!.token, widget.category!.id!, widget.code);
//     }
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//               _scrollController.position.maxScrollExtent &&
//           !loading) {
//         print("new data called");
//         fetchData();
//       }
//     });
//   }

//   final ScrollController _scrollController = ScrollController();
//   bool loading = false;
//   // List<Brand> selectedBrands = [];

//   Future<void> fetchData() async {
//     setState(() {
//       loading = true;
//     });
//     final menu = Provider.of<MenuProvider>(context, listen: false);
//     final auth = Provider.of<Auth>(context, listen: false);
//     if (widget.fromSubSub) {
//       await menu.getBrandsBySubCategoryId(
//           auth.theUser!.token, widget.subCategoryId!, widget.code);
//     } else {
//       await menu.getBrandsByCategoryId(
//           auth.theUser!.token, widget.category!.id!, widget.code);
//     }
//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//   }

//   bool showSearch = false;
//   void search(String value) {
//     var locale = AppLocalizations.of(context)!;

//     if (value == '') {
//       ScaffoldMessenger.of(context).clearSnackBars();

//       setState(() {
//         showSearch = false;
//       });
//     } else {
//       if (value.length < 3) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(locale.please_enter_3_chars_at_least_to_search!)));
//         setState(() {
//           showSearch = false;
//         });
//       } else {
//         ScaffoldMessenger.of(context).clearSnackBars();

//         final auth = Provider.of<Auth>(context, listen: false);
//         final menu = Provider.of<MenuProvider>(context, listen: false);
//         menu.searchBrandsbyName(
//             auth.theUser!.token!, value, widget.category!.id);
//         setState(() {
//           showSearch = true;
//         });
//       }
//     }
//   }

//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final notch = MediaQuery.of(context).padding.top;

//     final height = MediaQuery.of(context).size.height - notch;
//     var locale = AppLocalizations.of(context)!;
//     final menu = Provider.of<MenuProvider>(context, listen: true);
//     final auth = Provider.of<Auth>(context, listen: true);

//     return Scaffold(
//       // appBar: PreferredSize(
//       //     child: Padding(
//       //       padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
//       //       child: TextFormField(
//       //         style: Theme.of(context)
//       //             .textTheme
//       //             .bodyText1!
//       //             .copyWith(fontSize: 14.5),
//       //         initialValue: 'Surgeon',
//       //         decoration: InputDecoration(
//       //             border: OutlineInputBorder(
//       //                 borderRadius: BorderRadius.circular(8),
//       //                 borderSide: BorderSide.none),
//       //             hintText: locale.searchDoc,
//       //             filled: true,
//       //             fillColor: Theme.of(context).backgroundColor,
//       //             prefixIcon: IconButton(
//       //                 onPressed: () {
//       //                   Navigator.pop(context);
//       //                 },
//       //                 icon: Icon(
//       //                   Icons.arrow_back_ios,
//       //                   size: 20,
//       //                 )),
//       //             suffixIcon: IconButton(
//       //               icon: Icon(Icons.search),
//       //               onPressed: () {
//       //                 Navigator.pushNamed(
//       //                     context, PageRoutes.searchHistoryPage);
//       //               },
//       //             )),
//       //       ),
//       //     ),
//       //     preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top)),
//       body: SingleChildScrollView(
//         child: FadedSlideAnimation(
//           Column(
//             // physics: BouncingScrollPhysics(),
//             // shrinkWrap: true,
//             children: [
//               Container(
//                 // color: Colors.red,
//                 height: notch,
//                 child: InkWell(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                   },
//                 ),
//               ),
//               Container(
//                 height: height * .1,
//                 padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
//                 child: TextFormField(
//                   controller: _controller,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(fontSize: 14.5),
//                   // initialValue: '',
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none),
//                     hintText: locale.search! +
//                         " " +
//                         (widget.fromSubSub
//                             ? widget.subCategoryTitle
//                             : widget.category!.title!),
//                     filled: true,
//                     fillColor: Theme.of(context).backgroundColor,
//                     prefixIcon: IconButton(
//                         onPressed: () {
//                           FocusManager.instance.primaryFocus?.unfocus();

//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           size: 20,
//                         )),
//                     suffixIcon: Icon(Icons.search),
//                   ),
//                   onChanged: (v) {
//                     if (v.isEmpty) {
//                       search(v);
//                     }
//                   },
//                   onEditingComplete: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                     search(_controller.text);
//                   },
//                 ),
//               ),
//               !showSearch
//                   ? menu.loading
//                       ? Container(
//                           height: height * .9,
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircularProgressIndicator(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         )
//                       : menu.categoryBrands.isEmpty
//                           ? Container(
//                               height: height * .9,
//                               child: Center(
//                                 child: Column(children: [
//                                   Spacer(
//                                     flex: 8,
//                                   ),
//                                   Icon(
//                                     Icons.business_outlined,
//                                     size: 100,
//                                     color: Colors.grey,
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     locale.no_brands!,
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
//                           : Container(
//                               height: height * .9,
//                               // color: Colors.red,
//                               child: MediaQuery.removePadding(
//                                 context: context,
//                                 removeTop: true,
//                                 child: ListView.separated(
//                                   controller: _scrollController,
//                                   // padding: EdgeInsets.only(top: 35.h, left: 16.w, right: 16.w),
//                                   physics: BouncingScrollPhysics(),
//                                   itemCount: menu.categoryBrands.length,
//                                   itemBuilder: (context, index) {
//                                     return Column(
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     top: 8.0,
//                                                     bottom: 18.0,
//                                                     left: width * .025,
//                                                     right: width * .025,
//                                                   ),
//                                                   child: GestureDetector(
//                                                     onTap: () async {
//                                                       // Navigator.pushNamed(
//                                                       //     context, PageRoutes.doctorInfo);
//                                                       FocusManager
//                                                           .instance.primaryFocus
//                                                           ?.unfocus();
//                                                       await Future.delayed(
//                                                           Duration(
//                                                               microseconds:
//                                                                   500));

//                                                       await Navigator.push<
//                                                           void>(
//                                                         context,
//                                                         MaterialPageRoute<void>(
//                                                           builder: (BuildContext
//                                                                   context) =>
//                                                               BrandInfoPage(
//                                                             brand:
//                                                                 menu.categoryBrands[
//                                                                     index],
//                                                             code: widget.code,
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         FadedScaleAnimation(
//                                                           menu.categoryBrands[index]
//                                                                       .image ==
//                                                                   ''
//                                                               ? Image.asset(
//                                                                   // 'assets/img_orderplaced.png',
//                                                                   'assets/SellerImages/1a.png',
//                                                                   height:
//                                                                       width *
//                                                                           .25,
//                                                                   width: width *
//                                                                       .25,
//                                                                 )
//                                                               : Image.network(
//                                                                   menu
//                                                                       .categoryBrands[
//                                                                           index]
//                                                                       .image!,
//                                                                   height:
//                                                                       width *
//                                                                           .25,
//                                                                   width: width *
//                                                                       .25,
//                                                                 ),
//                                                           durationInMilliseconds:
//                                                               400,
//                                                         ),
//                                                         Container(
//                                                           padding: EdgeInsets
//                                                               .symmetric(
//                                                                   horizontal:
//                                                                       width *
//                                                                           .1),
//                                                           width: width * .7,
//                                                           child: RichText(
//                                                               text: TextSpan(
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .subtitle2,
//                                                                   children: <
//                                                                       TextSpan>[
//                                                                 TextSpan(
//                                                                     text: menu
//                                                                             .categoryBrands[
//                                                                                 index]
//                                                                             .name! +
//                                                                         '\n',
//                                                                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                                                                         color:
//                                                                             black2,
//                                                                         height:
//                                                                             1.7,
//                                                                         fontSize:
//                                                                             17,
//                                                                         fontWeight:
//                                                                             FontWeight.bold)),
//                                                                 // TextSpan(
//                                                                 //     text: "  serviceTitle",
//                                                                 //     style: Theme.of(context)
//                                                                 //         .textTheme
//                                                                 //         .bodyText1!
//                                                                 //         .copyWith(
//                                                                 //           fontSize: 11.2,
//                                                                 //           color:
//                                                                 //               Color(0xff999999),
//                                                                 //         )),
//                                                                 // TextSpan(
//                                                                 //     text: locale.at,
//                                                                 //     style: Theme.of(context)
//                                                                 //         .textTheme
//                                                                 //         .bodyText1!
//                                                                 //         .copyWith(
//                                                                 //           fontSize: 11.2,
//                                                                 //           color:
//                                                                 //               Color(0xffcccccc),
//                                                                 //         )),
//                                                                 // TextSpan(
//                                                                 //     text: "hospital",
//                                                                 //     style: Theme.of(context)
//                                                                 //         .textTheme
//                                                                 //         .bodyText1!
//                                                                 //         .copyWith(
//                                                                 //           fontSize: 11.2,
//                                                                 //           color:
//                                                                 //               Color(0xff999999),
//                                                                 //         )),
//                                                               ])),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Divider(
//                                                   height: 6,
//                                                   thickness: 6,
//                                                   color: Theme.of(context)
//                                                       .backgroundColor,
//                                                 ),
//                                               ],
//                                             ),
//                                             PositionedDirectional(
//                                               // bottom: 28,
//                                               top: 22,
//                                               end: 5,
//                                               child: Row(
//                                                 children: [
//                                                   IconButton(
//                                                     onPressed: () async {
//                                                       setState(() {
//                                                         menu
//                                                                 .categoryBrands[
//                                                                     index]
//                                                                 .isFavourite =
//                                                             !menu
//                                                                 .categoryBrands[
//                                                                     index]
//                                                                 .isFavourite!;
//                                                       });
//                                                       final res = await menu
//                                                           .favouriteBrand(
//                                                               auth.theUser!
//                                                                   .token,
//                                                               menu
//                                                                   .categoryBrands[
//                                                                       index]
//                                                                   .id);
//                                                       if (!res) {
//                                                         setState(() {
//                                                           menu
//                                                                   .categoryBrands[
//                                                                       index]
//                                                                   .isFavourite =
//                                                               !menu
//                                                                   .categoryBrands[
//                                                                       index]
//                                                                   .isFavourite!;
//                                                         });
//                                                       }
//                                                     },
//                                                     icon: Icon(
//                                                       menu.categoryBrands[index]
//                                                               .isFavourite!
//                                                           ? Icons.favorite
//                                                           : Icons
//                                                               .favorite_outline,
//                                                       color: menu
//                                                               .categoryBrands[
//                                                                   index]
//                                                               .isFavourite!
//                                                           ? Colors.red
//                                                           : Colors.grey,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         loading &&
//                                                 menu.categoryBrands.length ==
//                                                     index + 1
//                                             ? Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   color: Theme.of(context)
//                                                       .primaryColor,
//                                                 ),
//                                               )
//                                             : Text('')
//                                       ],
//                                     );
//                                   },
//                                   separatorBuilder: (context, index) =>
//                                       SizedBox(
//                                     height: 16,
//                                   ),
//                                 ),
//                               ),
//                             )
//                   : menu.loading
//                       ? Container(
//                           height: height * .9,
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircularProgressIndicator(
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         )
//                       : menu.searchBrands.isEmpty
//                           ? Container(
//                               height: height * .9,
//                               child: Center(
//                                 child: Column(children: [
//                                   Spacer(
//                                     flex: 8,
//                                   ),
//                                   Icon(
//                                     Icons.business_outlined,
//                                     size: 100,
//                                     color: Colors.grey,
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     locale.no_brands!,
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
//                           : Container(
//                               height: height * .9,
//                               // color: Colors.red,
//                               child: MediaQuery.removePadding(
//                                 context: context,
//                                 removeTop: true,
//                                 child: ListView.separated(
//                                   controller: _scrollController,
//                                   // padding: EdgeInsets.only(top: 35.h, left: 16.w, right: 16.w),
//                                   physics: BouncingScrollPhysics(),
//                                   itemCount: menu.searchBrands.length,
//                                   itemBuilder: (context, index) {
//                                     return Column(
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                     top: 8.0,
//                                                     bottom: 18.0,
//                                                     left: width * .025,
//                                                     right: width * .025,
//                                                   ),
//                                                   child: GestureDetector(
//                                                     onTap: () async {
//                                                       // Navigator.pushNamed(
//                                                       //     context, PageRoutes.doctorInfo);
//                                                       FocusManager
//                                                           .instance.primaryFocus
//                                                           ?.unfocus();
//                                                       await Future.delayed(
//                                                           Duration(
//                                                               microseconds:
//                                                                   500));

//                                                       await Navigator.push<
//                                                           void>(
//                                                         context,
//                                                         MaterialPageRoute<void>(
//                                                           builder: (BuildContext
//                                                                   context) =>
//                                                               BrandInfoPage(
//                                                             brand:
//                                                                 menu.searchBrands[
//                                                                     index],
//                                                             code: widget.code,
//                                                           ),
//                                                         ),
//                                                       );
//                                                     },
//                                                     child: Row(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         FadedScaleAnimation(
//                                                           menu.searchBrands[index]
//                                                                       .image ==
//                                                                   ''
//                                                               ? Image.asset(
//                                                                   // 'assets/img_orderplaced.png',
//                                                                   'assets/SellerImages/1a.png',
//                                                                   height:
//                                                                       width *
//                                                                           .25,
//                                                                   width: width *
//                                                                       .25,
//                                                                 )
//                                                               : Image.network(
//                                                                   menu
//                                                                       .searchBrands[
//                                                                           index]
//                                                                       .image!,
//                                                                   height:
//                                                                       width *
//                                                                           .25,
//                                                                   width: width *
//                                                                       .25,
//                                                                 ),
//                                                           durationInMilliseconds:
//                                                               400,
//                                                         ),
//                                                         Container(
//                                                           padding: EdgeInsets
//                                                               .symmetric(
//                                                                   horizontal:
//                                                                       width *
//                                                                           .05),
//                                                           width: width * .7,
//                                                           child: RichText(
//                                                               text: TextSpan(
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .subtitle2,
//                                                                   children: <
//                                                                       TextSpan>[
//                                                                 TextSpan(
//                                                                     text: menu
//                                                                             .searchBrands[
//                                                                                 index]
//                                                                             .name! +
//                                                                         '\n',
//                                                                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                                                                         color:
//                                                                             black2,
//                                                                         height:
//                                                                             1.7,
//                                                                         fontSize:
//                                                                             17,
//                                                                         fontWeight:
//                                                                             FontWeight.bold)),
//                                                                 // TextSpan(
//                                                                 //     text: "  serviceTitle",
//                                                                 //     style: Theme.of(context)
//                                                                 //         .textTheme
//                                                                 //         .bodyText1!
//                                                                 //         .copyWith(
//                                                                 //           fontSize: 11.2,
//                                                                 //           color:
//                                                                 //               Color(0xff999999),
//                                                                 //         )),
//                                                                 // TextSpan(
//                                                                 //     text: locale.at,
//                                                                 //     style: Theme.of(context)
//                                                                 //         .textTheme
//                                                                 //         .bodyText1!
//                                                                 //         .copyWith(
//                                                                 //           fontSize: 11.2,
//                                                                 //           color:
//                                                                 //               Color(0xffcccccc),
//                                                                 //         )),
//                                                                 // TextSpan(
//                                                                 //     text: "hospital",
//                                                                 //     style: Theme.of(context)
//                                                                 //         .textTheme
//                                                                 //         .bodyText1!
//                                                                 //         .copyWith(
//                                                                 //           fontSize: 11.2,
//                                                                 //           color:
//                                                                 //               Color(0xff999999),
//                                                                 //         )),
//                                                               ])),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Divider(
//                                                   height: 6,
//                                                   thickness: 6,
//                                                   color: Theme.of(context)
//                                                       .backgroundColor,
//                                                 ),
//                                               ],
//                                             ),
//                                             PositionedDirectional(
//                                               // bottom: 28,
//                                               top: 22,
//                                               end: 10,
//                                               child: Row(
//                                                 children: [
//                                                   IconButton(
//                                                     onPressed: () async {
//                                                       setState(() {
//                                                         menu.searchBrands[index]
//                                                                 .isFavourite =
//                                                             !menu
//                                                                 .searchBrands[
//                                                                     index]
//                                                                 .isFavourite!;
//                                                       });
//                                                       final res = await menu
//                                                           .favouriteBrand(
//                                                               auth.theUser!
//                                                                   .token,
//                                                               menu
//                                                                   .searchBrands[
//                                                                       index]
//                                                                   .id);
//                                                       if (!res) {
//                                                         setState(() {
//                                                           menu
//                                                                   .searchBrands[
//                                                                       index]
//                                                                   .isFavourite =
//                                                               !menu
//                                                                   .searchBrands[
//                                                                       index]
//                                                                   .isFavourite!;
//                                                         });
//                                                       }
//                                                     },
//                                                     icon: Icon(
//                                                       menu.searchBrands[index]
//                                                               .isFavourite!
//                                                           ? Icons.favorite
//                                                           : Icons
//                                                               .favorite_outline,
//                                                       color: menu
//                                                               .searchBrands[
//                                                                   index]
//                                                               .isFavourite!
//                                                           ? Colors.red
//                                                           : Colors.grey,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         loading &&
//                                                 menu.searchBrands.length ==
//                                                     index + 1
//                                             ? Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   color: Theme.of(context)
//                                                       .primaryColor,
//                                                 ),
//                                               )
//                                             : Text('')
//                                       ],
//                                     );
//                                   },
//                                   separatorBuilder: (context, index) =>
//                                       SizedBox(
//                                     height: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//             ],
//           ),
//           beginOffset: Offset(0, 0.3),
//           endOffset: Offset(0, 0),
//           slideCurve: Curves.linearToEaseOut,
//         ),
//       ),
//     );
//   }
// }
