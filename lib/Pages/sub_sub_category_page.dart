// import 'dart:core';
// import 'dart:math';

// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:m3ak_user/Pages/brand_info_page.dart';
// import 'package:m3ak_user/Pages/sub_category_page.dart';
// import 'package:m3ak_user/data/menu.dart';
// import 'package:provider/provider.dart';
// import '../../../../Locale/locale.dart';
// import '../../../../Routes/routes.dart';
// import '../../../../Theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../Providers/auth.dart';
// import '../Providers/menu_provider.dart';

// class SubSubCategoryPage extends StatefulWidget {
//   final Category? category;
//   final String code;
//   SubSubCategoryPage(this.category, this.code);
//   @override
//   _SubSubCategoryPageState createState() => _SubSubCategoryPageState();
// }

// class _SubSubCategoryPageState extends State<SubSubCategoryPage> {
//   List<SubCategory> subCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     subCategories = widget.category!.subCategories;
//   }

//   final ScrollController _scrollController = ScrollController();
//   bool loading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//   }

//   void search(String value) {
//     List<SubCategory> subCategoriesSearch = [];
//     if (value == '') {
//       setState(() {
//         subCategories = widget.category!.subCategories;
//       });
//     } else {
//       widget.category!.subCategories.forEach((element) {
//         String t2 = element.title!;
//         String s2 = value;
//         print(t2);
//         String nt2 = normalise(t2);
//         print(nt2);
//         print(t2.codeUnits);
//         print(nt2.codeUnits);
//         print(s2);
//         String ns2 = normalise(s2);
//         print(ns2);
//         print(s2.codeUnits);
//         print(ns2.codeUnits);

//         print(nt2.contains(ns2));
//         if (nt2.toLowerCase().contains(ns2)) subCategoriesSearch.add(element);
//       });
//       subCategoriesSearch.sort((a, b) => a.title!.compareTo(b.title!));

//       subCategoriesSearch
//           .sort((a, b) => a.title!.length.compareTo(b.title!.length));

//       setState(() {
//         subCategories = subCategoriesSearch;
//       });
//     }
//   }

//   String normalise(String input) => input
//       .replaceAll('\u0610', '') //ARABIC SIGN SALLALLAHOU ALAYHE WA SALLAM
//       .replaceAll('\u0611', '') //ARABIC SIGN ALAYHE ASSALLAM
//       .replaceAll('\u0612', '') //ARABIC SIGN RAHMATULLAH ALAYHE
//       .replaceAll('\u0613', '') //ARABIC SIGN RADI ALLAHOU ANHU
//       .replaceAll('\u0614', '') //ARABIC SIGN TAKHALLUS

//       //Remove koranic anotation
//       .replaceAll('\u0615', '') //ARABIC SMALL HIGH TAH
//       .replaceAll(
//           '\u0616', '') //ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
//       .replaceAll('\u0617', '') //ARABIC SMALL HIGH ZAIN
//       .replaceAll('\u0618', '') //ARABIC SMALL FATHA
//       .replaceAll('\u0619', '') //ARABIC SMALL DAMMA
//       .replaceAll('\u061A', '') //ARABIC SMALL KASRA
//       .replaceAll('\u06D6',
//           '') //ARABIC SMALL HIGH LIGATURE SAD WITH LAM WITH ALEF MAKSURA
//       .replaceAll('\u06D7',
//           '') //ARABIC SMALL HIGH LIGATURE QAF WITH LAM WITH ALEF MAKSURA
//       .replaceAll('\u06D8', '') //ARABIC SMALL HIGH MEEM INITIAL FORM
//       .replaceAll('\u06D9', '') //ARABIC SMALL HIGH LAM ALEF
//       .replaceAll('\u06DA', '') //ARABIC SMALL HIGH JEEM
//       .replaceAll('\u06DB', '') //ARABIC SMALL HIGH THREE DOTS
//       .replaceAll('\u06DC', '') //ARABIC SMALL HIGH SEEN
//       .replaceAll('\u06DD', '') //ARABIC END OF AYAH
//       .replaceAll('\u06DE', '') //ARABIC START OF RUB EL HIZB
//       .replaceAll('\u06DF', '') //ARABIC SMALL HIGH ROUNDED ZERO
//       .replaceAll('\u06E0', '') //ARABIC SMALL HIGH UPRIGHT RECTANGULAR ZERO
//       .replaceAll('\u06E1', '') //ARABIC SMALL HIGH DOTLESS HEAD OF KHAH
//       .replaceAll('\u06E2', '') //ARABIC SMALL HIGH MEEM ISOLATED FORM
//       .replaceAll('\u06E3', '') //ARABIC SMALL LOW SEEN
//       .replaceAll('\u06E4', '') //ARABIC SMALL HIGH MADDA
//       .replaceAll('\u06E5', '') //ARABIC SMALL WAW
//       .replaceAll('\u06E6', '') //ARABIC SMALL YEH
//       .replaceAll('\u06E7', '') //ARABIC SMALL HIGH YEH
//       .replaceAll('\u06E8', '') //ARABIC SMALL HIGH NOON
//       .replaceAll('\u06E9', '') //ARABIC PLACE OF SAJDAH
//       .replaceAll('\u06EA', '') //ARABIC EMPTY CENTRE LOW STOP
//       .replaceAll('\u06EB', '') //ARABIC EMPTY CENTRE HIGH STOP
//       .replaceAll('\u06EC', '') //ARABIC ROUNDED HIGH STOP WITH FILLED CENTRE
//       .replaceAll('\u06ED', '') //ARABIC SMALL LOW MEEM

