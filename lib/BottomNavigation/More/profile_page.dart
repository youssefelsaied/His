// import 'dart:io';
// import 'dart:math';

// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:m3ak_user/UserDetailsCheck/phone_check.dart';
// import 'package:m3ak_user/widgets/error_dialog.dart';
// import 'package:provider/provider.dart';

// import '../../Components/custom_button.dart';
// import '../../Components/entry_field.dart';
// import '../../Locale/locale.dart';
// import '../../Providers/auth.dart';
// import '../../Routes/routes.dart';
// import '../../data/city.dart';
// import '../../widgets/custom_dialog.dart';
// import '../../widgets/save_loading.dart';
// import '../../wrappers/wrapper_auth.dart';

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final picker = ImagePicker();
//   File? editedImg;
//   TextEditingController firstNameController = TextEditingController();

//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   void _showImageSourceActionSheet(BuildContext context) {
//     if (Platform.isIOS) {
//       showCupertinoModalPopup(
//         context: context,
//         builder: (context) => CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               child: Text('Camera'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 _getImage(ImageSource.camera);
//               },
//             ),
//             CupertinoActionSheetAction(
//               child: Text('Gallery'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 _getImage(ImageSource.gallery);
//               },
//             )
//           ],
//         ),
//       );
//     } else {
//       showModalBottomSheet(
//         context: context,
//         builder: (context) => Wrap(children: [
//           ListTile(
//             leading: Icon(Icons.camera_alt),
//             title: Text('Camera'),
//             onTap: () {
//               Navigator.pop(context);
//               _getImage(ImageSource.camera);
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.photo_album),
//             title: Text('Gallery'),
//             onTap: () {
//               Navigator.pop(context);
//               _getImage(ImageSource.gallery);
//             },
//           ),
//         ]),
//       );
//     }
//   }

//   Future _getImage(imageSource) async {
//     final image = await picker.getImage(
//         source: imageSource, imageQuality: 100, maxHeight: 500, maxWidth: 350);
//     File _image;
//     setState(() {
//       if (image != null) {
//         _image = File(image.path);
//         print(image.path.toString());
//         editedImg = _image;
//         // profileController.getEditedImg(editedImg);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   // Future<void> save() async {
//   //   final auth = Provider.of<Auth>(context, listen: false);
//   //   try {
//   //     print("it should edit ");
//   //     showDialog(
//   //       context: context,
//   //       barrierDismissible: true,
//   //       builder: (BuildContext context) {
//   //         return SaveLoading(
//   //           title: "editing Profile",
//   //         );
//   //       },
//   //     );
//   //     auth.theUser!.firstName = firstNameController.text;
//   //     auth.theUser!.lastName = lastNameController.text;
//   //     // auth.theUser!.email = emailController.text;
//   //     // auth.theUser!.name = name.text;
//   //     await auth
//   //         .editProfile(
//   //       editedImg,
//   //     )
//   //         .then((_) {
//   //       Navigator.of(context).pop();
//   //       Navigator.of(context).pop();
//   //     }).onError((error, stackTrace) {
//   //       Navigator.of(context).pop();

//   //       showDialog(
//   //         context: context,
//   //         barrierDismissible: true,
//   //         builder: (BuildContext context) {
//   //           return ErrorDialog(
//   //             title: "Error",
//   //             msg: "Error Occured with your request, try again later!",
//   //           );
//   //         },
//   //       );
//   //     });
//   //   } catch (error) {
//   //     Navigator.of(context).pop();

//   //     showDialog(
//   //       context: context,
//   //       barrierDismissible: true,
//   //       builder: (BuildContext context) {
//   //         return ErrorDialog(
//   //           title: "Error",
//   //           msg: "Error Occured with your request, try again later!",
//   //         );
//   //       },
//   //     );
//   //   }
//   // }

//   @override
//   void initState() {
//     final auth = Provider.of<Auth>(context, listen: false);

//     firstNameController.text = auth.theUser!.firstName!;
//     lastNameController.text = auth.theUser!.lastName!;
//     auth.avialableCites.forEach((element) {
//       if (element.id == auth.theUser!.cityId) {
//         city = element;
//         return;
//       }
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   City? city;

//   @override
//   Widget build(BuildContext context) {
//     var locale = AppLocalizations.of(context)!;
//     final auth = Provider.of<Auth>(context);
//     final width = MediaQuery.of(context).size.width;
//     // print("The user image is${auth.theUser!.image}h");

