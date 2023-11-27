import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import 'package:flutter/material.dart';

import '../../Pages/brand_info_page.dart';
import '../../Providers/auth.dart';
import '../../Theme/colors.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left)),
          title: Text(
            AppLocalizations.of(context)!.Favourite_brands!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          SavedAddresses(),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}

class SavedAddresses extends StatefulWidget {
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context);
    final auth = Provider.of<Auth>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final notch = MediaQuery.of(context).padding.top;
    var locale = AppLocalizations.of(context)!;

    final height = MediaQuery.of(context).size.height - notch;

    return Container(
      color: Theme.of(context).dividerColor,
      child: menu.favouriteBrands.isEmpty
          ? Center(
              child: ListView(children: [
                SizedBox(
                  height: height * .3,
                ),
                Icon(
                  Icons.favorite,
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: height * .05,
                ),
                Center(
                  child: Text(
                    locale.no_favourites!,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ]),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: menu.favouriteBrands.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 18.0,
                                left: width * .025,
                                right: width * .025,
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  // Navigator.pushNamed(
                                  //     context, PageRoutes.doctorInfo);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  await Future.delayed(
                                      Duration(microseconds: 500));

                                  await Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          BrandInfoPage(
                                        brand: menu.favouriteBrands[index],
                                        code: locale.locale.languageCode,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FadedScaleAnimation(
                                      menu.favouriteBrands[index].image == ''
                                          ? Image.asset(
                                              // 'assets/img_orderplaced.png',
                                              'assets/SellerImages/1a.png',
                                              height: width * .25,
                                              width: width * .25,
                                            )
                                          : Image.network(
                                              menu.favouriteBrands[index]
                                                  .image!,
                                              height: width * .25,
                                              width: width * .25,
                                            ),
                                      durationInMilliseconds: 400,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .05),
                                      width: width * .7,
                                      child: RichText(
                                          text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: menu
                                                        .favouriteBrands[index]
                                                        .name! +
                                                    '\n',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: black2,
                                                        height: 1.7,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            // TextSpan(
                                            //     text: "  serviceTitle",
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText1!
                                            //         .copyWith(
                                            //           fontSize: 11.2,
                                            //           color:
                                            //               Color(0xff999999),
                                            //         )),
                                            // TextSpan(
                                            //     text: locale.at,
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText1!
                                            //         .copyWith(
                                            //           fontSize: 11.2,
                                            //           color:
                                            //               Color(0xffcccccc),
                                            //         )),
                                            // TextSpan(
                                            //     text: "hospital",
                                            //     style: Theme.of(context)
                                            //         .textTheme
                                            //         .bodyText1!
                                            //         .copyWith(
                                            //           fontSize: 11.2,
                                            //           color:
                                            //               Color(0xff999999),
                                            //         )),
                                          ])),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 6,
                              thickness: 6,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ],
                        ),
                        PositionedDirectional(
                          // bottom: 28,
                          top: 22,
                          end: 10,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    menu.favouriteBrands[index].isFavourite =
                                        !menu.favouriteBrands[index]
                                            .isFavourite!;
                                  });
                                  // final res = await menu.favouriteBrand(
                                  //     auth.theUser!.token,
                                  //     menu.favouriteBrands[index].id);
                                  if (!true) {
                                    setState(() {
                                      menu.favouriteBrands[index].isFavourite =
                                          !menu.favouriteBrands[index]
                                              .isFavourite!;
                                    });
                                  }
                                },
                                icon: Icon(
                                  menu.favouriteBrands[index].isFavourite!
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color:
                                      menu.favouriteBrands[index].isFavourite!
                                          ? Colors.red
                                          : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
    );
  }
}
