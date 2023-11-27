// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Auth/Verification/UI/verifiaction_page.dart';
// import 'package:m3ak_user/Auth/Verification/UI/verification_ui.dart';
// import 'package:m3ak_user/Providers/global_provider.dart';
// import 'package:m3ak_user/UserDetailsCheck/choose_city.dart';
// import 'package:m3ak_user/UserDetailsCheck/form_check.dart';
// import 'package:m3ak_user/UserDetailsCheck/invitation_check.dart';
// import 'package:m3ak_user/UserDetailsCheck/phone_check.dart';
// import 'package:m3ak_user/UserDetailsCheck/verification_check.dart';
// import 'package:provider/provider.dart';

// import '../Locale/locale.dart';
// import '../Providers/auth.dart';

// class MainCheck extends StatefulWidget {
//   const MainCheck({Key? key}) : super(key: key);

//   @override
//   State<MainCheck> createState() => _MainCheckState();
// }

// class _MainCheckState extends State<MainCheck> {
//   List<Widget> screens = [
//     PhoneCheck(),
//     VerificationCheck(),
//     ChooseCity(),
//     InvitaionCheck(),
//     FormCheck(),
//   ];
//   @override
//   void initState() {
//     final auth = Provider.of<Auth>(context, listen: false);
//     if (auth.theUser!.phoneNumber != '') {
//       if (auth.theUser!.cityId == null &&
//           auth.theUser!.gender != '' &&
//           auth.theUser!.birthDate != null) {
//         screens = [
//           ChooseCity(),
//         ];
//       } else if (auth.theUser!.cityId == null &&
//           auth.theUser!.gender == '' &&
//           auth.theUser!.birthDate == null) {
//         screens = [
//           ChooseCity(),
//           InvitaionCheck(),
//           FormCheck(),
//         ];
//       } else if (auth.theUser!.cityId != '' &&
//           auth.theUser!.gender == '' &&
//           auth.theUser!.birthDate == null) {
//         screens = [
//           InvitaionCheck(),
//           FormCheck(),
//         ];
//       }
//     } else {
//       screens = [
//         PhoneCheck(),
//         VerificationCheck(),
//         ChooseCity(),
//         InvitaionCheck(),
//         FormCheck(),
//       ];
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final height = size.height - notch;
//     // final width = size.width;
//     // var locale = AppLocalizations.of(context)!;
//     var global = Provider.of<GlobalProvider>(context);
//     return Scaffold(
//       body: Container(
//         height: size.height,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: height,
//                 child: PageView(
//                   controller: global.mainCheckController,
//                   physics: NeverScrollableScrollPhysics(),
//                   children: screens,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
