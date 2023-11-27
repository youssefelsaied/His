import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/Medicine/medicines.dart';
import 'package:m3ak_user/BottomNavigation/More/MarketPlace/market_category_page.dart';
import 'package:m3ak_user/Pages/sub_category_page.dart';
import 'package:m3ak_user/data/market_home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BottomNavigation/Data/data.dart';
import '../Locale/locale.dart';
import '../Pages/sub_sub_category_page.dart';
import '../Routes/routes.dart';

class MarketplaceCategoryItem extends StatefulWidget {
  final HomeCategory category;
  final int index;
  final bool home;
  const MarketplaceCategoryItem(
      {Key? key,
      required this.category,
      required this.index,
      required this.home})
      : super(key: key);

  @override
  State<MarketplaceCategoryItem> createState() =>
      _MarketplaceCategoryItemState();
}

class _MarketplaceCategoryItemState extends State<MarketplaceCategoryItem> {
  openwhatsapp() async {
    var whatsapp = "+201067777202";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
        // ignore: deprecated_member_use
        await launchUrl(Uri.parse(whatappURL_ios),
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURl_android))) {
        await launchUrl(Uri.parse(whatsappURl_android),
            mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MarketCategoryPage(
              categoryId: widget.category.id,
            ),
          ),
        );
      },
      child: Container(
        width: width * .35,
        height: width * .35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: FancyShimmerImage(
                    imageUrl: widget.category.image,
                    errorWidget: Column(
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        AutoSizeText(
                          "Error Loading Image",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    width: width * .28,
                    height: width * .28,
                    boxFit: BoxFit.fill)),

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
