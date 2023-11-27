// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Auth/Login/UI/login_page.dart';
// import 'package:m3ak_user/BottomNavigation/bottom_navigation.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/wrappers/wrapper_home.dart';
// import 'package:m3ak_user/wrappers/wrapper_phone_check.dart';

// import 'package:provider/provider.dart';

// import '../Pages/splash_screen.dart';
// import '../UserDetailsCheck/main_check.dart';
// // import '../providers/auth.dart';

// class WrapperMainCheck extends StatefulWidget {
//   static const routeName = '/wrapper_auth';

//   @override
//   _WrapperMainCheckState createState() => _WrapperMainCheckState();
// }

// class _WrapperMainCheckState extends State<WrapperMainCheck> {
//   @override
//   Widget build(BuildContext ctx) {
//     final auth = Provider.of<Auth>(context, listen: true);

//     bool checked = auth.theUser!.phoneNumber != '' &&
//         auth.theUser!.gender != '' &&
//         auth.theUser!.birthDate != null &&
//         auth.theUser!.cityId != null;
//     print("checked = $checked");
//     print("1" + (auth.theUser!.phoneNumber != '').toString());
//     print("2" + (auth.theUser!.gender != '').toString());
//     print("3" + (auth.theUser!.birthDate != null).toString());
//     print("4" + (auth.theUser!.cityId != null).toString());
//     return checked ? WrapperHome() : WrapperPhoneCheck();
//   }
// }
