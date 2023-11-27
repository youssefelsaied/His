import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Pages/sub_category_page.dart';
import 'package:m3ak_user/data/menu.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BottomNavigation/Data/data.dart';
import '../Locale/locale.dart';
import '../Pages/sub_sub_category_page.dart';
import '../Routes/routes.dart';

class CategoryItem extends StatefulWidget {
  final Category category;
  final int index;
  final bool home;
  const CategoryItem(
      {Key? key,
      required this.category,
      required this.index,
      required this.home})
      : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
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

    return GestureDetector(
      onTap: () {
        if (widget.category.id == 1000000) {
          openwhatsapp();
        }
        // Navigator.pushNamed(context, PageRoutes.subCategoryPage);
        else {
          if (widget.category.subCategories.isNotEmpty) {
            // Navigator.push<void>(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => SubSubCategoryPage(
            //         widget.category, locale.locale.languageCode),
            //   ),
            // );
          } else {
            // Navigator.push<void>(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => SubCategoryPage(
            //         widget.category, locale.locale.languageCode, false, 0, ''),
            //   ),
            // );
          }
        }
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: widget.category.image != ''
                ? widget.home
                    ? FancyShimmerImage(
                        imageUrl: widget.category.image!,
                        width: 96,
                        // height: home ? 122 : null,
                        boxFit: BoxFit.cover)
                    : FancyShimmerImage(
                        imageUrl: widget.category.image!,
                        // width: widget.home ? 96 : null,
                        // height: home ? 122 : null,
                        boxFit: BoxFit.cover)
                : Image.asset(
                    'assets/CategoryImages/chat.png',
                    width: null,
                    height: widget.home ? 122 : null,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: 0,
            left: 1,
            right: 1,
            child: Container(
              // height: home ? 122 : null,
              // width: 96,
              padding: EdgeInsets.only(bottom: 6, left: 1, right: 1),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.4)
                    ],
                    stops: [
                      0.3,
                      0.65,
                      0.9
                    ]),
              ),
              child: AutoSizeText(
                widget.category.title!,
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
          // Positioned(top: 6, left: 6, right: 6, child: Text(category.title!))
        ],
      ),
    );
  }
}
