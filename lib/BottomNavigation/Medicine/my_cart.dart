import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/main.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Providers/menu_provider.dart';

class Product {
  Product(this.img, this.name, this.category, this.price);
  String img;
  String name;
  String category;
  String price;
//  int count;
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // List<int> count = [1, 1, 1];
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: true);
    final auth = Provider.of<Auth>(context, listen: true);

    var locale = AppLocalizations.of(context)!;
    // List<Product> items = [
    //   Product("assets/Medicines/11.png", 'Salospir 100mg Tablet',
    //       'Operum England', '\$32.00'),
    //   Product("assets/Medicines/22.png", 'Non Drosy Laritin Tablet',
    //       'Operum England', '\$44.00'),
    //   Product("assets/Medicines/33.png", 'Xenical 120mg Tablet',
    //       'Operum England', '\$14.00'),
    // ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          locale.myCart!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menu.myCart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Image.network(
                                //   menu.myCart[index].item.images[0],
                                //   height: 75,
                                // ),
                                Image.asset(
                                  "assets/Medicines/11.png",
                                  height: 75,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        menu.myCart[index].item.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                fontSize: 15, color: black2),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        menu.myCart[index].item.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Color(0xffb2b2b2),
                                                fontSize: 13.5),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          buildIconButton(
                                              menu.myCart[index].count == 1
                                                  ? Icons.delete
                                                  : Icons.remove, () {
                                            menu.minusCount(
                                                menu.myCart[index].item);
                                          }),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text('${menu.myCart[index].count}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          buildIconButton(Icons.add, () {
                                            menu.plusCount(
                                                menu.myCart[index].item);
                                          }),
                                          SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                      (menu.myCart[index].count *
                                              double.parse(menu
                                                  .myCart[index].item.price
                                                  .toString()))
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16.7,
                                              fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(height: 280),
              ],
            ),
            menu.myCart.isEmpty
                ? Container(
                    child: Center(child: Text("No items")),
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 12),
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12),
                                    hintText: locale.addPromoCode,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 13.5,
                                            color: Color(0xffc0c0c0)),
                                    fillColor: Colors.grey[100],
                                    filled: true,
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // TextButton(
                                        //   onPressed: () {
                                        //     Navigator.pushNamed(
                                        //         context, PageRoutes.offersPage);
                                        //   },
                                        //   child: Text(
                                        //     locale.viewOffers!.toUpperCase(),
                                        //     textAlign: TextAlign.center,
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodyText2!
                                        //         .copyWith(
                                        //             fontSize: 12,
                                        //             color: Theme.of(context)
                                        //                 .primaryColor),
                                        //   ),
                                        // ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (controller.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(new SnackBar(
                                                      content: new Text(
                                                          'please enter promo code')));
                                            } else {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              // final res =
                                              //     await menu.marketCheckPromo(
                                              //         auth.theUser!.token,
                                              //         controller.text);
                                              if (true) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(new SnackBar(
                                                        content: new Text(
                                                            'Promo Code Applied!')));
                                              } else {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(new SnackBar(
                                                        content: new Text(
                                                  'Promo Code Not Found!',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )));
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4))),
                                            child: _isLoading
                                                ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ))
                                                : menu.usedPromoCode == null
                                                    ? AutoSizeText(
                                                        "check",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,

                                                        // size: 20,
                                                        // color: Theme.of(context)
                                                        //     .scaffoldBackgroundColor,
                                                      )
                                                    : Icon(
                                                        Icons.check,
                                                        size: 20,
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor,
                                                      ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: Column(
                                children: [
                                  buildAmountRow(context, locale.subTotal!,
                                      menu.calculateSubTotalMoney().toString()),
                                  menu.usedPromoCode != null
                                      ? buildAmountRow(
                                          context,
                                          locale.promoCodeApplied!,
                                          '-' +
                                              (menu.calculateSubTotalMoney() *
                                                      menu.usedPromoCode!
                                                          .discount *
                                                      .01)
                                                  .toString())
                                      : Container(),
                                  // buildAmountRow(
                                  //     context, locale.serviceCharge!, '4.00'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          locale.amountPayable!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  fontSize: 13.5,
                                                  color: Color(0xff5b5b5b)),
                                        ),
                                        // SizedBox(
                                        //   width: 4,
                                        // ),
                                        // GestureDetector(
                                        //     onTap: () {},
                                        //     child: Icon(
                                        //       Icons.error_outline,
                                        //       size: 16,
                                        //       color: Theme.of(context).primaryColor,
                                        //     )),
                                        Spacer(),
                                        Text(
                                            '\$' +
                                                menu
                                                    .calculateTotalMoney()
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 16.7,
                                                )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomButton(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.confirmOrderPage);

                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) =>
                                //       _prescriptionRequired(context),
                                // );
                              },
                              radius: 0,
                              label: locale.checkout,
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Padding buildAmountRow(BuildContext context, String title, String amount) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 13.5, color: Color(0xff5b5b5b)),
          ),
          SizedBox(
            width: 4,
          ),
          title == locale.amountPayable
              ? GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ))
              : SizedBox.shrink(),
          Spacer(),
          Text('\$' + amount,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 16.7, color: Color(0xff5b5b5b))),
        ],
      ),
    );
  }

  GestureDetector buildIconButton(IconData icon, void Function() function) {
    return GestureDetector(
      onTap: function,
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 16,
      ),
    );
  }

  Widget _prescriptionRequired(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: FadedSlideAnimation(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10,
            ),
            FadedScaleAnimation(
              Image.asset(
                'assets/upload prescription.png',
                scale: 3.5,
              ),
              durationInMilliseconds: 400,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              locale.prescriptionRequire!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 18.2),
            ),
            SizedBox(
              height: 20,
            ),
            Text(locale.yourOrderContains2items!,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 15, color: black2)),
            SizedBox(height: 10),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
                },
                child: Text(
                  locale.uploadPrescription!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  locale.cancel!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).primaryColor),
                )),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
//done
