// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Auth/Login/UI/login_page.dart';
// import 'package:m3ak_user/BottomNavigation/bottom_navigation.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/UserDetailsCheck/phone_check.dart';
// import 'package:m3ak_user/wrappers/wrapper_choose_city.dart';
// import 'package:m3ak_user/wrappers/wrapper_home.dart';

// import 'package:provider/provider.dart';

// import '../Pages/splash_screen.dart';
// import '../UserDetailsCheck/main_check.dart';
// // import '../providers/auth.dart';

// class WrapperPhoneCheck extends StatefulWidget {
//   static const routeName = '/wrapper_phone';

//   @override
//   _WrapperPhoneCheckState createState() => _WrapperPhoneCheckState();
// }

// class _WrapperPhoneCheckState extends State<WrapperPhoneCheck> {
//   @override
//   Widget build(BuildContext ctx) {
//     print("WrapperPhoneCheck");
//     final auth = Provider.of<Auth>(context, listen: true);

//     bool checked = auth.theUser!.phoneNumber != '';
//     return checked ? WrapperChooseCity() : PhoneCheck();
//   }
// }
