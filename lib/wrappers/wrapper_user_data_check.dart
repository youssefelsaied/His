// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:m3ak_user/UserDetailsCheck/form_check.dart';
// import 'package:m3ak_user/wrappers/wrapper_home.dart';

// import 'package:provider/provider.dart';

// // import '../providers/auth.dart';

// class WrapperUserDataCheck extends StatefulWidget {
//   static const routeName = '/wrapper_user_data';

//   @override
//   _WrapperUserDataCheckState createState() => _WrapperUserDataCheckState();
// }

// class _WrapperUserDataCheckState extends State<WrapperUserDataCheck> {
//   @override
//   Widget build(BuildContext ctx) {
//     final auth = Provider.of<Auth>(context, listen: true);

//     bool checked =
//         auth.theUser!.gender != '' && auth.theUser!.birthDate != null;
//     return checked ? WrapperHome() : FormCheck();
//   }
// }
