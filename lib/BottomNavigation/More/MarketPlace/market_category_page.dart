import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:m3ak_user/BottomNavigation/More/MarketPlace/market_item.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';

import '../../../Components/custom_add_item_button.dart';
import '../../../Providers/menu_provider.dart';
import '../../../Routes/routes.dart';
import '../../../data/market_home.dart' as mk;
import '../../Medicine/medicine_info.dart';
import '../../Medicine/medicines.dart';
import 'market_cart_widget.dart';

class MarketCategoryPage extends StatefulWidget {
  final int categoryId;

  const MarketCategoryPage({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<MarketCategoryPage> createState() => _MarketCategoryPageState();
}

class _MarketCategoryPageState extends State<MarketCategoryPage> {
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    final menu = Provider.of<MenuProvider>(context, listen: false);
    // menu.fetchMarketCategories(auth.theUser!.token, widget.categoryId);

    super.initState();
  }

  mk.SubCategory? selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    // var category = menu.marketCategory!.category;
    // var category = menu.marketCategory!.category;
    return menu.marketCategory == null
        ? Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              actions: [MarketCartWidget()],
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(
                menu.marketCategory!.category.title,
                style: TextStyle(color: Colors.black),
              ),
              actions: [MarketCartWidget()],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              // color: Theme.of(context).backgroundColor,
              // color: Colors.red,
              child: menu.marketCategory!.category.allItems.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100,
                          width: width,
                          color: Theme.of(context).backgroundColor,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .025),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              bool selected = (selectedSubCategory != null &&
                                  menu.marketCategory!.category
                                          .subCategories[index].id ==
                                      selectedSubCategory!.id);
                              return InkWell(
                                onTap: () {
                                  if (selected) {
                                    setState(() {
                                      selectedSubCategory = null;
                                    });
                                  } else {
                                    setState(() {
                                      selectedSubCategory = menu.marketCategory!
                                          .category.subCategories[index];
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: selected
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).backgroundColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.grey[100]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: menu
                                                      .marketCategory!
                                                      .category
                                                      .subCategories[index]
                                                      .image ==
                                                  ""
                                              ? Image.asset(
                                                  "assets/hero_image.png")
                                              : Image.network(menu
                                                  .marketCategory!
                                                  .category
                                                  .subCategories[index]
                                                  .image),
                                        ),
                                      ),
                                      AutoSizeText(
                                        menu.marketCategory!.category
                                            .subCategories[index].title,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: menu
                                .marketCategory!.category.subCategories.length,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .05),
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        GridView.builder(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: selectedSubCategory == null
                                ? menu.marketCategory!.category.allItems.length
                                : selectedSubCategory!.items.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.82,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12),
                            itemBuilder: (context, index) {
                              mk.Item item = selectedSubCategory == null
                                  ? menu
                                      .marketCategory!.category.allItems[index]
                                  : selectedSubCategory!.items[index];
                              return MarketItem(item: item);
                            }),
                      ],
                    ),
            ),
          );
  }
}
