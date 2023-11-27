import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BottomNavigation/Medicine/select_market_order_payment_method.dart';
import '../Providers/menu_provider.dart';
import '../widgets/custom_dialog.dart';

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

// class OrderItem {
//   String name;
//   int quantity;
//   String amount;
//   bool presReq;

//   OrderItem(this.name, this.quantity, this.amount, this.presReq);
// }

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<MenuProvider>(context, listen: true);
    final auth = Provider.of<Auth>(context, listen: true);

    var locale = AppLocalizations.of(context)!;
    // List<OrderItem> cartItems = [
    //   OrderItem('Salospir 100mg Tablet', 2, '6.00', false),
    //   OrderItem('Non Drosy Laritin Tablet', 1, '8.00', true),
    //   OrderItem('Xenical 120mg Tablet', 1, '4.00', true),
    //   OrderItem('Non Drosy Laritin Tablet', 1, '8.00', true),
    //   OrderItem('Xenical 120mg Tablet', 1, '4.00', true),
    //   OrderItem('Non Drosy Laritin Tablet', 1, '8.00', true),
    //   OrderItem('Xenical 120mg Tablet', 1, '4.00', true),
    // ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          locale.confirmOrder!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Divider(
                  thickness: 6,
                  height: 6,
                ),
                buildCustomContainer(context, locale.deliveryAt!),
                auth.selectedAddress == null
                    ? Container(
                        color: Theme.of(context).backgroundColor,
                        child: Center(
                            child: Text(
                          "you should add address first\n click to add",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        )))
                    : ListTile(
                        horizontalTitleGap: 0,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        leading: Column(
                          children: [
                            Icon(
                              Icons.home,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        title: Text(
                          auth.selectedAddress!.title + '\n',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 0.6),
                        ),
                        subtitle: Text(
                          auth.selectedAddress!.address,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                  fontSize: 13,
                                  color: Color(
                                    0xff666666,
                                  ),
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                buildCustomContainer(context, locale.itemsInCart!),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menu.myCart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              menu.myCart[index].item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Color(0xff5b5b5b)),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            // Text(cartItems[index].quantity.toString() + ' '+locale.pack , style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).hintColor),),
                            menu.myCart[index].count > 1
                                ? Text(
                                    menu.myCart[index].count.toString() +
                                        ' ' +
                                        locale.packs!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 11.5,
                                            color: Color(0xffb2b2b2),
                                            fontWeight: FontWeight.w500))
                                : Text(
                                    menu.myCart[index].count.toString() +
                                        ' ' +
                                        locale.pack!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 11.5,
                                            color: Color(
                                              0xffb2b2b2,
                                            ),
                                            fontWeight: FontWeight.w500),
                                  ),
                            Spacer(),
                            Text(
                              '\$${(menu.myCart[index].count * double.parse(menu.myCart[index].item.price.toString())).toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 280,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                                                menu.usedPromoCode!.discount *
                                                .01)
                                            .toString())
                                : Container(),
                            // buildAmountRow(
                            //     context, locale.serviceCharge!, '4.00'),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
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
                                          menu.calculateTotalMoney().toString(),
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
                        radius: 0,
                        label: locale.continueToPay,
                        onTap: () {
                          if (auth.selectedAddress == null) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  msg:
                                      'you should add address to place your order',
                                  title: "Add Address",
                                  icon: Icon(Icons.error),
                                  mainAction: TextButton(
                                    child: Text("Add"),
                                    onPressed: () {},
                                  ),
                                  secondAction: TextButton(
                                    child: Text("Thanks"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ChooseMarketOrderPaymentMethod(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     color: Theme.of(context).scaffoldBackgroundColor,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 12.0, vertical: 8),
            //           child: Column(
            //             children: [
            //               // Divider(
            //               //   thickness: 6,
            //               //   height: 6,
            //               //   color: Theme.of(context).backgroundColor,
            //               // ),
            //               // ListTile(
            //               //   leading: Image.asset(
            //               //     'assets/ic_prescription.png',
            //               //     scale: 3,
            //               //   ),
            //               //   title: Text(
            //               //     locale.prescriptionUploaded!,
            //               //     style: Theme.of(context)
            //               //         .textTheme
            //               //         .subtitle1!
            //               //         .copyWith(
            //               //             fontSize: 15, color: Color(0xff2e2b2b)),
            //               //   ),
            //               //   trailing: Icon(
            //               //     Icons.remove_red_eye,
            //               //     size: 20,
            //               //     color: Theme.of(context).primaryColor,
            //               //   ),
            //               // ),
            //               Divider(
            //                 thickness: 6,
            //                 height: 6,
            //                 color: Theme.of(context).backgroundColor,
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               buildAmountRow(context, locale.subTotal!,
            //                   menu.calculateSubTotalMoney().toString()),
            //               buildAmountRow(
            //                   context, locale.promoCodeApplied!, '-2.00'),
            //               buildAmountRow(
            //                   context, locale.serviceCharge!, '4.00'),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               buildAmountRow(context, locale.amountToPay!,
            //                   menu.calculateSubTotalMoney().toString()),
            //             ],
            //           ),
            //         ),
            //         CustomButton(
            //           radius: 0,
            //           label: locale.continueToPay,
            //           onTap: () {
            //             if (auth.selectedAddress == null) {
            //               showDialog(
            //                 context: context,
            //                 barrierDismissible: false,
            //                 builder: (BuildContext context) {
            //                   return CustomDialog(
            //                     msg:
            //                         'you should add address to place your order',
            //                     title: "Add Address",
            //                     icon: Icon(Icons.error),
            //                     mainAction: TextButton(
            //                       child: Text("Add"),
            //                       onPressed: () {},
            //                     ),
            //                     secondAction: TextButton(
            //                       child: Text("Thanks"),
            //                       onPressed: () {
            //                         Navigator.pop(context);
            //                       },
            //                     ),
            //                   );
            //                 },
            //               );
            //             } else {
            //               Navigator.push<void>(
            //                 context,
            //                 MaterialPageRoute<void>(
            //                   builder: (BuildContext context) =>
            //                       ChooseMarketOrderPaymentMethod(),
            //                 ),
            //               );
            //             }
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Container buildCustomContainer(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 15, color: black2, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildAmountRow(BuildContext context, String title, String amount) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: title == locale.amountToPay
                    ? Colors.black
                    : Color(0xff5b5b5b),
                fontSize: title != locale.amountToPay ? 13.5 : 16.7),
          ),
          SizedBox(
            width: 4,
          ),
          // GestureDetector(
          //     onTap: () {},
          //     child: Icon(
          //       Icons.error_outline,
          //       size: 16,
          //       color: Theme.of(context).primaryColor,
          //     )),
          Spacer(),
          Text(
            '\$' + amount,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: title == locale.amountToPay
                      ? Colors.black
                      : Color(0xff5b5b5b),
                  fontSize: 16.7,
                ),
          ),
        ],
      ),
    );
  }
}
