import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:m3ak_user/BottomNavigation/More/MarketPlace/market_cart_widget.dart';
import 'package:m3ak_user/data/market_home.dart' as mh;
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Providers/menu_provider.dart';

class ProductInfo extends StatefulWidget {
  mh.Item item;
  ProductInfo(this.item);
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  IconData saved = Icons.bookmark_border;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var menuProvider = Provider.of<MenuProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [MarketCartWidget()],
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    FadedScaleAnimation(
                      widget.item.images.isEmpty
                          ? Image.asset(
                              'assets/Medicines/11.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                            )
                          : Image.network(widget.item.images[0]),
                      durationInMilliseconds: 400,
                    ),
                    // Positioned.directional(
                    //     textDirection: Directionality.of(context),
                    //     end: 5,
                    //     top: 15,
                    //     child: Image.asset(
                    //       'assets/ic_prescription.png',
                    //       scale: 3,
                    //     )),
                  ],
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          widget.item.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 18.2, color: black2),
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.star,
                        //   color: Color(0xffF29F19),
                        //   size: 15,
                        // ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        // Text(
                        //   '4.5',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyText1!
                        //       .copyWith(color: Color(0xffF29F19), fontSize: 15),
                        // ),
                      ],
                    ),
                    // subtitle: Padding(
                    //   padding: const EdgeInsets.only(top: 13.5, bottom: 20),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         locale.heathCare!,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1!
                    //             .copyWith(
                    //                 color: lightGreyColor, fontSize: 13.5),
                    //       ),
                    //       Spacer(),
                    //       GestureDetector(
                    //           onTap: () {
                    //             Navigator.pushNamed(
                    //                 context, PageRoutes.reviewsPage);
                    //           },
                    //           child: Text(
                    //             locale.readAll! + ' 125 ' + locale.reviews!,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyText1!
                    //                 .copyWith(
                    //                     color: lightGreyColor, fontSize: 13.5),
                    //           )),
                    //       Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 12,
                    //         color: Theme.of(context).disabledColor,
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 13.0),
                  child: Text(
                    locale.description!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13.5, color: lightGreyColor),
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 4.0, bottom: 15),
                  child: Text(
                    widget.item.description,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        fontSize: 13.5,
                        color: black2),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 10.0, top: 12.0),
                  child: Text(
                    locale.soldBy!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: lightGreyColor, fontSize: 13.5),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    leading: widget.item.seller.image == ""
                        ? Image.asset('assets/SellerImages/1a.png')
                        : Image.network(widget.item.seller.image),
                    title: Text(
                      widget.item.seller.title,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: black2),
                    ),
                    // subtitle: Row(
                    //   children: [
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Color(0xff999999),
                    //       size: 10,
                    //     ),
                    //     Text(
                    //       'Willinton Bridge',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyText1!
                    //           .copyWith(fontSize: 12, color: Color(0xff999999)),
                    //     ),
                    //     Spacer(),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.pushNamed(
                    //             context, PageRoutes.sellerProfile);
                    //       },
                    //       child: Text(
                    //         locale.viewProfile!,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1!
                    //             .copyWith(
                    //                 fontSize: 12, color: Color(0xff999999)),
                    //       ),
                    //     ),
                    //     Icon(
                    //       Icons.arrow_forward_ios,
                    //       color: Color(0xff999999),
                    //       size: 10,
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListTile(
                      title: Text(
                        '${widget.item.price} L.E ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.item.pointsTaken.toString() +
                                " " +
                                locale.points!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: lightGreyColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    radius: 0,
                    label: locale.addToCart,
                    onTap: () {
                      menuProvider.addItemOrOfferToMycart(widget.item);

                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (BuildContext context,
                              StateSetter
                                  setModalState /*You can rename this!*/) {
                            return Container(
                              height: height * .3,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(1)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: height * .02,
                                  ),
                                  Container(
                                    color: Theme.of(context).primaryColor,
                                    width: width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width,
                                          height: height * .05,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.white,
                                                    size: height * .04,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * .02,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Container(
                                      height: height * .2,
                                      width: width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .05),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: width * .02,
                                              ),
                                              AutoSizeText(
                                                "item added to your cart.",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: height * .02,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                                Navigator.pushNamed(context,
                                                    PageRoutes.myCartPage);
                                              },
                                              style: TextButton.styleFrom(
                                                // maximumSize: Size(width * .9, 20),
                                                fixedSize: Size(
                                                    width * .9, height * .1),
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                backgroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                textStyle: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              child:
                                                  AutoSizeText("GO TO CART")),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                ],
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
