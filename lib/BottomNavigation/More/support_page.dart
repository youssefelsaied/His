import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Components/entry_field.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final phone1 = "01029979171";
    final phone2 = "01029979172";
    final phone3 = "01029979173";
    final phone4 = "01029979174";
    final phone5 = "01029979175";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.support!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: EdgeInsets.fromLTRB(width * .05, 0.0, width * .05, 0.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //         width: width * .44,
                  //         child: InkWell(
                  //           onTap: () {
                  // final Uri launchUri = Uri(
                  //   scheme: 'tel',
                  //   path: phone1,
                  // );
                  // launchUrl(launchUri);
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: width * .01, vertical: 10),
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                     width: width * .3,
                  //                     child: AutoSizeText(
                  //                       phone1,
                  //                       style: TextStyle(color: Colors.white),
                  //                     )),
                  //                 Icon(
                  //                   Icons.call,
                  //                   color: Colors.white,
                  //                   // size: 70,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )),
                  //     SizedBox(
                  //         width: width * .44,
                  //         child: InkWell(
                  //           onTap: () {
                  //             final Uri launchUri = Uri(
                  //               scheme: 'tel',
                  //               path: phone2,
                  //             );
                  //             launchUrl(launchUri);
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: width * .01, vertical: 10),
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                     width: width * .3,
                  //                     child: AutoSizeText(
                  //                       phone2,
                  //                       style: TextStyle(color: Colors.white),
                  //                     )),
                  //                 Icon(
                  //                   Icons.call,
                  //                   color: Colors.white,
                  //                   // size: 70,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //         width: width * .44,
                  //         child: InkWell(
                  //           onTap: () {
                  //             final Uri launchUri = Uri(
                  //               scheme: 'tel',
                  //               path: phone3,
                  //             );
                  //             launchUrl(launchUri);
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: width * .01, vertical: 10),
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                     width: width * .3,
                  //                     child: AutoSizeText(
                  //                       phone3,
                  //                       style: TextStyle(color: Colors.white),
                  //                     )),
                  //                 Icon(
                  //                   Icons.call,
                  //                   color: Colors.white,
                  //                   // size: 70,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         )),
                  //     SizedBox(
                  //         width: width * .44,
                  //         child: InkWell(
                  //           onTap: () {
                  //             final Uri launchUri = Uri(
                  //               scheme: 'tel',
                  //               path: phone4,
                  //             );
                  //             launchUrl(launchUri);
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: width * .01, vertical: 10),
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                     width: width * .3,
                  //                     child: AutoSizeText(
                  //                       phone4,
                  //                       style: TextStyle(color: Colors.white),
                  //                     )),
                  //                 Icon(Icons.call, color: Colors.white
                  //                     // size: 70,
                  //                     ),
                  //               ],
                  //             ),
                  //           ),
                  //         )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //         width: width * .44,
                  //         child: InkWell(
                  //           onTap: () {
                  //             final Uri launchUri = Uri(
                  //               scheme: 'tel',
                  //               path: phone5,
                  //             );
                  //             launchUrl(launchUri);
                  //           },
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: width * .01, vertical: 10),
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                     width: width * .3,
                  //                     child: AutoSizeText(
                  //                       phone5,
                  //                       style: TextStyle(color: Colors.white),
                  //                     )),
                  //                 Icon(Icons.call, color: Colors.white
                  //                     // size: 70,
                  //                     ),
                  //               ],
                  //             ),
                  //           ),
                  //         )),
                  //   ],
                  // ),
                  CustomButton(
                    label: locale.contactUs,
                    icon: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              child: Text(phone1),
                              onPressed: () {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phone1,
                                );
                                launchUrl(launchUri);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text(phone2),
                              onPressed: () {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phone2,
                                );
                                launchUrl(launchUri);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text(phone3),
                              onPressed: () {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phone3,
                                );
                                launchUrl(launchUri);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text(phone4),
                              onPressed: () {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phone4,
                                );
                                launchUrl(launchUri);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text(phone5),
                              onPressed: () {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phone5,
                                );
                                launchUrl(launchUri);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    // trailing: Icon(Icons.call),
                    // shrink: true,
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      locale.or!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    locale.howMayWeHelpYou!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    locale.letUsKnowUrQueriesFeedbacks!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Color(0xff7c7c7c)),
                  ),
                  Spacer(),
                  EntryField(prefixIcon: Icons.mail, hint: locale.emailAddress),
                  SizedBox(height: 12.0),
                  EntryField(
                    prefixIcon: Icons.edit,
                    hint: locale.writeYourMsg,
                    maxLines: 4,
                  ),
                  Spacer(),
                  CustomButton(
                    label: locale.submit,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  Expanded(
                    flex: 4,
                    child: FadedScaleAnimation(
                      Image.asset(
                        'assets/hero_image.png',
                      ),
                      durationInMilliseconds: 400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
