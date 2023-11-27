import 'dart:io';
import 'dart:ui';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Locale/locale.dart';
import '../Theme/colors.dart';

class CustomDialog extends StatelessWidget {
  Icon icon;
  String title;
  String msg;
  Widget? mainAction;
  Widget? secondAction;
  CustomDialog(
      {Key? key,
      required this.msg,
      required this.title,
      required this.icon,
      this.mainAction,
      this.secondAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final notch = MediaQuery.of(context).padding.top;
    final height = size.height - notch;
    final width = size.width;

    var locale = AppLocalizations.of(context)!;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              Container(child: icon),
              durationInMilliseconds: 400,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Theme.of(context).primaryColor, fontSize: 18.2),
            ),
            SizedBox(
              height: 20,
            ),
            Text(msg,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 15, color: black2)),
            SizedBox(height: 20),
            // TextButton(
            // style: TextButton.styleFrom(
            //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            //   backgroundColor: Theme.of(context).primaryColor,
            // ),
            //     onPressed: () {
            //       // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
            //     },
            //     child: Text(
            //       locale.uploadPrescription!,
            //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
            //           color: Theme.of(context).scaffoldBackgroundColor),
            //     )),

            mainAction == null
                ? Container()
                : SizedBox(width: width * .45, child: mainAction!),
            secondAction == null ? Container() : secondAction!
            // TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     child: Text(
            //       locale.cancel!,
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyText1!
            //           .copyWith(color: Theme.of(context).primaryColor),
            //     )),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

//     return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Dialog(
//           backgroundColor: Theme.of(context).primaryColor,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           child: Container(
// //        color: Colors.black45,
//             width: width,
//             height: height * .4,
//             // padding: EdgeInsets.all(15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: width,
//                   height: height * .08,
//                   padding: EdgeInsets.symmetric(horizontal: 1),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(15),
//                           topRight: Radius.circular(15))),
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Poppins',
//                         fontSize: width * .04),
//                   ),
//                 ),
//                 Container(
//                   width: width,
//                   height: height * .32,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).backgroundColor,
//                       borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(15),
//                           bottomLeft: Radius.circular(15))),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: width * .01),
//                           child: Icon(
//                             Icons.check,
//                             size: width * .15,
//                             color: Theme.of(context).primaryColor,
//                           )),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: width * .01),
//                         child: Text(
//                           msg,
//                           style: TextStyle(
//                               color: Colors.black87,
//                               fontFamily: 'Poppins',
//                               fontSize: width * .05),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       TextButton(
//                         style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsets>(
//                               EdgeInsets.symmetric(horizontal: width * .1)),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16.0),
//                               side: BorderSide(
//                                   color: Theme.of(context).primaryColor),
//                             ),
//                           ),
//                         ),
//                         child: Text(
//                           "Ok",
//                           style:
//                               TextStyle(color: Theme.of(context).primaryColor),
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));

}
