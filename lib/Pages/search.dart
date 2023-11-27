// import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Components/entry_field.dart';
// import '../Locale/locale.dart';
// import '../Providers/auth.dart';
// import '../Providers/menu_provider.dart';
// import '../Theme/colors.dart';
// import 'brand_info_page.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController _controller = TextEditingController();
//   @override
//   void initState() {
//     final menu = Provider.of<MenuProvider>(context, listen: false);
//     menu.searchBrands = [];

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
//         menu.clearSearchBrands();
//       });
//     } else {
//       if (value.length < 3) {
//         menu.clearSearchBrands();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(locale.please_enter_3_chars_at_least_to_search!)));
//         setState(() {
//           showSearch = false;
//         });
//       } else {
//         ScaffoldMessenger.of(context).clearSnackBars();
//         menu.searchBrandsbyNameNoCatId(auth.theUser!.token!, value);
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
//                         controller: _controller,
//                         keyboardType: TextInputType.text,
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
//                         // onChanged: (v) {
//                         //   search(v);
//                         // },

//                         onEditingComplete: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           search(_controller.text);
//                         },
//                       ),
//                     ),
//                     durationInMilliseconds: 300,
//                   ),
//                   menu.loading
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
//                                   // controller: _scrollController,
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
//                                                             code: locale.locale
//                                                                 .languageCode,
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
//                                                                           .09),
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
//                                         // loading &&
//                                         //         menu.searchBrands.length ==
//                                         //             index + 1
//                                         //     ? Padding(
//                                         //         padding:
//                                         //             const EdgeInsets.all(8.0),
//                                         //         child:
//                                         //             CircularProgressIndicator(
//                                         //           color: Theme.of(context)
//                                         //               .primaryColor,
//                                         //         ),
//                                         //       )
//                                         //     : Text('')
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
//                 ]),
//               ),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }
