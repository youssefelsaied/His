// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:m3ak_user/Components/custom_button.dart';
// import 'package:m3ak_user/Pages/family_page.dart';
// import '../data/notification.dart' as notifi;

// class NotificationWidget extends StatefulWidget {
//   notifi.UserNotificationModel notification;
//   NotificationWidget({
//     Key? key,
//     required this.notification,
//   }) : super(key: key);

//   @override
//   State<NotificationWidget> createState() => _NotificationWidgetState();
// }

// class _NotificationWidgetState extends State<NotificationWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return InkWell(
//       onTap: () {
//         if (widget.notification.data!.dataCase == 1) {
//           // Navigator.pop(context);
//           Navigator.push<void>(
//             context,
//             MaterialPageRoute<void>(
//               builder: (BuildContext context) => FamilyPage(),
//             ),
//           );
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.all(width * .05),
//         margin: EdgeInsets.symmetric(
//             horizontal: width * .05, vertical: width * .01),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.black12,
//         ),
//         child: Row(children: [
//           Container(
//               alignment: Alignment.center,
//               width: width * .15,
//               child: Icon(widget.notification.data!.dataCase == 1
//                   ? Icons.group_add_outlined
//                   : Icons.notifications)),
//           Container(
//               alignment: Alignment.center,
//               width: width * .65,
//               child: AutoSizeText(widget.notification.body)),
//         ]),
//       ),
//     );
//   }
// }




// // SizedBox(
//           //   height: widget.notification.data!.dataCase == 1 ? width * .05 : 0,
//           // ),
//           // widget.notification.data!.dataCase == 1
//           //     ? 
//           // Row(
//           //         mainAxisAlignment: MainAxisAlignment.center,
//           //         children: [
//           //           CustomButton(
//           //             label: "Accept",
//           //             padding: 10,
//           //           ),
//           //           SizedBox(
//           //             width: width * .05,
//           //           ),
//           //           CustomButton(
//           //             label: "Reject",
//           //             padding: 10,
//           //           ),
//           //         ],
//           //       )
//           //     : Container()