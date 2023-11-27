import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Pages/sub_category_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/menu.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BottomNavigation/Data/data.dart';
import '../Dialogs/deleteDialog.dart';
import '../Locale/locale.dart';
import '../Pages/sub_sub_category_page.dart';
import '../Routes/routes.dart';
import '../Theme/colors.dart';

class FamilyChildWidget extends StatefulWidget {
  const FamilyChildWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FamilyChildWidget> createState() => _FamilyChildWidgetState();
}

class _FamilyChildWidgetState extends State<FamilyChildWidget> {
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
    final auth = Provider.of<Auth>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        // var getPendingFamilyRequests = auth.getPendingFamilyRequests();
        // var getFamilyMembers = auth.getFamilyMembers();
        // var getFamilyChildren = auth.getFamilyChildren();
        // List responses = await Future.wait(
        //     [getPendingFamilyRequests, getFamilyChildren, getFamilyMembers]);
        // responses;
        return;
      },
      child: ListView(
        children: [
          Center(child: AutoSizeText(locale.please_add_children_less14!)),
          auth.children.isEmpty
              ? Center(
                  child: Column(
                  children: [
                    SizedBox(
                      height: height * .2,
                    ),
                    AutoSizeText(locale.no_children!),
                  ],
                ))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: auth.children.length,
                  itemBuilder: (context, index) {
                    final f = new DateFormat('yyyy-MM-dd');

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
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      await Future.delayed(
                                          Duration(microseconds: 500));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FadedScaleAnimation(
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                width * .125,
                                              ),
                                              child: Container(
                                                width: width * .15,
                                                height: width * .15,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      width * .15,
                                                    )),
                                                child: Text(
                                                  auth.children[index].name
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                          durationInMilliseconds: 400,
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * .05),
                                            width: width * .65,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  auth.children[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: black2,
                                                          height: 1.7,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                AutoSizeText(
                                                  f
                                                      .format(auth
                                                          .children[index]
                                                          .birthday!)
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        color: black2,
                                                        height: 1.7,
                                                        fontSize: 13,
                                                      ),
                                                ),
                                              ],
                                            )),
                                        auth.myPackage!.transaction!
                                            ? Container(
                                                // width: width * .1,
                                                child: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return DeleteDialog(
                                                            id: auth
                                                                .children[index]
                                                                .id
                                                                .toString(),
                                                            member: false,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              )
                                            : Container()
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
                          ],
                        ),
                      ],
                    );
                  },
                ),
        ],
      ),
    );
  }
}
