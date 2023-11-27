import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:m3ak_user/BottomNavigation/More/Order/order_info.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/order.dart';
import 'package:provider/provider.dart';
import '../../../../Locale/locale.dart';
import '../../../../Models/order_card_model.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';

class RecentOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("orderCard.id");

    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context);
    final height = MediaQuery.of(context).size.height * .9;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.recentOrders!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        // auth.avialableOrders.isEmpty
        //     ? RefreshIndicator(
        //         color: Theme.of(context).primaryColor,
        //         onRefresh: () async {
        //           await auth.getTransactions();
        //           return;
        //         },
        //         child: ListView(
        //             physics: AlwaysScrollableScrollPhysics(),
        //             children: [
        //               SizedBox(
        //                 height: 200,
        //               ),
        //               Icon(
        //                 Icons.library_books_rounded,
        //                 size: 100,
        //                 color: Colors.grey,
        //               ),
        //               Spacer(),
        //               Text(
        //                 locale.no_orders!,
        //                 style: TextStyle(
        //                   color: Colors.grey,
        //                 ),
        //                 textAlign: TextAlign.center,
        //               ),
        //               Spacer(
        //                 flex: 8,
        //               ),
        //             ]),
        //       )

        //     :
        RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            // await auth.getOrders();
            return;
          },
          child: ListView(
            // physics: AlwaysScrollableScrollPhysics(),
            children: auth.avialableOrders.isEmpty
                ? [
                    SizedBox(
                      height: height * .38,
                    ),
                    Icon(
                      Icons.library_books_rounded,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    Text(
                      locale.no_orders!,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Spacer(
                    //   flex: 8,
                    // ),
                  ]
                : [
                    // Container(
                    //   padding: EdgeInsets.all(16),
                    //   child: Text(
                    //     locale.inProcess!,
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyText1!
                    //         .copyWith(fontSize: 13.5, color: Color(0xffb3b3b3)),
                    //   ),
                    //   color: Theme.of(context).dividerColor,
                    // ),
                    // ListView.builder(
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: inProcessOrders.length,
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) =>
                    //       OrderCard(inProcessOrders[index]),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(16),
                    //   child: Text(
                    //     locale.past!,
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyText1!
                    //         .copyWith(fontSize: 13.5, color: Color(0xffb3b3b3)),
                    //   ),
                    //   color: Theme.of(context).dividerColor,
                    // ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: auth.myOrders.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          OrderCard(auth.myOrders[index]),
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

class OrderCard extends StatelessWidget {
  final OrderElement orderCard;

  OrderCard(this.orderCard);

  @override
  Widget build(BuildContext context) {
    print("orderCard.id");
    var locale = AppLocalizations.of(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderInfoPage(orderCard: orderCard)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: SizedBox(
                width: width * .1,
                child: Image.asset(
                  "assets/SellerImages/2.png",
                  height: width * .1,
                  width: width * .1,
                )),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderCard.providre!.brandName!.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: black2, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "ID : " + orderCard.id!.toString(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: black2, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                SizedBox(
                  width: width * .3,
                  child: Text(
                    orderCard.createdAt!,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),

            //  SizedBox(
            //             width: 150,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: orderCard.images!
            //                   .map(
            //                     (e) => InkWell(
            //                       onTap: () {},
            //                       child: SizedBox(
            //                           width: 40,
            //                           child: Image.network(e!.image!,
            //                               height: 40, width: 40)),
            //                     ),
            //                   )
            //                   .toList(),
            //             ),
            //           )

            // subtitle: Row(
            //   children: [
            //     Text(
            //       orderCard.createdAt!.toString(),
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1!
            //           .copyWith(fontSize: 12, color: Color(0xffb3b3b3)),
            //     ),
            //     Spacer(),
            //     SizedBox(
            //       height: 20,
            //       width: 20,
            //       child: SvgPicture.asset(
            //         'assets/coin.svg',
            //         // color: Colors.green,
            //       ),
            //     ),

            //   ],
            // ),
          ),
          Divider(thickness: 4, height: 0),
        ],
      ),
    );
  }
}























// in case all went wrong //



// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/data/transaction.dart';
// import 'package:provider/provider.dart';
// import '../../../../Locale/locale.dart';
// import '../../../../Models/order_card_model.dart';
// import '../../../../BottomNavigation/More/Order/order_info.dart';
// import '../../../../Theme/colors.dart';
// import 'package:flutter/material.dart';
// import '../../../../Routes/routes.dart';

// class RecentOrdersPage extends StatelessWidget {
//   final List<OrderCardModel> inProcessOrders = [
//     OrderCardModel("assets/SellerImages/4.png", 'Well Life Store 0',
//         'In transit', '11 June, 11: 20 am', '18.00', 'COD', [
//       'Salosir 100mg Tablet',
//       'Salosir 100mg Tablet',
//       'Salosir 100mg Tablet'
//     ]),
//     OrderCardModel("assets/SellerImages/1.png", 'Well Life Store 1',
//         'confirmed', '11 June, 11: 20 am', '18.00', 'PayPal', [
//       'Salosir 100mg Tablet',
//       'Salosir 100mg Tablet',
//       'Salosir 100mg Tablet'
//     ]),
//   ];

//   final List<OrderCardModel> pastOrders = [
//     OrderCardModel(
//         "assets/SellerImages/2.png",
//         'Well Life Store 2',
//         'delivered',
//         '11 June, 11: 20 am',
//         '18.00',
//         'COD',
//         ['Salosir 100mg Tablet']),
//     OrderCardModel(
//         "assets/SellerImages/3.png",
//         'Well Life Store 3',
//         'delivered',
//         '11 June, 11: 20 am',
//         '18.00',
//         'COD',
//         ['Salosir 100mg Tablet']),
//     OrderCardModel(
//         "assets/SellerImages/4.png",
//         'Well Life Store 4',
//         'delivered',
//         '11 June, 11: 20 am',
//         '18.00',
//         'COD',
//         ['Salosir 100mg Tablet']),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     final auth = Provider.of<Auth>(context);
//     final height = MediaQuery.of(context).size.height * .9;
//     return Scaffold(
//       appBar: AppBar(
//         // leading: IconButton(
//         //     onPressed: () => Navigator.pop(context),
//         //     icon: Icon(Icons.chevron_left)),
//         title: Text(
//           locale.recentOrders!,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText2!
//               .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//         ),
//         textTheme: Theme.of(context).textTheme,
//         centerTitle: true,
//       ),
//       body: FadedSlideAnimation(
//         // auth.avialableOrders.isEmpty
//         //     ? RefreshIndicator(
//         //         color: Theme.of(context).primaryColor,
//         //         onRefresh: () async {
//         //           await auth.getTransactions();
//         //           return;
//         //         },
//         //         child: ListView(
//         //             physics: AlwaysScrollableScrollPhysics(),
//         //             children: [
//         //               SizedBox(
//         //                 height: 200,
//         //               ),
//         //               Icon(
//         //                 Icons.library_books_rounded,
//         //                 size: 100,
//         //                 color: Colors.grey,
//         //               ),
//         //               Spacer(),
//         //               Text(
//         //                 locale.no_orders!,
//         //                 style: TextStyle(
//         //                   color: Colors.grey,
//         //                 ),
//         //                 textAlign: TextAlign.center,
//         //               ),
//         //               Spacer(
//         //                 flex: 8,
//         //               ),
//         //             ]),
//         //       )

//         //     :
//         RefreshIndicator(
//           color: Theme.of(context).primaryColor,
//           onRefresh: () async {
//             await auth.getTransactions();
//             return;
//           },
//           child: ListView(
//             // physics: AlwaysScrollableScrollPhysics(),
//             children: auth.avialableOrders.isEmpty
//                 ? [
//                     SizedBox(
//                       height: height * .38,
//                     ),
//                     Icon(
//                       Icons.library_books_rounded,
//                       size: 100,
//                       color: Colors.grey,
//                     ),
//                     SizedBox(
//                       height: height * .04,
//                     ),
//                     Text(
//                       locale.no_orders!,
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     // Spacer(
//                     //   flex: 8,
//                     // ),
//                   ]
//                 : [
//                     // Container(
//                     //   padding: EdgeInsets.all(16),
//                     //   child: Text(
//                     //     locale.inProcess!,
//                     //     style: Theme.of(context)
//                     //         .textTheme
//                     //         .bodyText1!
//                     //         .copyWith(fontSize: 13.5, color: Color(0xffb3b3b3)),
//                     //   ),
//                     //   color: Theme.of(context).dividerColor,
//                     // ),
//                     // ListView.builder(
//                     //   physics: NeverScrollableScrollPhysics(),
//                     //   itemCount: inProcessOrders.length,
//                     //   shrinkWrap: true,
//                     //   itemBuilder: (context, index) =>
//                     //       OrderCard(inProcessOrders[index]),
//                     // ),
//                     // Container(
//                     //   padding: EdgeInsets.all(16),
//                     //   child: Text(
//                     //     locale.past!,
//                     //     style: Theme.of(context)
//                     //         .textTheme
//                     //         .bodyText1!
//                     //         .copyWith(fontSize: 13.5, color: Color(0xffb3b3b3)),
//                     //   ),
//                     //   color: Theme.of(context).dividerColor,
//                     // ),
//                     ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: auth.avialableOrders.length,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) =>
//                           OrderCard(auth.avialableOrders[index]),
//                     ),
//                   ],
//           ),
//         ),
//         beginOffset: Offset(0, 0.3),
//         endOffset: Offset(0, 0),
//         slideCurve: Curves.linearToEaseOut,
//       ),
//     );
//   }
// }

// class OrderCard extends StatelessWidget {
//   final Order orderCard;

//   OrderCard(this.orderCard);

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context);
//     return GestureDetector(
//       onTap: () {
//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //         builder: (context) => OrderInfoPage(orderCard: orderCard)));
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListTile(
//             leading: orderCard.brandImage == ''
//                 ? Image.asset("assets/SellerImages/2.png", height: 40)
//                 : Image.network(orderCard.brandImage!, height: 40),
//             title: Row(
//               children: [
//                 Text(
//                   orderCard.brandName!,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(color: black2, fontWeight: FontWeight.bold),
//                 ),
//                 Spacer(),
//                 Text(
//                   orderCard.price.toString() + ' Egp',
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(fontSize: 12, color: Color(0xffb3b3b3)),
//                 ),
//               ],
//             ),
//             subtitle: Row(
//               children: [
//                 Text(
//                   orderCard.createdAt!.toString(),
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(fontSize: 12, color: Color(0xffb3b3b3)),
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: SvgPicture.asset(
//                     'assets/coin.svg',
//                     // color: Colors.green,
//                   ),
//                 ),
//                 Text(" " + orderCard.transactionPoint.toString(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(fontSize: 12, color: Color(0xffb3b3b3))),
//               ],
//             ),
//           ),
//           // ListView.builder(
//           //   physics: NeverScrollableScrollPhysics(),
//           //   itemCount: orderCard.medicines.length,
//           //   padding: EdgeInsetsDirectional.fromSTEB(72, 0, 0, 20),
//           //   shrinkWrap: true,
//           //   itemBuilder: (context, innerIndex) => Text(
//           //     orderCard.medicines[innerIndex],
//           //     style: Theme.of(context)
//           //         .textTheme
//           //         .bodyText1!
//           //         .copyWith(height: 1.8, fontSize: 13.5, color: black2),
//           //   ),
//           // ),
//           // if (orderCard.status.toLowerCase() == 'delivered')
//           //   Align(
//           //     alignment: AlignmentDirectional.topEnd,
//           //     child: TextButton(
//           //         onPressed: () =>
//           //             Navigator.pushNamed(context, PageRoutes.reviewOrderPage),
//           //         child: Text(
//           //           locale!.reviewNow!,
//           //           style: Theme.of(context)
//           //               .textTheme
//           //               .bodyText1!
//           //               .copyWith(color: Theme.of(context).primaryColor),
//           //         )),
//           //   ),

//           Divider(thickness: 6, height: 0),
//         ],
//       ),
//     );
//   }
// }