//       //Remove tatweel
//       .replaceAll('\u0640', '')

//       //Remove tashkeel
//       .replaceAll('\u064B', '') //ARABIC FATHATAN
//       .replaceAll('\u064C', '') //ARABIC DAMMATAN
//       .replaceAll('\u064D', '') //ARABIC KASRATAN
//       .replaceAll('\u064E', '') //ARABIC FATHA
//       .replaceAll('\u064F', '') //ARABIC DAMMA
//       .replaceAll('\u0650', '') //ARABIC KASRA
//       .replaceAll('\u0651', '') //ARABIC SHADDA
//       .replaceAll('\u0652', '') //ARABIC SUKUN
//       .replaceAll('\u0653', '') //ARABIC MADDAH ABOVE
//       .replaceAll('\u0654', '') //ARABIC HAMZA ABOVE
//       .replaceAll('\u0655', '') //ARABIC HAMZA BELOW
//       .replaceAll('\u0656', '') //ARABIC SUBSCRIPT ALEF
//       .replaceAll('\u0657', '') //ARABIC INVERTED DAMMA
//       .replaceAll('\u0658', '') //ARABIC MARK NOON GHUNNA
//       .replaceAll('\u0659', '') //ARABIC ZWARAKAY
//       .replaceAll('\u065A', '') //ARABIC VOWEL SIGN SMALL V ABOVE
//       .replaceAll('\u065B', '') //ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
//       .replaceAll('\u065C', '') //ARABIC VOWEL SIGN DOT BELOW
//       .replaceAll('\u065D', '') //ARABIC REVERSED DAMMA
//       .replaceAll('\u065E', '') //ARABIC FATHA WITH TWO DOTS
//       .replaceAll('\u065F', '') //ARABIC WAVY HAMZA BELOW
//       .replaceAll('\u0670', '') //ARABIC LETTER SUPERSCRIPT ALEF

//       //Replace Waw Hamza Above by Waw
//       .replaceAll('\u0624', '\u0648')

//       //Replace Ta Marbuta by Ha
//       .replaceAll('\u0629', '\u0647')

//       //Replace Ya
//       // and Ya Hamza Above by Alif Maksura
//       .replaceAll('\u064A', '\u0649')
//       .replaceAll('\u0626', '\u0649')

//       // Replace Alifs with Hamza Above/Below
//       // and with Madda Above by Alif
//       .replaceAll('\u0622', '\u0627')
//       .replaceAll('\u0623', '\u0627')
//       .replaceAll('\u0625', '\u0627');
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
//       body: SingleChildScrollView(
//         child: FadedSlideAnimation(
//           Column(
//             children: [
//               Container(
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
//                   cursorColor: Theme.of(context).primaryColor,

//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(fontSize: 14.5),
//                   // initialValue: '',
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none),
//                     hintText: locale.search! + " " + (widget.category!.title!),
//                     filled: true,
//                     fillColor: Theme.of(context).backgroundColor,
//                     prefixIcon: IconButton(
//                         onPressed: () {
//                           FocusManager.instance.primaryFocus?.unfocus();

//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: Theme.of(context).primaryColor,
//                           size: 20,
//                         )),
//                     suffixIcon: Icon(
//                       Icons.search,
//                       color: Theme.of(context).primaryColor,
//                     ),
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
//               menu.loading
//                   ? Container(
//                       height: height,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircularProgressIndicator(
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     )
//                   : Container(
//                       height: height * .9,
//                       // color: Colors.red,
//                       child: MediaQuery.removePadding(
//                         context: context,
//                         removeTop: true,
//                         child: ListView.separated(
//                           controller: _scrollController,
//                           // padding: EdgeInsets.only(top: 35.h, left: 16.w, right: 16.w),
//                           physics: BouncingScrollPhysics(),
//                           itemCount: subCategories.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 Container(
//                                   // color: Colors.red,
//                                   padding: EdgeInsets.only(
//                                     top: 20.0,
//                                     bottom: 20.0,
//                                     left: width * .025,
//                                     right: width * .025,
//                                   ),
//                                   child: GestureDetector(
//                                     onTap: () async {
//                                       // Navigator.pushNamed(
//                                       //     context, PageRoutes.doctorInfo);
//                                       FocusManager.instance.primaryFocus
//                                           ?.unfocus();
//                                       await Future.delayed(
//                                           Duration(microseconds: 500));

//                                       await Navigator.push<void>(
//                                         context,
//                                         MaterialPageRoute<void>(
//                                           builder: (BuildContext context) =>
//                                               SubCategoryPage(
//                                             widget.category,
//                                             locale.locale.languageCode,
//                                             true,
//                                             subCategories[index].id,
//                                             subCategories[index].title!,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           // color: Colors.red,
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: width * .05),
//                                           width: width * .8,
//                                           child: Text(
//                                               subCategories[index].title!,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1!
//                                                   .copyWith(
//                                                       color: black2,
//                                                       height: 1.7,
//                                                       fontSize: 17,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                         ),
//                                         Container(
//                                           // color: Colors.red,
//                                           // padding: EdgeInsets.symmetric(
//                                           //     horizontal: width * .01),
//                                           width: width * .1,
//                                           alignment: Alignment.center,
//                                           child: Icon(
//                                             Icons.arrow_forward_ios,
//                                             color: Colors.grey,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(
//                                   height: 1,
//                                   thickness: 1,
//                                   color: Colors.grey[300],
//                                 ),
//                               ],
//                             );
//                           },
//                           separatorBuilder: (context, index) => SizedBox(
//                             height: 1,
//                           ),
//                         ),
//                       ),
//                     ),
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
