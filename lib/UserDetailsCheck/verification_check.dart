// import 'dart:async';
// import 'dart:io';
// import 'dart:math';

// import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:m3ak_user/Pages/reset_password_page.dart';
// import 'package:m3ak_user/wrappers/wrapper_choose_city.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../Components/custom_button.dart';
// import '../Components/entry_field.dart';
// import '../Locale/locale.dart';
// import '../Providers/auth.dart';
// import '../Providers/global_provider.dart';
// import '../data/user.dart' as s;
// import '../widgets/otp_input.dart';
// import '../wrappers/wrapper_auth.dart';

// class VerificationCheck extends StatefulWidget {
//   final String mobileNumber;
//   const VerificationCheck({Key? key, required this.mobileNumber})
//       : super(key: key);

//   @override
//   State<VerificationCheck> createState() => _VerificationCheckState();
// }

// class _VerificationCheckState extends State<VerificationCheck> {
//   final TextEditingController _otpController = TextEditingController();
//   int _counter = 59;
//   late Timer _timer;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   bool isCodeSent = false;

//   String? phoneNo;
//   String? smsCode;
//   String? _verificationId;
//   _startTimer() {
//     _counter = 59; //time counter
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _counter > 0 ? _counter-- : _timer.cancel();
//       });
//     });
//   }

//   void _onVerifyCode() async {
//     // setState(() {
//     //   isCodeSent = true;
//     // });
//     final PhoneVerificationCompleted verificationCompleted =
//         (AuthCredential phoneAuthCredential) {
//       print("PhoneVerificationCompleted");
//       // _firebaseAuth
//       //     .signInWithCredential(phoneAuthCredential)
//       //     .then((UserCredential value) async {
//       //   if (value.user != null) {
//       //     handle(value);

//       //     // // Handle loogged in state
//       //     // final auth = Provider.of<Auth>(context, listen: false);
//       //     // print(value.user!.phoneNumber);
//       //     // // auth.verifiedPhone = value.user!.phoneNumber;
//       //     // showToast("valid OTP", Colors.red, context);
//       //     // String num;
//       //     // if (value.user!.phoneNumber.toString().startsWith("+2")) {
//       //     //   num = value.user!.phoneNumber.toString();
//       //     // } else {
//       //     //   num = "+2" + value.user!.phoneNumber.toString();
//       //     // }
//       //     // if (auth.otpReason == "reset password") {
//       //     //   print("reset password");

//       //     //   Navigator.pushReplacement<void, void>(
//       //     //     context,
//       //     //     MaterialPageRoute<void>(
//       //     //       builder: (BuildContext context) => ResetPasswordPage(
//       //     //         phoneNumber: num.replaceRange(0, 2, ""),
//       //     //       ),
//       //     //     ),
//       //     //   );
//       //     // } else if (auth.otpReason == "signup") {
//       //     //   print("verfied signup");
//       //     //   final res = await auth.signUp();
//       //     //   if (res == true) {
//       //     //     Phoenix.rebirth(context);
//       //     //     // auth.resetFields();
//       //     //     // Navigator.of(context).pushReplacementNamed(WrapperAuth.routeName);
//       //     //   }
//       //     // } else if (auth.otpReason == "update") {
//       //     //   print("verfied number");
//       //     //   Navigator.pop(context);
//       //     //   Navigator.pushReplacement<void, void>(
//       //     //     context,
//       //     //     MaterialPageRoute<void>(
//       //     //       builder: (BuildContext context) => WrapperChooseCity(),
//       //     //     ),
//       //     //   );
//       //     // } else {
//       //     //   showToast(
//       //     //       "Error validating OTP, try again Later", Colors.red, context);
//       //     //   setState(() {
//       //     //     loading = false;
//       //     //   });
//       //     // }
//       //   } else {
//       //     showToast("Error validating OTP, try again", Colors.red, context);
//       //   }
//       // }).catchError((error) {
//       //   showToast("Try again in sometime", Colors.red, context);
//       // });
//     };
//     final PhoneVerificationFailed verificationFailed = (authException) {
//       showToast(authException.message, Colors.red, context);
//       setState(() {
//         isCodeSent = false;
//       });
//     };

//     final PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       print("code sent");
//       _verificationId = verificationId;
//       setState(() {
//         _verificationId = verificationId;
//       });
//     };
//     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       // _verificationId = verificationId;
//       // setState(() {
//       //   _verificationId = verificationId;
//       // });
//     };

//     // TODO: Change country code

//     await _firebaseAuth.verifyPhoneNumber(
//       phoneNumber: "+2${widget.mobileNumber}",
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: verificationCompleted,
//       verificationFailed: verificationFailed,
//       codeSent: codeSent,
//       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//     );
//   }

//   bool loading = false;
//   void showToast(message, Color color, BuildContext context) {
//     print(message);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 2),
//     ));

//     // _scaffoldKey.currentState!.showSnackBar(SnackBar(
//     //   content: Text(message),
//     //   duration: Duration(seconds: 1),
//     // ));
//   }

