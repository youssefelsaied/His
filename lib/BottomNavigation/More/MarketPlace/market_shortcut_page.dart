import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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

class MarketShortcutPage extends StatefulWidget {
  final int shortcutId;

  const MarketShortcutPage({Key? key, required this.shortcutId})
      : super(key: key);

  @override
  State<MarketShortcutPage> createState() => _MarketShortcutPageState();
}

class _MarketShortcutPageState extends State<MarketShortcutPage> {
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    final menu = Provider.of<MenuProvider>(context, listen: false);
    // menu.fetchMarketShortcutItems(auth.theUser!.token, widget.shortcutId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: AutoSizeText(
          "MarketPlace",
          style: TextStyle(color: Colors.black),
        ),
        actions: [MarketCartWidget()],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        // color: Theme.of(context).backgroundColor,
        // color: Colors.red,
        child: menu.marketShortcutItems.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: menu.marketShortcutItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.82,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return MarketItem(item: menu.marketShortcutItems[index]);
                }),
      ),
    );
  }
}
