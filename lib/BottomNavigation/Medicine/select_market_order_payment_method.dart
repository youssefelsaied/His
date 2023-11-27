import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:m3ak_user/BottomNavigation/Medicine/paymob_payment.dart';
import 'package:m3ak_user/Pages/fawry_payment_page.dart';
import 'package:m3ak_user/Pages/last_payment_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';
import 'package:m3ak_user/data/subscription.dart';
import 'package:m3ak_user/widgets/custom_dialog.dart';
import 'package:m3ak_user/widgets/error_dialog.dart';
import 'package:m3ak_user/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';

import 'fawry_payment.dart';

class ChooseMarketOrderPaymentMethod extends StatefulWidget {
  @override
  _ChooseMarketOrderPaymentMethodState createState() =>
      _ChooseMarketOrderPaymentMethodState();
}

class PaymentType {
  int? paymentMethodId;
  Icon? icon;
  String? title;
  String? subTitle;
  String? description;
  String? phoneNumber;

  PaymentType(
      {this.paymentMethodId,
      this.icon,
      this.title,
      this.subTitle,
      this.description,
      this.phoneNumber});
}

class _ChooseMarketOrderPaymentMethodState
    extends State<ChooseMarketOrderPaymentMethod> {
  List<PaymentType> paymentModes = [
    PaymentType(
      icon: Icon(
        Icons.credit_card,
        size: 20,
        color: Colors.lightGreen,
      ),
      title: "Credit Card",
      subTitle: "powered by paymob",
    ),
    PaymentType(
      icon: Icon(
        Icons.attach_money_rounded,
        size: 20,
        color: Colors.lightGreen,
      ),
      title: "Cash",
      subTitle: "on delivery",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final menu = Provider.of<MenuProvider>(context);
    final auth = Provider.of<Auth>(context);
    // List<PaymentType> paymentModes = [
    //   PaymentType(
    //       icon: 'assets/vodafone-png-logo.png',
    //       title: 'Vodafone Cash',
    //       description:
    //           "You can pay for the subscription using the Vodafone Cash wallet on the following number",
    //       phoneNumber: "01000095624"),
    //   PaymentType(
    //       icon: 'assets/etisalat_cash_logo.jpeg',
    //       title: 'Etisalat Cash',
    //       description:
    //           "You can pay for the subscription using the Etisalat Cash wallet on the following number",
    //       phoneNumber: "01149888466"),
    //   PaymentType(icon: '', title: "Credit Card", subTitle: "Coming Soon"),
    // ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          locale.selectPaymentMethod!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 20),
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: locale.amountToPay!.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 13.5, color: Color(0xff999999), height: 2)),
                  TextSpan(
                      text: '\nEGP ${menu.calculateTotalMoney()}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 35,
                          color: black2,
                          fontWeight: FontWeight.bold))
                ])),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
                child: Text(
                  locale.paymentModes!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: black2),
                ),
              ),
              Divider(
                thickness: 4,
                height: 4,
              ),
              ListView.builder(
                  itemCount: paymentModes.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: paymentModes[index].subTitle == null
                              ? Colors.transparent
                              : Colors.transparent,
                          child: ListTile(
                            onTap: () async {
                              // pop up loading

                              if (paymentModes[index].title == "Credit Card") {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return LoadingDialog(
                                      msg: 'Generating Order details to pay',
                                    );
                                  },
                                );
                                // final res = await menu.marketPlaceOrder(
                                //     auth.selectedAddress!,
                                //     auth.theUser!.token,
                                // 1);
                                if (true) {
                                  // await auth.getFirstTokenMarket(
                                  //     menu.calculateTotalMoney(),
                                  //     menu.myCart,
                                  //     menu.placedOrderId);
                                  Navigator.pop(context);
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            PaymobPayment()),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return ErrorDialog(
                                        msg: 'Generating Order details to pay',
                                        title: "Error Occured",
                                      );
                                    },
                                  );
                                }
                              } else {
                                // place order
                                // pop up are you sure to place order in cash
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      msg: 'Are you sure to place cash order',
                                      title: "Pay Cash on Delivery",
                                      icon: Icon(Icons.error),
                                      mainAction: TextButton(
                                        child: Text(
                                          "YES",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return LoadingDialog(
                                                  msg: "placing your order");
                                            },
                                          );
                                          // final res =
                                          //     await menu.marketPlaceOrder(
                                          //         auth.selectedAddress!,
                                          //         auth.theUser!.token,
                                          //         0);
                                          if (true) {
                                            menu.clearCart();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return CustomDialog(
                                                  icon: Icon(Icons.check),
                                                  msg: "placing your order",
                                                  title: "Order Placed ",
                                                  mainAction: TextButton(
                                                      child: Text(
                                                        "OK",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                  secondAction: null,
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                      secondAction: TextButton(
                                        child: Text(
                                          "NO",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 7),
                            leading: SizedBox(
                              width: 40,
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  child: paymentModes[index].icon!
                                  //  Icon(
                                  //   Icons.credit_card,
                                  // size: 20,
                                  // color: Colors.lightGreen,
                                  // )
                                  ),
                            ),
                            title: Text(
                              paymentModes[index].title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            subtitle: paymentModes[index].subTitle == null
                                ? null
                                : Text(
                                    paymentModes[index].subTitle!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.withOpacity(.8),
                                            fontSize: 10),
                                  ),
                          ),
                        ),
                        Divider(
                          thickness: 4,
                          height: 4,
                        ),
                      ],
                    );
                  }),
              Container(
                height: 20,
                // color: Theme.of(context).backgroundColor,
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
//done
