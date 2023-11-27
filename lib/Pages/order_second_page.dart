import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/Pages/add_child_page_second.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/address.dart';
import '../widgets/custom_dialog.dart';

class OrderSecondPage extends StatefulWidget {
  File? firstSelectedImg;
  File? secondSelectedImg;
  File? thirdSelectedImg;
  String? details;
  OrderSecondPage(
      {this.firstSelectedImg,
      this.secondSelectedImg,
      this.thirdSelectedImg,
      this.details});
  @override
  State<OrderSecondPage> createState() => _OrderSecondPageState();
}

class _OrderSecondPageState extends State<OrderSecondPage> {
  bool _loading = false;

  void showToast(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      // padding: EdgeInsets.all(5),
    ));
  }

  String? phoneNumber;
  String? selectedPhoneNumber;
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final menu = Provider.of<MenuProvider>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final auth = Provider.of<Auth>(context, listen: true);

    AddressElement? selected = auth.avialableAddresses.isEmpty
        ? null
        : auth.selectedAddress == null
            ? auth.avialableAddresses[0]
            : auth.selectedAddress;

    // String userPhoneNumber = auth.theUser!.phoneNumber!;

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.quickPayment!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: FadedSlideAnimation(
        ListView(children: [
          SizedBox(
            height: height * .01,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(locale.address!),
                    selected == null
                        ? Text('')
                        : TextButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder: (BuildContext
                                          context,
                                      StateSetter
                                          setModalState /*You can rename this!*/) {
                                    return Container(
                                      height: height * .4,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            height: height * .02,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * .2,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: height * .02,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            height: height * .35,
                                            child: ListView.builder(
                                                itemCount: auth
                                                    .avialableAddresses.length,
                                                shrinkWrap: false,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);

                                                      auth.setSelectedAddressId(
                                                          auth.avialableAddresses[
                                                              index]);
                                                      setState(() {
                                                        selected =
                                                            auth.avialableAddresses[
                                                                index];
                                                      });
                                                      setModalState(() {});
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        // borderRadius:
                                                        //     BorderRadius.circular(12),
                                                        color: selected!.id ==
                                                                auth
                                                                    .avialableAddresses[
                                                                        index]
                                                                    .id
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          top: 6.0),
                                                      child: ListTile(
                                                        tileColor: selected!
                                                                    .id ==
                                                                auth
                                                                    .avialableAddresses[
                                                                        index]
                                                                    .id
                                                            ? Colors.black
                                                            : Colors.white,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        12),
                                                        leading: Column(
                                                          children: [
                                                            Icon(
                                                              (auth.avialableAddresses[index].title ==
                                                                          "Home" ||
                                                                      auth.avialableAddresses[index].title ==
                                                                          "Home")
                                                                  ? Icons.home
                                                                  : (auth.avialableAddresses[index].title ==
                                                                              "Office" ||
                                                                          auth.avialableAddresses[index].title ==
                                                                              "Office")
                                                                      ? Icons
                                                                          .local_post_office
                                                                      : Icons
                                                                          .other_houses_outlined,
                                                              color: selected!
                                                                          .id ==
                                                                      auth
                                                                          .avialableAddresses[
                                                                              index]
                                                                          .id
                                                                  ? Colors.black
                                                                  : Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              size: 24,
                                                            ),
                                                          ],
                                                        ),
                                                        title: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 8.0),
                                                          child: Text(
                                                              auth
                                                                  .avialableAddresses[
                                                                      index]
                                                                  .title,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              auth
                                                                  .avialableAddresses[
                                                                      index]
                                                                  .address,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color(
                                                                          0xff666666)),
                                                            ),
                                                            Text(
                                                              auth
                                                                  .avialableAddresses[
                                                                      index]
                                                                  .latitude
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color(
                                                                          0xff666666)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: AutoSizeText(
                              locale.change!,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                  ],
                ),
                selected == null
                    ? TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PageRoutes.locationPage);
                        },
                        child: AutoSizeText(
                          locale.addNewAddress!,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )
                    : ListTile(
                        tileColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                        leading: Column(
                          children: [
                            Icon(
                              Icons.home,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                          ],
                        ),
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(selected!.title,
                              style: Theme.of(context).textTheme.bodyText1!),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selected!.address,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 13, color: Color(0xff666666)),
                            ),
                            Text(
                              selected!.latitude.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 13, color: Color(0xff666666)),
                            ),
                          ],
                        ),
                      )
              ],
            ),
            //  child: ,
          ),
          SizedBox(
            height: height * .01,
          ),
          Container(
            // width: width * .75,
            height: 10,
            color: Colors.grey.withOpacity(.3),
          ),
          SizedBox(
            height: height * .02,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              width: width * .15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("للتواصل معك"),
                  SizedBox(
                    height: height * .01,
                  ),
                  AutoSizeText(
                    "اختر الطريقه المناسبه  للتواصل",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // width: width * .4,
                        child: CustomButton(
                          shrink: true,
                          // label: auth.theUser!.phoneNumber,
                          iconGap: 5,
                          textColor: selectedPhoneNumber == null
                              ? Colors.white
                              : Colors.black,
                          color: selectedPhoneNumber == null
                              ? null
                              : Colors.grey.withOpacity(.4),
                          textSize: 14,
                          icon: RotatedBox(
                            child: Icon(
                              Icons.call_outlined,
                              color: selectedPhoneNumber == null
                                  ? Colors.white
                                  : Colors.black,
                              size: width * .055,
                            ),
                            quarterTurns:
                                locale.locale.languageCode == "en" ? 0 : 3,
                          ),
                        ),
                      ),
                      SizedBox(
                        // width: width * .4,
                        child: CustomButton(
                          color: selectedPhoneNumber == phoneNumber &&
                                  phoneNumber != null
                              ? null
                              : Colors.grey.withOpacity(.4),
                          shrink: true,
                          label: phoneNumber == null
                              ? locale.mobileNumber
                              : phoneNumber,
                          textSize: 14,
                          textColor: Colors.black,
                          iconGap: 5,
                          icon: RotatedBox(
                            child: Icon(
                              Icons.add_call,
                              color: Colors.black,
                              size: width * .055,
                            ),
                            quarterTurns:
                                locale.locale.languageCode == "en" ? 0 : 3,
                          ),
                          onTap: () {
                            showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (BuildContext
                                        context,
                                    StateSetter
                                        setModalState /*You can rename this!*/) {
                                  return Container(
                                    height: height * .4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          height: height * .02,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          width: width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * .2,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: height * .02,
                                          color: Colors.white,
                                        ),
                                        Container(
                                            height: height * .35,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * .05),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10.0),
                                                EntryField(
                                                  onValidate: (value) {
                                                    // print(""locale.locale);
                                                    if (value!.length < 11) {
                                                      print("english");
                                                      return locale
                                                          .phoneVerification
                                                          .toString()
                                                          .toLowerCase();
                                                    }
                                                    return null;
                                                  },
                                                  obscure: false,
                                                  hint: locale.mobileNumber,
                                                  prefixIcon: Icons.add_call,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  controller: phoneController,
                                                ),
                                                SizedBox(height: 10.0),
                                                CustomButton(
                                                  onTap: () {
                                                    // onSubmit();
                                                    setState(() {
                                                      phoneNumber =
                                                          phoneController
                                                                  .text.isEmpty
                                                              ? null
                                                              : phoneController
                                                                  .text;
                                                      selectedPhoneNumber =
                                                          phoneNumber;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  // shrink: false,
                                                ),
                                                // Spacer(),
                                              ],
                                            )),
                                      ],
                                    ),
                                  );
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: height * .02,
          ),
          Container(
            // width: width * .75,
            height: 10,
            color: Colors.grey.withOpacity(.3),
          ),
          SizedBox(
            height: height * .02,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              width: width * .15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(locale.selectPaymentMethod!),
                  SizedBox(
                    height: height * .01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .05, vertical: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(.4)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.money,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AutoSizeText(locale.cashOnDelivery!),
                          ],
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  )
                ],
              )),
          SizedBox(
            height: height * .02,
          ),
          Container(
            // width: width * .75,
            height: 10,
            color: Colors.grey.withOpacity(.3),
          ),
          SizedBox(
            height: height * .02,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              // width: width * .15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  AutoSizeText("سوف نعلمك عندما يتم فبول طلبك "),
                  SizedBox(
                    height: height * .02,
                  ),
                  _loading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : CustomButton(
                          label: locale.order_now!,
                          onTap: () async {
                            // print(widget.firstSelectedImg!.path);
                            // if (selected == null) {
                            //   showToast(locale.addNewAddress);
                            // } else {
                            //   setState(() {
                            //     _loading = true;
                            //   });
                            //   // var res = await auth.PlaceOrder(
                            //   //         widget.details!,
                            //   //         menu.callCenterBranch == null
                            //   //             ? menu.selectedNonCallCenterBranch!.id
                            //   //             : menu.callCenterBranch!.id,
                            //   //         selectedPhoneNumber,
                            //   //         selected!.id,
                            //   //         widget.firstSelectedImg == null
                            //   //             ? []
                            //   //             : widget.secondSelectedImg == null
                            //   //                 ? [widget.firstSelectedImg]
                            //   //                 : widget.thirdSelectedImg == null
                            //   //                     ? [
                            //   //                         widget.firstSelectedImg,
                            //   //                         widget.secondSelectedImg,
                            //   //                       ]
                            //   //                     : [
                            //   //                         widget.firstSelectedImg,
                            //   //                         widget.secondSelectedImg,
                            //   //                         widget.thirdSelectedImg
                            //   //                       ],
                            //   //         locale.locale.languageCode)
                            //       .catchError((error, stackTrace) {
                            //     setState(() {
                            //       _loading = false;
                            //     });
                            //     showDialog(
                            //       context: context,
                            //       barrierDismissible: true,
                            //       builder: (BuildContext context) {
                            //         return CustomDialog(
                            //           title: locale.error_text!,
                            //           msg: locale.error_text!,
                            //           icon: Icon(
                            //             Icons.error_outline_rounded,
                            //             size: width * .15,
                            //             color: Colors.red,
                            //           ),
                            //           mainAction: TextButton(
                            //               style: TextButton.styleFrom(
                            //                 padding: EdgeInsets.symmetric(
                            //                     horizontal: 40, vertical: 14),
                            //                 backgroundColor:
                            //                     Theme.of(context).primaryColor,
                            //               ),
                            //               onPressed: () {
                            //                 Navigator.pop(context);
                            //               },
                            //               child: Text(
                            //                 locale.ok!,
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyText1!
                            //                     .copyWith(
                            //                         color: Theme.of(context)
                            //                             .scaffoldBackgroundColor),
                            //               )),
                            //         );
                            //       },
                            //     );
                            //   });
                            //   setState(() {
                            //     _loading = false;
                            //   });
                            //   if (res) {
                            //     Navigator.pop(context);
                            //     Navigator.pop(context);
                            //     showDialog(
                            //       context: context,
                            //       barrierDismissible: true,
                            //       builder: (BuildContext context) {
                            //         return CustomDialog(
                            //           title: locale.orderConfirmed!,
                            //           msg: locale.orderConfirmed!,
                            //           icon: Icon(
                            //             Icons.done,
                            //             size: width * .15,
                            //             color: Theme.of(context).primaryColor,
                            //           ),
                            //           mainAction: TextButton(
                            //               style: TextButton.styleFrom(
                            //                 padding: EdgeInsets.symmetric(
                            //                     horizontal: 40, vertical: 14),
                            //                 backgroundColor:
                            //                     Theme.of(context).primaryColor,
                            //               ),
                            //               onPressed: () {
                            //                 // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
                            //                 Navigator.pop(context);
                            //               },
                            //               child: Text(
                            //                 locale.ok!,
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyText1!
                            //                     .copyWith(
                            //                         color: Theme.of(context)
                            //                             .scaffoldBackgroundColor),
                            //               )),
                            //         );
                            //       },
                            //     );
                            //   } else {
                            //     showDialog(
                            //       context: context,
                            //       barrierDismissible: true,
                            //       builder: (BuildContext context) {
                            //         return CustomDialog(
                            //           title: locale.error_text!,
                            //           msg: locale.error_text!,
                            //           icon: Icon(
                            //             Icons.error_outline_rounded,
                            //             size: width * .15,
                            //             color: Colors.red,
                            //           ),
                            //           mainAction: TextButton(
                            //               style: TextButton.styleFrom(
                            //                 padding: EdgeInsets.symmetric(
                            //                     horizontal: 40, vertical: 14),
                            //                 backgroundColor:
                            //                     Theme.of(context).primaryColor,
                            //               ),
                            //               onPressed: () {
                            //                 Navigator.pop(context);
                            //               },
                            //               child: Text(
                            //                 locale.ok!,
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyText1!
                            //                     .copyWith(
                            //                         color: Theme.of(context)
                            //                             .scaffoldBackgroundColor),
                            //               )),
                            //         );
                            //       },
                            //     );
                            //   }
                            // }
                          },
                        )
                ],
              )),
          SizedBox(
            height: height * .02,
          ),
        ]),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