//   void _onFormSubmitted() async {
//     setState(() {
//       loading = true;
//     });
//     if (_verificationId != null) {
//       print("in................");
//       print("_verificationId is $_verificationId");
//       // print("sms code is ${_pinEditingController.text}");
//       AuthCredential _authCredential = PhoneAuthProvider.credential(
//         verificationId: _verificationId!,
//         smsCode: _otpController.text,
//       );
//       print("_authCredential    is  $_authCredential");
//       FirebaseAuth.instance
//           .signInWithCredential(_authCredential)
//           .then((UserCredential value) async {
//         if (value.user != null) {
//           handle(value);
//         } else {
//           showToast("Error validating OTP, try again", Colors.red, context);
//           setState(() {
//             loading = false;
//           });
//         }
//         // value.user.delete();
//       }).catchError((error) {
//         showToast(error.toString(), Colors.red, context);
//         setState(() {
//           loading = false;
//         });
//         throw error;
//       });
//     } else {
//       showToast("Something went wrong", Colors.red, context);
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   void handle(value) async {
//     // Handle loogged in state
//     final auth = Provider.of<Auth>(context, listen: false);
//     print(value.user!.phoneNumber);
//     // auth.verifiedPhone = value.user!.phoneNumber;
//     showToast("valid OTP", Colors.red, context);
//     String num;
//     if (value.user!.phoneNumber.toString().startsWith("+2")) {
//       num = value.user!.phoneNumber.toString();
//     } else {
//       num = "+2" + value.user!.phoneNumber.toString();
//     }
//     if (auth.otpReason == "reset password") {
//       print("reset password");
//       setState(() {
//         loading = false;
//       });
//       Navigator.pushReplacement<void, void>(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => ResetPasswordPage(
//             phoneNumber: num.replaceRange(0, 2, ""),
//           ),
//         ),
//       );
//     } else if (auth.otpReason == "signup") {
//       print("verfied signup");
//       final res = await auth.signUp().catchError((e) {
//         print("cetched error");
//         print(e);
//         showToast(e, Colors.red, context);
//         setState(() {
//           loading = false;
//         });
//       });
//       setState(() {
//         loading = false;
//       });
//       if (res == true) {
//         // Phoenix.rebirth(context);
//         // auth.resetFields();
//         // Navigator.of(context).pushReplacementNamed(WrapperAuth.routeName);
//         Navigator.pop(context);
//         Navigator.pushReplacement<void, void>(
//           context,
//           MaterialPageRoute<void>(
//             builder: (BuildContext context) => WrapperAuth(),
//           ),
//         );
//       } else {
//         showToast(auth.error, Colors.red, context);
//       }
//     } else if (auth.otpReason == "update") {
//       print("verfied number");
//       setState(() {
//         loading = false;
//       });
//       Navigator.pop(context);
//       Navigator.pushReplacement<void, void>(
//         context,
//         MaterialPageRoute<void>(
//           builder: (BuildContext context) => WrapperChooseCity(),
//         ),
//       );

//       // }
//     } else {
//       showToast("Error validating OTP, try again Later", Colors.red, context);
//       setState(() {
//         loading = false;
//       });
//     }
//   }

//   /// Decorate the outside of the Pin.
//   PinDecoration _pinDecoration = UnderlineDecoration(
//     enteredColor: Color(0xff0FC1A7),
//     hintText: '------',
//     hintTextStyle: TextStyle(fontSize: 18, color: Colors.grey),
//     textStyle: TextStyle(fontSize: 20, color: Color(0xff0FC1A7)),
//     color: Color(0xff0FC1A7),
//   );
//   @override
//   void initState() {
//     super.initState();
//     _onVerifyCode();

//     _startTimer();
//     // widget.verificationInteractor.verifyNumber();
//   }

//   List<Widget> _getActionButtons(String pastedText) {
//     var resultList = <Widget>[];
//     if (Platform.isIOS) {
//       resultList.addAll([
//         CupertinoDialogAction(
//           child: Text('No'),
//           onPressed: () {
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//         ),
//         CupertinoDialogAction(
//           child: Text("paste"),
//           onPressed: () {
//             _otpController.text = pastedText;
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//         ),
//       ]);
//     } else {
//       resultList.addAll([
//         TextButton(
//           child: Text("No"),
//           onPressed: () {
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//         ),
//         TextButton(
//           child: Text("paste"),
//           onPressed: () {
//             _otpController.text = pastedText;
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//         ),
//       ]);
//     }
//     return resultList;
//   }

//   Future<void> _showPasteDialog(String pastedText) {
//     final formattedPastedText =
//         pastedText.trim().substring(0, min(pastedText.trim().length, 6));

//     final defaultPastedTextStyle = TextStyle(
//       fontWeight: FontWeight.bold,
//       color: Theme.of(context).primaryColor,
//     );

//     return showDialog(
//       context: context,
//       useRootNavigator: true,
//       builder: (context) => Platform.isIOS
//           ? CupertinoAlertDialog(
//               title: Text('paste'),
//               content: RichText(
//                 text: TextSpan(
//                   text: 'do you want to paste ',
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.button!.color,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: formattedPastedText,
//                       style: defaultPastedTextStyle,
//                     ),
//                     TextSpan(
//                       text: "?",
//                       style: TextStyle(
//                         color: Theme.of(context).textTheme.button!.color,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               actions: _getActionButtons(formattedPastedText),
//             )
//           : AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               title: Text('paste'),
//               content: RichText(
//                 text: TextSpan(
//                   text: 'do you want to paste ',
//                   style: TextStyle(
//                     color: Theme.of(context).textTheme.button!.color,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: formattedPastedText,
//                       style: defaultPastedTextStyle,
//                     ),
//                     TextSpan(
//                       text: "?",
//                       style: TextStyle(
//                         color: Theme.of(context).textTheme.button!.color,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               actions: _getActionButtons(formattedPastedText),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     _otpController.dispose();
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final height = size.height - notch;
//     final width = size.width;
//     var global = Provider.of<GlobalProvider>(context);

//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         // backgroundColor: Colors.red,
//         // toolbarHeight:  ,
//         title: Text(
//           locale.phoneVerification!,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText2!
//               .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//         ),
//         textTheme: Theme.of(context).textTheme,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(Icons.chevron_left)),
//       ),
//       body: FadedSlideAnimation(
//         SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height -
//                 MediaQuery.of(context).padding.vertical,
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 Spacer(),
//                 Text(
//                   locale.forget_password_text!,
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       color: Theme.of(context).disabledColor, fontSize: 15),
//                   textAlign: TextAlign.center,
//                 ),
//                 Spacer(flex: 2),
//                 Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Directionality(
//                       textDirection: TextDirection.ltr,
//                       child: PinCodeTextField(
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         keyboardType: TextInputType.number,
//                         textStyle: TextStyle(color: Colors.black),
//                         length: 6,
//                         obscureText: false,
//                         animationType: AnimationType.fade,
//                         pinTheme: PinTheme(
//                           shape: PinCodeFieldShape.underline,
//                           borderRadius: BorderRadius.circular(5),
//                           fieldHeight: 50,
//                           fieldWidth: 40,
//                           activeFillColor: Colors.white,
//                           selectedColor: Theme.of(context).primaryColor,
//                           selectedFillColor: Colors.white,
//                           inactiveFillColor: Colors.white,
//                           inactiveColor: Theme.of(context).primaryColor,
//                         ),
//                         animationDuration: Duration(milliseconds: 300),
//                         backgroundColor: Colors.white,
//                         enableActiveFill: true,
//                         // errorAnimationController: errorController,
//                         controller: _otpController,
//                         onCompleted: (v) {
//                           print("Completed");
//                         },
//                         onChanged: (value) {
//                           print(value);
//                           setState(() {
//                             // currentText = value;
//                           });
//                         },
//                         beforeTextPaste: (text) {
//                           print("Allowing to paste $text");
//                           //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                           //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                           // showToast('pasted', Colors.blue, context);
//                           _showPasteDialog(text!);

