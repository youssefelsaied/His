import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/MarketPlace/market_shortcut_page.dart';
import 'package:m3ak_user/Pages/sub_category_page.dart';
import 'package:m3ak_user/data/market_home.dart';
// import 'package:m3ak_user/data/menu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Locale/locale.dart';
import '../Pages/sub_sub_category_page.dart';

class MarketplaceShortcutItem extends StatefulWidget {
  final HomeCategory category;
  final int index;
  final bool home;
  const MarketplaceShortcutItem(
      {Key? key,
      required this.category,
      required this.index,
      required this.home})
      : super(key: key);

  @override
  State<MarketplaceShortcutItem> createState() =>
      _MarketplaceShortcutItemState();
}

class _MarketplaceShortcutItemState extends State<MarketplaceShortcutItem> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MarketShortcutPage(
              shortcutId: widget.category.id,
            ),
          ),
        );
      },
      child: Container(
        width: width * .25,
        height: width * .25,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(width * .125),
                child: FancyShimmerImage(
                    imageUrl: widget.category.image,
                    width: width * .25,
                    height: width * .25,
                    boxFit: BoxFit.cover)),

            SizedBox(
              height: 6,
            ),
            SizedBox(
              // height: 30,
              child: AutoSizeText(
                widget.category.title!,
                style: TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            // Positioned(top: 6, left: 6, right: 6, child: Text(category.title!))
          ],
        ),
      ),
    );
  }
}
