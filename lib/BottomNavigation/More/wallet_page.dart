import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletCard {
  final String name;
  final String orderDetails;
  final String payment;
  final String earnings;

  WalletCard(this.name, this.orderDetails, this.payment, this.earnings);
}

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    if (auth.myWallet == null) {
      // auth.getWallet();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.chevron_left)),
        centerTitle: true,
        title: Text(
          locale.wallet!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: FadedSlideAnimation(
        auth.myWallet == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  // var wallet = auth.getWallet();
                  // var transactions = auth.getTransactions();
                  // List responses = await Future.wait([wallet, transactions]);
                  // responses;
                  return;
                },
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      // height: 200,
                      // width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Text(
                                  locale.availablePoints!.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 13.5,
                                          color: Color(0xff999999)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      auth.myWallet!.points.toString() + " ",
                                      style: theme.textTheme.headline6!
                                          .copyWith(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: black2),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/coin.svg',
                                        // color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(' | '),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // SizedBox(height: 140),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10),
                                child: Text(
                                  locale.availableCashback!.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 13.5,
                                          color: Color(0xff999999)),
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      auth.myWallet!.cacheBack.toString() + " ",
                                      style: theme.textTheme.headline6!
                                          .copyWith(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: black2),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/coin.svg',
                                        // color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // SizedBox(height: 240),
                        Container(
                          color: Theme.of(context).backgroundColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 20.0),
                          child: Text(
                            locale.recent!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Color(0xff6a6c74)),
                          ),
                        ),
                      ],
                    ),
                    auth.avialableOrders.isEmpty
                        ? Container(
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.library_books_rounded,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        locale.no_transactions!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        : Container(
                            // padding: EdgeInsets.only(top: 300.0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: auth.avialableOrders.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final order = auth.avialableOrders[index];
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd , hh:mm a')
                                        .format(order.createdAt!);

                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          buildRowChildWallet(theme,
                                              order.brandName!, formattedDate),
                                          Spacer(),
                                          order.transactionPoint.toString() ==
                                                  ''
                                              ? Text('')
                                              : SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: SvgPicture.asset(
                                                    'assets/coin.svg',
                                                    // color: Colors.green,
                                                  ),
                                                ),
                                          Text(
                                              " " +
                                                  order.transactionPoint
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xffb3b3b3))),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 6,
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                  ],
                                );
                              },
                            ),
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

  Widget buildRowChildWallet(ThemeData theme, String text1, String text2,
      {CrossAxisAlignment? alignment}) {
    return Column(
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      children: <Widget>[
        Text(text1, style: theme.textTheme.bodyText1!),
        SizedBox(height: 6.0),
        Text(
          text2,
          style: theme.textTheme.subtitle2!
              .copyWith(fontSize: 12, color: Color(0xff6a6c74)),
        ),
      ],
    );
  }
}
