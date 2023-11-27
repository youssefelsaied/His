import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:provider/provider.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

import '../../../Providers/menu_provider.dart';
import '../../../widgets/marketplace_category_item.dart';
import 'market_cart_widget.dart';

class MarketCategoriesPage extends StatefulWidget {
  // var categoryId;
  // ShopByCategoryPage(this.categoryId);
  @override
  _MarketCategoriesPageState createState() => _MarketCategoriesPageState();
}

class _MarketCategoriesPageState extends State<MarketCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: true);

    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          locale.shopByCategory!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [MarketCartWidget()],
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        // color: Theme.of(context).backgroundColor,
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: menu.marketHome!.categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return FadedScaleAnimation(
                SizedBox(
                  // height: height * .2,
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
    );
  }
}
//done