//                           return false;
//                         },

//                         appContext: context,
//                       ),
//                     )

//                     //  PinInputTextField(
//                     //   pinLength: 6,
//                     //   enabled: true,
//                     //   decoration: _pinDecoration,
//                     //   controller: _otpController,
//                     //   autoFocus: true,
//                     //   // inputFormatter: [TextInputFormatter.],
//                     //   textInputAction: TextInputAction.done,
//                     //   onSubmit: (pin) {
//                     //     if (pin.length == 6) {
//                     //       // _onFormSubmitted();
//                     //     } else {
//                     //       showToast("Invalid OTP", Colors.red, context);
//                     //     }
//                     //   },
//                     // ),
//                     ),
//                 // EntryField(
//                 //   controller: _otpController,
//                 //   hint: locale.enter4DigitOTP,
//                 //   textAlign: TextAlign.center,
//                 //   maxLength: 6,
//                 // ),
//                 SizedBox(height: 20.0),
//                 loading
//                     ? CircularProgressIndicator(
//                         color: Theme.of(context).primaryColor,
//                       )
//                     : CustomButton(
//                         onTap: () {
//                           print(_otpController.text);
//                           _onFormSubmitted();
//                           // global.nextPage();
//                           // widget.verificationInteractor.verificationDone();
//                         },
//                         label: locale.submit,
//                       ),
//                 SizedBox(height: 30.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       '0:${_counter.toString().padLeft(2, '0')} ' +
//                           locale.min_left!,
//                       style: Theme.of(context).textTheme.subtitle1,
//                     ),
//                     CustomButton(
//                         label: locale.resend!.toUpperCase(),
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                         textColor: _counter < 1
//                             ? Theme.of(context).primaryColor
//                             : Theme.of(context).hintColor,
//                         padding: 0.0,
//                         onTap: _counter < 1
//                             ? () {
//                                 _onVerifyCode();
//                                 _startTimer();
//                               }
//                             : null),
//                   ],
//                 ),
//                 Spacer(flex: 12),
//               ],
//             ),
//           ),
//         ),
//         beginOffset: Offset(0, 0.3),
//         endOffset: Offset(0, 0),
//         slideCurve: Curves.linearToEaseOut,
//       ),
//     );
//   }
// }
