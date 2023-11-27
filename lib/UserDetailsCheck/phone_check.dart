// import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:m3ak_user/UserDetailsCheck/verification_check.dart';
// import 'package:provider/provider.dart';

// import '../Auth/Registration/UI/registration_page.dart';
// import '../Components/custom_button.dart';
// import '../Components/entry_field.dart';
// import '../Locale/locale.dart';
// import '../Providers/auth.dart';
// import '../Providers/global_provider.dart';
// import '../widgets/custom_dialog.dart';
// import '../widgets/error_dialog.dart';

// class PhoneCheck extends StatefulWidget {
//   const PhoneCheck({Key? key}) : super(key: key);

//   @override
//   State<PhoneCheck> createState() => _PhoneCheckState();
// }

// class _PhoneCheckState extends State<PhoneCheck> {
//   final TextEditingController _phoneController = TextEditingController();
//   bool loading = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final height = size.height - notch;
//     final width = size.width;
//     var locale = AppLocalizations.of(context)!;
//     var global = Provider.of<GlobalProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.red,
//         // toolbarHeight:  ,
//         title: Text(
//           locale.enterMobileNumber!,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText2!
//               .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//         ),
//         textTheme: Theme.of(context).textTheme,
//         centerTitle: true,
//         // leading: IconButton(
//         //     onPressed: () => global.previousPage(),
//         //     icon: Icon(Icons.chevron_left)),
//       ),
//       body: FadedSlideAnimation(
//         SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child: Container(
//             height: height,
//             padding: EdgeInsets.symmetric(horizontal: width * .05),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Spacer(),
//               Text(
//                 locale.yourPhoneNumberNotRegistered!,
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     color: Theme.of(context).disabledColor, fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//               Spacer(flex: 2),
//               EntryField(
//                 prefixIcon: Icons.phone_iphone,
//                 hint: locale.mobileNumber,
//                 readOnly: false,
//                 controller: _phoneController,
//                 numbersOnly: true,
//                 // allowSpace: false,
//                 maxLength: 11,
//                 // autoCheck: true,
//                 // maxLength: auth.phoneNumberController.text.startsWith("+")
//                 //     ? 13
//                 //     : 11,
//                 textInputType: TextInputType.phone,
//               ),
//               SizedBox(height: 20.0),
//               loading
//                   ? CircularProgressIndicator(
//                       color: Theme.of(context).primaryColor,
//                     )
//                   : CustomButton(
//                       label: locale.continuee,
//                       onTap: () async {
//                         setState(() {
//                           loading = true;
//                         });
//                         final auth = Provider.of<Auth>(context, listen: false);

//                         final res =
//                             await auth.checkPhone(_phoneController.text);
//                         setState(() {
//                           loading = false;
//                         });

//                         if (res && auth.otpReason != 'update') {
//                           Navigator.push<void>(
//                             context,
//                             MaterialPageRoute<void>(
//                               builder: (BuildContext context) =>
//                                   VerificationCheck(
//                                 mobileNumber: _phoneController.text,
//                               ),
//                             ),
//                           );
//                         } else {
//                           showDialog(
//                             context: context,
//                             barrierDismissible: true,
//                             builder: (BuildContext context) {
//                               return CustomDialog(
//                                 title: auth.otpReason == 'reset password'
//                                     ? locale.forgetPassword!
//                                     : auth.otpReason.toUpperCase(),
//                                 msg: locale.forget_password_error!,
//                                 icon: Icon(
//                                   Icons.error_outline_rounded,
//                                   size: width * .15,
//                                   color: Colors.red,
//                                 ),
//                                 mainAction: TextButton(
//                                     style: TextButton.styleFrom(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 40, vertical: 14),
//                                       backgroundColor:
//                                           Theme.of(context).primaryColor,
//                                     ),
//                                     onPressed: () {
//                                       // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
//                                       Navigator.pop(context);
//                                       Navigator.pop(context);
//                                       Navigator.push<void>(
//                                         context,
//                                         MaterialPageRoute<void>(
//                                           builder: (BuildContext context) =>
//                                               RegistrationPage(),
//                                         ),
//                                       );
//                                     },
//                                     child: Text(
//                                       locale.registerNow!,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1!
//                                           .copyWith(
//                                               color: Theme.of(context)
//                                                   .scaffoldBackgroundColor),
//                                     )),
//                                 secondAction: TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text(
//                                       locale.cancel!,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1!
//                                           .copyWith(
//                                               color: Theme.of(context)
//                                                   .primaryColor),
//                                     )),
//                               );
//                             },
//                           );
//                         }
//                       },
//                     ),
//               SizedBox(height: 30.0),
//               Text(
//                 locale.wellSendAnOTP!,
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     color: Theme.of(context).disabledColor, fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//               Spacer(flex: 12),
//             ]),
//           ),
//         ),
//         beginOffset: Offset(0, 0.3),
//         endOffset: Offset(0, 0),
//         slideCurve: Curves.linearToEaseOut,
//       ),
//     );
//   }
// }