//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () => Navigator.pop(context)),
//           centerTitle: true,
//           title: Text(
//             locale.account!,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2!
//                 .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
//           ),
//           textTheme: Theme.of(context).textTheme,
//         ),
//         body: FadedSlideAnimation(
//           SingleChildScrollView(
//             child: SizedBox(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(20.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               width: width * .25,
//                               height: width * .25,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: FadedScaleAnimation(
//                                   editedImg != null
//                                       ? Image(
//                                           image: FileImage(editedImg!),
//                                           fit: BoxFit.cover,
//                                         )
//                                       : auth.theUser!.image == ""
//                                           ? Image.asset(
//                                               'assets/hero_image.png',
//                                               scale: 3.5,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : FancyShimmerImage(
//                                               imageUrl: auth.theUser!.image!,
//                                               // height: 40,
//                                               // width: 40,

//                                               boxFit: BoxFit.cover,
//                                               shimmerBaseColor:
//                                                   Colors.grey.shade400,
//                                               shimmerHighlightColor:
//                                                   Colors.grey.shade100,
//                                               // shimmerBackColor: randomColor(),
//                                             ),
//                                   durationInMilliseconds: 400,
//                                 ),
//                               ),
//                             ),
//                             // SizedBox(width: 20),
//                             // Column(
//                             //   crossAxisAlignment: CrossAxisAlignment.start,
//                             //   children: [
//                             //     CircleAvatar(
//                             //         radius: 14,
//                             //         backgroundColor:
//                             //             Theme.of(context).primaryColor,
//                             //         child: Icon(
//                             //           Icons.camera_alt,
//                             //           color: Theme.of(context)
//                             //               .scaffoldBackgroundColor,
//                             //           size: 16,
//                             //         )),
//                             //     SizedBox(height: 16),
//                             //     Text(
//                             //       locale.changeImage!,
//                             //       style: Theme.of(context)
//                             //           .textTheme
//                             //           .bodyText2!
//                             //           .copyWith(
//                             //               color:
//                             //                   Theme.of(context).primaryColor,
//                             //               fontSize: 13),
//                             //     )
//                             //   ],
//                             // ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(20.0),
//                         child: Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pushNamed(
//                                     context, PageRoutes.profilePageEdit);
//                               },
//                               child: Row(children: [
//                                 Icon(Icons.edit),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(auth.theUser!.firstName!),
//                                     Text(auth.theUser!.lastName!),
//                                     Text(auth.theUser!.cityName!),
//                                     Text(auth.theUser!.phoneNumber!),
//                                   ],
//                                 )
//                               ]),
//                             ),
//                             // EntryField(
//                             //   prefixIcon: Icons.manage_accounts_rounded,
//                             //   // initialValue: auth.theUser!.firstName,
//                             //   controller: firstNameController,
//                             //   hint: locale.firstName,
//                             // ),
//                             // SizedBox(height: 20),
//                             // EntryField(
//                             //   prefixIcon: Icons.manage_accounts_rounded,
//                             //   // initialValue: auth.theUser!.lastName,
//                             //   controller: lastNameController,
//                             //   hint: locale.lastName,
//                             // ),
//                             // SizedBox(height: 20),
//                             // Container(
//                             //   padding: EdgeInsets.symmetric(
//                             //     vertical: 5,
//                             //   ),
//                             //   decoration: BoxDecoration(
//                             //       borderRadius: BorderRadius.circular(12),
//                             //       color: Theme.of(context).backgroundColor),
//                             //   width: width,
//                             //   child: Row(
//                             //     children: [
//                             //       SizedBox(
//                             //         width: width * .1,
//                             //         child: Icon(
//                             //           Icons.location_city,
//                             //           color: Theme.of(context).primaryColor,
//                             //           size: 18.5,
//                             //         ),
//                             //       ),
//                             //       SizedBox(
//                             //         width: width * .78,
//                             //         child: DropdownButton<CityElement>(
//                             //           isExpanded: true,
//                             //           items: auth.avialableCites
//                             //               .map((CityElement value) {
//                             //             return DropdownMenuItem<CityElement>(
//                             //               value: value,
//                             //               child: Text(value.title!),
//                             //             );
//                             //           }).toList(),
//                             //           onChanged: (value) {
//                             //             setState(() {
//                             //               city = value;
//                             //               auth.theUser!.cityId = value!.id;
//                             //             });
//                             //           },
//                             //           underline: Text(''),
//                             //           value: city,
//                             //           hint: Text(
//                             //             locale.chooseCity!,
//                             //             style: TextStyle(color: Colors.grey),
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             // SizedBox(height: 20),
//                             // EntryField(
//                             //   prefixIcon: Icons.phone_iphone,
//                             //   initialValue: auth.theUser!.phoneNumber,
//                             //   readOnly: true,
//                             //   hint: locale.mobileNumber,
//                             // ),
//                             // // CustomButton(
//                             // //   onTap: () {
//                             // //     auth.setOtpReason('update');
//                             // //     Navigator.push<void>(
//                             // //       context,
//                             // //       MaterialPageRoute<void>(
//                             // //         builder: (BuildContext context) =>
//                             // //             const PhoneCheck(),
//                             // //       ),
//                             // //     );
//                             // //   },
//                             // //   label: "Change Phone Number",
//                             // //   radius: 0,
//                             // // ),

