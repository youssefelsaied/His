import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:m3ak_user/BottomNavigation/Medicine/medicine_info.dart';
import 'package:m3ak_user/BottomNavigation/Medicine/seller_profile.dart';
import 'package:m3ak_user/BottomNavigation/More/MarketPlace/market_categories_page.dart';
import 'package:m3ak_user/BottomNavigation/More/MarketPlace/market_offer.dart';
import 'package:m3ak_user/data/market_home.dart';
import 'package:provider/provider.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import 'package:flutter/material.dart';

import '../Components/custom_button.dart';
import '../Components/title_row.dart';
import '../Providers/auth.dart';
import '../Providers/menu_provider.dart';
import '../Theme/colors.dart';
import '../data/address.dart';
import '../widgets/marketplace_brand_item.dart';
import '../widgets/marketplace_category_item.dart';
import 'Medicine/medicines.dart' as md;
import 'More/MarketPlace/market_cart_widget.dart';
import 'More/MarketPlace/market_shortcut_page.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 5);
    final menu = Provider.of<MenuProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom;
    final auth = Provider.of<Auth>(context, listen: true);

    AddressElement? selected = auth.avialableAddresses.isEmpty
        ? null
        : auth.selectedAddress == null
            ? auth.avialableAddresses[0]
            : auth.selectedAddress;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.chevron_left)),
        title: Text(
          "Marketplace",
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        actions: [MarketCartWidget()],
      ),
      body: Container(
        height: height,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            //Search bar
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.search);
              },
              child: FadedScaleAnimation(
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: margin,
                  decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                      size: 18.5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        locale.search!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: textFieldColor, fontSize: 15),
                      ),
                    )
                  ]),
                ),
                durationInMilliseconds: 300,
              ),
            ),
            // delivery location
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: margin,
              child: Row(
                children: [
                  AutoSizeText(
                    locale.deliveryAt! + " ",
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
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
                              height: height * .4,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    height: height * .02,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * .2,
                                          height: 5,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * .02,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: height * .35,
                                    child: auth.avialableAddresses.isEmpty
                                        ? Container(
                                            height: height * .8,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text('No Address Added'),
                                                  CustomButton(
                                                    icon: Icon(Icons.add,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    label: AppLocalizations.of(
                                                            context)!
                                                        .addNewAddress,
                                                    textColor: Theme.of(context)
                                                        .primaryColor,
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    onTap: () =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            PageRoutes
                                                                .locationPage),
                                                    padding: height * .04,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                auth.avialableAddresses.length,
                                            shrinkWrap: false,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);

                                                  auth.setSelectedAddressId(
                                                      auth.avialableAddresses[
                                                          index]);
                                                  setState(() {
                                                    selected =
                                                        auth.avialableAddresses[
                                                            index];
                                                  });
                                                  setModalState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    // borderRadius:
                                                    //     BorderRadius.circular(12),
                                                    color: selected!.id ==
                                                            auth
                                                                .avialableAddresses[
                                                                    index]
                                                                .id
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.transparent,
                                                  ),
                                                  padding:
                                                      EdgeInsets.only(top: 6.0),
                                                  child: ListTile(
                                                    tileColor: selected!.id ==
                                                            auth
                                                                .avialableAddresses[
                                                                    index]
                                                                .id
                                                        ? Colors.black
                                                        : Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 12),
                                                    leading: Column(
                                                      children: [
                                                        Icon(
                                                          (auth.avialableAddresses[index].title ==
                                                                      "Home" ||
                                                                  auth
                                                                          .avialableAddresses[
                                                                              index]
                                                                          .title ==
                                                                      "Home")
                                                              ? Icons.home
                                                              : (auth.avialableAddresses[index].title ==
                                                                          "Office" ||
                                                                      auth.avialableAddresses[index].title ==
                                                                          "Office")
                                                                  ? Icons
                                                                      .local_post_office
                                                                  : Icons
                                                                      .other_houses_outlined,
                                                          color: selected!.id ==
                                                                  auth
                                                                      .avialableAddresses[
                                                                          index]
                                                                      .id
                                                              ? Colors.black
                                                              : Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                          size: 24,
                                                        ),
                                                      ],
                                                    ),
                                                    title: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.0),
                                                      child: Text(
                                                          auth
                                                              .avialableAddresses[
                                                                  index]
                                                              .title,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!),
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          auth
                                                              .avialableAddresses[
                                                                  index]
                                                              .address,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      0xff666666)),
                                                        ),
                                                        Text(
                                                          auth
                                                              .avialableAddresses[
                                                                  index]
                                                              .latitude
                                                              .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      0xff666666)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          auth.selectedAddress != null
                              ? auth.selectedAddress!.title
                              : locale.selectAddress!.toLowerCase(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                        Icon(Icons.arrow_drop_down_rounded,
                            color: Theme.of(context).primaryColor)
                      ],
                    ),
                  )
                ],
              ),
            ),
            // divider
            Container(
              margin: margin,
              child: Divider(
                thickness: 2,
              ),
            ),
            //Adds
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                  items: menu.marketHome!.adds
                      .map((e) => InkWell(
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      MarketShortcutPage(
                                    shortcutId: e.marketPlaceShortcutId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FancyShimmerImage(
                                      imageUrl: e.image, boxFit: BoxFit.fill),
                                )),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    // height: 180,
                    aspectRatio: 16 / 7,
                    viewportFraction: 1.2,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,

                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 600),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            // categories
            TitleRow(
                locale.shopByCategory,
                () => Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            MarketCategoriesPage(),
                      ),
                    ),
                true),
            Container(
              height: (width * .4) *
                  (menu.marketHome!.categories.length > 4 ? 2 : 1),
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: menu.marketHome!.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        menu.marketHome!.categories.length > 4 ? 2 : 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 10,
                    // childAspectRatio: 1.2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2),
                  ),
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 1.2,
                  //     crossAxisSpacing: 1,
                  //     childAspectRatio: MediaQuery.of(context).size.width /
                  //         (MediaQuery.of(context).size.height / 4),
                  //     mainAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return FadedScaleAnimation(
                      SizedBox(
                        height: height * .2,
                        child: MarketplaceCategoryItem(
                          category: menu.marketHome!.categories[index],
                          index: index + 1,
                          home: false,
                        ),
                      ),
                      durationInMilliseconds: 300,
                    );
                  }),
            ),
            // offers
            menu.marketHome!.offers.isEmpty
                ? Container()
                : Column(
                    children: [
                      TitleRow(locale.viewOffers, null, false),
                      Container(
                        height: height * .15,
                        child: GridView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 10),
                            physics: AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: menu.marketHome!.offers.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: .6,
                                    // mainAxisExtent: 200,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              var e = menu.marketHome!.offers[index];
                              return FadedScaleAnimation(
                                InkWell(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              MarketOffer(e)),
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: FancyShimmerImage(
                                            imageUrl: e.images[0].image,
                                            boxFit: BoxFit.fill),
                                      )),
                                ),
                                durationInMilliseconds: 300,
                              );
                            }),
                      ),
                    ],
                  ),

            // TitleRow(
            //     locale.shopByCategory,
            //     () => Navigator.pushNamed(
            //           context,
            //           PageRoutes.shopByCategory,
            //         ),
            //     true),
            // Container(
            //   height: height * .3,
            //   child: GridView.builder(
            //       padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            //       physics: BouncingScrollPhysics(),
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       itemCount: _myItems.length,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 1,
            //           childAspectRatio: 1.4,
            //           crossAxisSpacing: 12,
            //           mainAxisSpacing: 12),
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () {
            //             Navigator.pushNamed(context, PageRoutes.medicineInfo);
            //           },
            //           child: Stack(
            //             children: [
            //               Container(
            //                 // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            //                 padding: EdgeInsets.symmetric(
            //                     vertical: 10, horizontal: 10),
            //                 decoration: BoxDecoration(
            //                     color:
            //                         Theme.of(context).scaffoldBackgroundColor,
            //                     borderRadius: BorderRadius.circular(8)),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     Stack(
            //                       children: [
            //                         FadedScaleAnimation(
            //                           Image.asset(_myItems[index].image),
            //                           durationInMilliseconds: 400,
            //                         ),
            //                         _myItems[index].prescription
            //                             ? Align(
            //                                 alignment: Alignment.topRight,
            //                                 child: FadedScaleAnimation(
            //                                   Image.asset(
            //                                     'assets/ic_prescription.png',
            //                                     scale: 3,
            //                                   ),
            //                                   durationInMilliseconds: 400,
            //                                 ),
            //                               )
            //                             : SizedBox.shrink(),
            //                       ],
            //                     ),
            //                     Spacer(),
            //                     Text(
            //                       _myItems[index].name,
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .bodyText1!
            //                           .copyWith(
            //                               fontSize: 11.5,
            //                               color: Color(0xff5b5b5b),
            //                               fontWeight: FontWeight.w600),
            //                     ),
            //                     SizedBox(height: 5),
            //                     Row(
            //                       children: [
            //                         Text(
            //                           '\$ ' + _myItems[index].price,
            //                           style: Theme.of(context)
            //                               .textTheme
            //                               .bodyText1!
            //                               .copyWith(
            //                                   fontSize: 15,
            //                                   fontWeight: FontWeight.w700),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(height: 20),
            //                   ],
            //                 ),
            //               ),
            //               Align(
            //                 alignment: Alignment.bottomRight,
            //                 child: CustomAddItemButton(),
            //               ),
            //             ],
            //           ),
            //         );
            //       }),
            // ),

            // shortcuts
            TitleRow(locale.shortcuts, null, false),
            Container(
              height: (height * .2 + 4) * 3,
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: menu.marketHome!.shotcuts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,

                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1.1,
                    // childAspectRatio: MediaQuery.of(context).size.width /
                    //     (MediaQuery.of(context).size.height / 2),
                  ),
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 1.2,
                  //     crossAxisSpacing: 1,
                  //     childAspectRatio: MediaQuery.of(context).size.width /
                  //         (MediaQuery.of(context).size.height / 4),
                  //     mainAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return FadedScaleAnimation(
                      SizedBox(
                        // height: height * .2,
                        child: MarketplaceShortcutItem(
                          category: menu.marketHome!.shotcuts[index],
                          index: index,
                          home: false,
                        ),
                      ),
                      durationInMilliseconds: 300,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
