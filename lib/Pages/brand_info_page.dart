import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Pages/offer_detail.dart';
import 'package:m3ak_user/Pages/order_first_page.dart';
import 'package:m3ak_user/data/menu.dart';
import 'package:m3ak_user/widgets/branch_card.dart';
import 'package:provider/provider.dart';

import '../Components/custom_button.dart';
import '../Components/title_row.dart';
import '../Locale/locale.dart';
import '../Providers/auth.dart';
import '../Providers/menu_provider.dart';
import '../Routes/routes.dart';
import '../Theme/colors.dart';
import '../data/brands_by_category.dart';

class BrandInfoPage extends StatefulWidget {
  final String code;
  final Brand brand;
  const BrandInfoPage({Key? key, required this.brand, required this.code})
      : super(key: key);

  @override
  State<BrandInfoPage> createState() => _BrandInfoPageState();
}

class _BrandInfoPageState extends State<BrandInfoPage> {
  @override
  void initState() {
    super.initState();
    final menu = Provider.of<MenuProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    // menu.getBranchesByBrandsIdFirstTime(
    //     auth.theUser!.token, widget.brand.id!, widget.code);
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      print(_scrollController.position.maxScrollExtent);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        print("new data called");
        fetchData();
      }
    });
  }

  final ScrollController _scrollController = ScrollController();
  bool loading = false;

  Future<void> fetchData() async {
    print("fitching data from brand info");

    setState(() {
      loading = true;
    });
    // if()
    final menu = Provider.of<MenuProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    // await menu.getBranchesByBrandsId(
    //     auth.theUser!.token, widget.brand.id!, widget.code);
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final notch = MediaQuery.of(context).padding.top;
    final height = MediaQuery.of(context).size.height - notch;
    final menu = Provider.of<MenuProvider>(context, listen: true);
    bool canOrder = menu.brandBranches.isEmpty || menu.loading
        ? false
        : menu.brandBranches[0].availableOrder;
    bool haveOffers = false;
    print(widget.brand.id);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
      body: FadedSlideAnimation(
        Column(
          children: [
            SizedBox(
              height: notch,
            ),
            Container(
                // color: Colors.red,
                alignment: Alignment.center,
                height: height * .07,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: width * .1,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                    ),
                    Container(
                      width: width * .8,
                      height: height * .07,
                      // color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text(widget.brand.name!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: black2,
                                  )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width * .1,
                      // child: IconButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     icon: Icon(Icons.delivery_dining)),
                    ),
                  ],
                )),
            Container(
              height: height * .9,
              color: Theme.of(context).backgroundColor,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  controller: _scrollController,
                  // physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      // height: height * .29,
                      // color: Theme.of(context).scaffoldBackgroundColor,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: canOrder
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .05),
                                    child: FadedScaleAnimation(
                                      SizedBox(
                                        width: width * .3,
                                        height: height * .1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: FadedScaleAnimation(
                                            widget.brand.image == ""
                                                ? Image.asset(
                                                    'assets/hero_image.png',
                                                    scale: 3.5,
                                                    fit: BoxFit.contain,
                                                  )
                                                : FancyShimmerImage(
                                                    imageUrl:
                                                        widget.brand.image!,
                                                    // height: 40,
                                                    // width: 40,

                                                    boxFit: BoxFit.cover,
                                                    shimmerBaseColor:
                                                        Colors.grey.shade400,
                                                    shimmerHighlightColor:
                                                        Colors.grey.shade100,
                                                    // shimmerBackColor: randomColor(),
                                                  ),
                                            durationInMilliseconds: 400,
                                          ),
                                        ),
                                      ),
                                      durationInMilliseconds: 400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width * .4,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * .01),
                                    child: AutoSizeText(
                                      widget.brand.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: black2,
                                              height: 1.2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              !canOrder
                                  ? Container()
                                  : DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .01,
                                          vertical: height * .01),
                                      dashPattern: [1, 0, 2, 0, 1],
                                      strokeCap: StrokeCap.butt,
                                      color: Theme.of(context).primaryColor,
                                      strokeWidth: 1.5,
                                      child: Container(
                                        width: width * .5,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * .05),
                                        decoration: BoxDecoration(
                                            // color: Colors.lightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // color: Colors.red,
                                                // height: height * .05,
                                                alignment: Alignment.center,
                                                width: width * .55,
                                                child: AutoSizeText(
                                                  locale.add_order_image!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                  // maxLines: 1,
                                                  // minFontSize: 15,
                                                  // maxFontSize: 30,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * .005,
                                              ),
                                              SizedBox(
                                                width: width * .55,
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Theme
                                                                    .of(context)
                                                                .primaryColor),
                                                    shape: MaterialStateProperty.all<
                                                            OutlinedBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13))),
                                                  ),

                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      AutoSizeText(
                                                        locale.order_now!,
                                                        // "اطلب الآن",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                          Icons
                                                              .arrow_forward_ios_sharp,
                                                          color: Colors.white)
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    menu.clearselectedBranchToOrder();
                                                    if (menu.brandBranches[0]
                                                            .callCenter ==
                                                        1) {
                                                      menu.selectCallCenterBranchToOrder(
                                                          menu.brandBranches[
                                                              0]);
                                                    } else {
                                                      menu.clearselectedCallCenterBranchToOrder();
                                                    }
                                                    Navigator.push<void>(
                                                      context,
                                                      MaterialPageRoute<void>(
                                                        builder: (BuildContext
                                                                context) =>
                                                            OrderFirstPage(
                                                                widget.brand),
                                                      ),
                                                    );
                                                  },
                                                  // textColor: Colors.black,c
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                            ],
                          ),
                          Container(
                            // height: height * .19,
                            // alignment: Alignment.center,
                            padding:
                                EdgeInsets.symmetric(horizontal: width * .05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text(widget.brand.name!,
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(
                                //             fontSize: 22,
                                //             fontWeight: FontWeight.bold,
                                //             color: black2,
                                //             height: 1.2)),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Text(widget.brand.description!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Color(0xffb3b3b3),
                                          fontSize: 13.3,
                                        )),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    !haveOffers
                        ? Container()
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 20, bottom: 10, right: 20),
                                child: Text(locale.offers!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Color(0xffb3b3b3),
                                          fontSize: 20,
                                        )),
                              ),
                              Container(
                                height: 108,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: menu.highlightsOffers.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsetsDirectional.only(end: 20),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      OfferDetail(
                                                          image: menu
                                                              .highlightsOffers[
                                                                  index]
                                                              .image!),
                                                ),
                                              );
                                            },
                                            child: FadedScaleAnimation(
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FancyShimmerImage(
                                                  imageUrl: menu
                                                      .highlightsOffers[index]
                                                      .image!,
                                                  boxFit: BoxFit.cover,
                                                ),
                                              ),
                                              // Image.network(
                                              //     menu.highlightsOffers[index].image!,
                                              //     fit: BoxFit.fill),
                                              durationInMilliseconds: 300,
                                            )),
                                      );
                                    }),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: height * .01,
                    ),
                    // Container(
                    //   height: height * .13,
                    //   decoration: BoxDecoration(
                    //       color: Colors.blue,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   margin: EdgeInsets.symmetric(horizontal: width * .05),
                    //   // padding: EdgeInsets.symmetric(vertical: 10),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: width * .65,
                    //         padding:
                    //             EdgeInsets.symmetric(horizontal: width * .05),
                    //         decoration: BoxDecoration(
                    //             // color: Colors.lightBlue,
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container(
                    //                 // color: Colors.red,
                    //                 // height: height * .05,
                    //                 width: width * .55,
                    //                 child: AutoSizeText(
                    //                   locale.add_order_image!,
                    //                   style: TextStyle(
                    //                       color: Colors.white, fontSize: 20),
                    //                   // maxLines: 1,
                    //                   // minFontSize: 15,
                    //                   // maxFontSize: 30,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: height * .005,
                    //               ),
                    //               SizedBox(
                    //                 width: width * .3,
                    //                 child: TextButton(
                    //                   style: ButtonStyle(
                    //                     backgroundColor:
                    //                         MaterialStateProperty.all<Color>(
                    //                             Colors.white),
                    //                     shape: MaterialStateProperty.all<
                    //                             OutlinedBorder>(
                    //                         RoundedRectangleBorder(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(13))),
                    //                   ),

                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceAround,
                    //                     children: [
                    //                       AutoSizeText(
                    //                         locale.order_now!,
                    //                         // "اطلب الآن",
                    //                         style:
                    //                             TextStyle(color: Colors.black),
                    //                       ),
                    //                       Icon(Icons.arrow_forward_ios_sharp,
                    //                           color: Colors.black)
                    //                     ],
                    //                   ),
                    //                   onPressed: () {
                    //                     Navigator.push<void>(
                    //                       context,
                    //                       MaterialPageRoute<void>(
                    //                         builder: (BuildContext context) =>
                    //                             OrderFirstPage(),
                    //                       ),
                    //                     );
                    //                   },
                    //                   // textColor: Colors.black,c
                    //                 ),
                    //               )
                    //             ]),
                    //       ),
                    //       Container(
                    //         height: height * .13,
                    //         width: width * .25,
                    //         decoration: BoxDecoration(
                    //             color: Color(0xff56C8E2),
                    //             borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(
                    //                   locale.locale.languageCode == "en"
                    //                       ? 10
                    //                       : 20),
                    //               topLeft: Radius.circular(
                    //                   locale.locale.languageCode == "en"
                    //                       ? 20
                    //                       : 10),
                    //               bottomLeft: Radius.circular(10),
                    //               bottomRight: Radius.circular(10),
                    //             )),
                    //         child: Image.asset(
                    //           "assets/SellerImages/2.png",
                    //           fit: BoxFit.contain,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: height * .01,
                    // ),
                    Container(
                      // height: heig ht * .19,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.only(
                          top: 10, left: 20, bottom: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locale.services!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xffb3b3b3),
                                    fontSize: 20,
                                  )),
                          SizedBox(
                            height: 10,
                          ),
                          menu.loading
                              ? Container(
                                  // height: height * .4,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Column(
                                  children: menu.brandServices
                                      .map(
                                        (e) => ListTile(
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(e.serviceTitle,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: black2,
                                                    fontSize: 15,
                                                  )),
                                          // subtitle: Text(e.discount,
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText1!
                                          //         .copyWith(
                                          //           color: Color(0xff808080),
                                          //           fontSize: 13.5,
                                          //         )),
                                          trailing: Text(e.discount + " % ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: black2,
                                                    fontSize: 15,
                                                  )),
                                        ),
                                      )
                                      .toList(),
                                ),

                          // ListTile(
                          //   dense: true,
                          //   contentPadding: EdgeInsets.zero,
                          //   title: Text('Seven Star Clinic',
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .bodyText1!
                          //           .copyWith(
                          //             color: black2,
                          //             fontSize: 15,
                          //           )),
                          //   subtitle: Text(
                          //       'Hemilton Bridge City Point, Hemilton',
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .bodyText1!
                          //           .copyWith(
                          //             color: Color(0xff808080),
                          //             fontSize: 13.5,
                          //           )),
                          //   trailing: Icon(
                          //     Icons.arrow_forward_ios,
                          //     size: 15,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Container(
                      // height: height * .4,
                      // color: Colors.red,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.only(
                          top: 10,
                          left: width * .05,
                          bottom: 0,
                          right: width * .05),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(locale.branches!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xffb3b3b3),
                                    fontSize: 20,
                                  )),
                          SizedBox(
                            height: 10,
                          ),
                          menu.loading
                              ? Container(
                                  // height: height * .4,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Container(
                                  // height: height * .4,
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      // controller: _scrollController,
                                      // padding: EdgeInsets.only(top: 35.h, left: 16.w, right: 16.w),
                                      physics: BouncingScrollPhysics(),
                                      itemCount: menu.brandBranches.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            BranchCard(
                                                brand: widget.brand,
                                                branch:
                                                    menu.brandBranches[index]),
                                            loading &&
                                                    menu.brandBranches.length ==
                                                        index + 1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18.0),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  )
                                                : Text('')
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
