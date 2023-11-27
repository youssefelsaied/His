// import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:m3ak_user/Providers/auth.dart';
// import 'package:provider/provider.dart';

// import '../Components/custom_button.dart';
// import '../Components/custom_drop_down.dart';
// import '../Components/entry_field.dart';
// import '../Locale/locale.dart';
// import '../Providers/global_provider.dart';
// import '../Routes/routes.dart';

// class FormCheck extends StatefulWidget {
//   const FormCheck({Key? key}) : super(key: key);

//   @override
//   State<FormCheck> createState() => _FormCheckState();
// }

// class _FormCheckState extends State<FormCheck> {
//   DateTime? selectedDate;
//   String? gender;
//   GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
//   bool loading = false;

//   void showToast(message, Color color, ctx) {
//     print(message);
//     // ignore: deprecated_member_use
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 1),
//     ));
//     // Scaffold.of(ctx).showSnackBar();
//   }

//   Future<Null> _selectTime(BuildContext context) async {
//     DatePicker.showDatePicker(context,
//         showTitleActions: true,
//         maxTime: DateTime.now(),
//         minTime: DateTime(1900, 1, 1), onChanged: (date) {
//       setState(() {
//         //  time = DatePickerDateOrder.dmy;
//         setState(() {
//           selectedDate = date;
//         });
//       });
//       //date.timeZoneOffset.inHours.toString();
//     }, onConfirm: (date) {
//       setState(() {
//         selectedDate = date;
//       });
//     }, currentTime: selectedDate == null ? DateTime.now() : selectedDate);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var global = Provider.of<GlobalProvider>(context);
//     var auth = Provider.of<Auth>(context);
//     final size = MediaQuery.of(context).size;
//     final notch = MediaQuery.of(context).padding.top;
//     final height = size.height - notch;
//     final width = size.width;
//     var locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       key: key,
//       appBar: AppBar(
//         title: Text(
//           locale.additonalDetails!,
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
//                 locale.additonalDetailsText!,
//                 style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     color: Theme.of(context).disabledColor, fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//               Spacer(flex: 2),
//               EntryField(
//                 prefixIcon: Icons.calendar_month,
//                 hint: selectedDate == null
//                     ? locale.birthDate
//                     : DateFormat('yyyy-MM-dd').format(selectedDate!).toString(),
//                 readOnly: true,
//                 onTap: () {
//                   _selectTime(context);
//                 },
//               ),
//               SizedBox(height: 10.0),
//               CustomDropDown(
//                 prefixIcon: Icons.male,
//                 label: locale.gender,
//                 hint: locale.gender,
//                 items: ["Male", "Female"],
//                 initialValue: gender,
//                 onChanged: (value) {
//                   setState(() {
//                     gender = value;
//                   });
//                 },

//                 // suffixIcon: Icons.arrow_drop_down,
//               ),
//               // EntryField(
//               //   prefixIcon: Icons.male,
//               //   hint: locale.gender,
//               //   readOnly: false,
//               // ),
//               SizedBox(height: 20.0),
//               loading
//                   ? CircularProgressIndicator(
//                       color: Theme.of(context).primaryColor,
//                     )
//                   : CustomButton(
//                       label: locale.continuee,
//                       onTap: () async {
//                         if (selectedDate != null) {
//                           print("date goood");
//                           if (gender != null) {
//                             print("gender goood");
//                             setState(() {
//                               loading = true;
//                             });
//                             auth.theUser!.birthDate = selectedDate;
//                             auth.theUser!.gender = gender;
//                             final result = await auth
//                                 .update()
//                                 .catchError((error, stackTrace) => setState(() {
//                                       loading = false;
//                                     }));
//                             setState(() {
//                               loading = false;
//                             });
//                             if (result) {
//                               Navigator.popAndPushNamed(
//                                   context, PageRoutes.bottomNavigation);
//                             }
//                           } else {
//                             showToast("select gender", Colors.red, context);
//                           }
//                         } else {
//                           showToast("select birthdate", Colors.red, context);
//                         }
//                       },
//                     ),
//               // SizedBox(height: 30.0),
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
