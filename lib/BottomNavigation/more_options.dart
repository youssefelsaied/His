import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:m3ak_user/Components/custom_button.dart';
import 'package:m3ak_user/Pages/family_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Theme/style.dart';
import 'package:m3ak_user/wrappers/wrapper_auth.dart';
import 'package:provider/provider.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../widgets/custom_dialog.dart';
import 'More/MarketPlace/market_recent_orders_page.dart';
import 'More/Order/recent_orders_page.dart';

class MoreOptions extends StatefulWidget {
  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  Color? color;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap, this.color);
}

class _MoreOptionsState extends State<MoreOptions> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showToast(message, Color color, BuildContext context) {
    print(message);
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final auth = Provider.of<Auth>(context);
    var locale = AppLocalizations.of(context)!;
    List<MenuTile> _menu = [
      // MenuTile(locale.viewProfile, locale.account, Icons.person, () {
      //   Navigator.pushNamed(context, PageRoutes.profilePage);
      // }, null),
      MenuTile(locale.contactUs, locale.letUsHelpYou, Icons.message_sharp, () {
        Navigator.pushNamed(context, PageRoutes.supportPage);
      }, null),
      MenuTile(locale.logout, locale.logout, Icons.exit_to_app, () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: height * .32,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: height * .07,
                        padding: EdgeInsets.symmetric(horizontal: width * .05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                // radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height * .1,
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red[100],
                          child: Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          )),
                    ),
                    // SizedBox(
                    //   height: height * .01,
                    // ),
                    Container(
                        alignment: Alignment.center,
                        height: height * .05,
                        child: Text(locale.logout_text!)),
                    Container(
                      alignment: Alignment.center,
                      height: height * .1,
                      padding: EdgeInsets.symmetric(horizontal: width * .05),
                      child: Container(
                        child: CustomButton(
                          label: locale.logout!,
                          onTap: () {
                            auth.logout();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WrapperAuth()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

        // Phoenix.rebirth(context);
      }, null),

      // MenuTile(locale.delete_account, locale.delete_account, Icons.exit_to_app,
      //     () async {
      //   bool loading = false;
      //   showDialog(
      //     context: context,
      //     barrierDismissible: true,
      //     builder: (BuildContext context) {
      //       var locale = AppLocalizations.of(context)!;

      //       return CustomDialog(
      //         title: locale.delete_account!,
      //         msg: locale.delete_account_text!,
      //         icon: Icon(
      //           Icons.error,
      //           color: Colors.red,
      //           size: width * .15,
      //         ),
      //         mainAction: loading
      //             ? Center(
      //                 child: CircularProgressIndicator(
      //                     color: Theme.of(context).primaryColor),
      //               )
      //             : TextButton(
      //                 style: TextButton.styleFrom(
      //                   padding:
      //                       EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      //                   backgroundColor: Colors.red,
      //                 ),
      //                 onPressed: () async {
      //                   // setState(() {
      //                   //   loading = true;
      //                   // });
      //                   final res = await auth.DeleteAccount();
      //                   if (res) {
      //                     Navigator.pop(context);
      //                     Navigator.pushReplacement(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => WrapperAuth()));
      //                   } else {
      //                     showToast(auth.error, Colors.red, context);
      //                   }

      //                   // setState(() {
      //                   //   loading = false;
      //                   // });
      //                   // Phoenix.rebirth(context);
      //                 },
      //                 child: Text(
      //                   locale.delete_account!,
      //                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
      //                       color: Theme.of(context).scaffoldBackgroundColor),
      //                 )),
      //         secondAction: TextButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //             child: Text(
      //               locale.cancel!,
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .bodyText1!
      //                   .copyWith(color: Theme.of(context).primaryColor),
      //             )),
      //       );
      //     },
      //   );
      // }, Colors.red[400]),
    ];
    ;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.account!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: auth.theUser == null
          ? Container()
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageRoutes.profilePageEdit);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: auth.theUser!.username.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 22,
                                      height: 1.6,
                                      color: black2)),
                          // TextSpan(
                          //     text: auth.theUser!.phoneNumber.toString(),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1!
                          //         .copyWith(
                          //             fontSize: 13.5,
                          //             color: Color(0xffb3b3b3),
                          //             height: 2)),
                        ]))
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: GridView.builder(
                      itemCount: _menu.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(8.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.6,
                          crossAxisCount: 2,
                          mainAxisExtent: 102),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: _menu[index].onTap as void Function()?,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadedScaleAnimation(
                                  Text(
                                    _menu[index].title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _menu[index].color != null
                                                ? _menu[index].color
                                                : Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _menu[index].subtitle!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 12,
                                                color: lightGreyColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      _menu[index].iconData,
                                      size: 32,
                                      color: _menu[index].color != null
                                          ? _menu[index].color!.withOpacity(.5)
                                          : Theme.of(context).highlightColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    locale.version! +
                        (Platform.isIOS
                            ? auth.iosVersionNumber
                            : auth.iosVersionNumber),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
    );
  }
}