//                             // SizedBox(height: 20),
//                             // CustomButton(
//                             //   onTap: () {
//                             //     Navigator.pushNamed(
//                             //         context, PageRoutes.searchFamilyMembers);
//                             //   },
//                             //   label: "Add family Members",
//                             //   // color: Colors.red,
//                             //   radius: 0,
//                             // ),

//                             SizedBox(height: 20),
//                             // Text("Or"),

//                             // SizedBox(height: 10),
//                             // Text("your family members"),
//                             // SizedBox(height: 10),
//                             // SizedBox(
//                             //   width: width,
//                             //   height: 100,
//                             //   child: ListView.builder(
//                             //     scrollDirection: Axis.horizontal,
//                             //     itemCount: 5,
//                             //     itemBuilder: (ctx, index) {
//                             //       return Padding(
//                             //         padding: const EdgeInsets.symmetric(
//                             //             horizontal: 8.0),
//                             //         child: ClipRRect(
//                             //           borderRadius: BorderRadius.circular(50),
//                             //           child: FancyShimmerImage(
//                             //             imageUrl: auth.theUser!.image!,
//                             //             height: 100,
//                             //             width: 100,

//                             //             boxFit: BoxFit.cover,
//                             //             shimmerBaseColor: Colors.grey.shade400,
//                             //             shimmerHighlightColor:
//                             //                 Colors.grey.shade100,
//                             //             // shimmerBackColor: randomColor(),
//                             //           ),
//                             //         ),
//                             //       );
//                             //     },
//                             //   ),
//                             // ),
//                             // SizedBox(height: 20),
//                             CustomButton(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   barrierDismissible: true,
//                                   builder: (BuildContext context) {
//                                     var locale = AppLocalizations.of(context)!;

//                                     return CustomDialog(
//                                       title: locale.delete_account!,
//                                       msg: locale.delete_account_text!,
//                                       icon: Icon(
//                                         Icons.error,
//                                         color: Colors.red,
//                                         size: width * .15,
//                                       ),
//                                       mainAction: false
//                                           ? Center(
//                                               child: CircularProgressIndicator(
//                                                   color: Theme.of(context)
//                                                       .primaryColor),
//                                             )
//                                           : TextButton(
//                                               style: TextButton.styleFrom(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 40,
//                                                     vertical: 14),
//                                                 backgroundColor: Colors.red,
//                                               ),
//                                               onPressed: () async {
//                                                 // setState(() {
//                                                 //   loading = true;
//                                                 // });
//                                                 final res =
//                                                     await auth.DeleteAccount();
//                                                 if (res) {
//                                                   Navigator.pop(context);
//                                                   Navigator.pushReplacement(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               WrapperAuth()));
//                                                 } else {
//                                                   // showToast(auth.error,
//                                                   //     Colors.red, context);
//                                                 }

//                                                 // setState(() {
//                                                 //   loading = false;
//                                                 // });
//                                                 // Phoenix.rebirth(context);
//                                               },
//                                               child: Text(
//                                                 locale.delete_account!,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                         color: Theme.of(context)
//                                                             .scaffoldBackgroundColor),
//                                               )),
//                                       secondAction: TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text(
//                                             locale.cancel!,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText1!
//                                                 .copyWith(
//                                                     color: Theme.of(context)
//                                                         .primaryColor),
//                                           )),
//                                     );
//                                   },
//                                 );
//                               },
//                               label: locale.delete_account,
//                               color: Colors.red,
//                               radius: 0,
//                             ),

//                             // CustomButton(
//                             //   onTap: () {
//                             //     auth.setOtpReason('update');
//                             //     Navigator.push<void>(
//                             //       context,
//                             //       MaterialPageRoute<void>(
//                             //         builder: (BuildContext context) =>
//                             //             const PhoneCheck(),
//                             //       ),
//                             //     );
//                             //   },
//                             //   label: "Change Phone Number",
//                             //   radius: 0,
//                             // ),
//                             // SizedBox(height: 20),
//                             // EntryField(
//                             //   prefixIcon: Icons.mail,
//                             //   initialValue: auth.theUser!.email,
//                             //   readOnly: true,
//                             //   hint: locale.emailAddress,
//                             // ),
//                             SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           beginOffset: Offset(0, 0.3),
//           endOffset: Offset(0, 0),
//           slideCurve: Curves.linearToEaseOut,
//         ));
//   }
// }
