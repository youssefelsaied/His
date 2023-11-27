import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/Checkout/confirm_order.dart';
import 'package:m3ak_user/widgets/custom_dialog.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../BottomNavigation/Medicine/select_package_payment_method.dart';
import '../Components/custom_button.dart';
import '../data/subscription.dart';
import '../widgets/error_dialog.dart';
import '../widgets/save_loading.dart';

class LastPaymentPage extends StatefulWidget {
  final Package package;
  final String providerName;
  final String providerImage;
  final String providerDescrition;
  final String providerPhoneNumber;
  final int providerId;
  LastPaymentPage(this.package, this.providerImage, this.providerName,
      this.providerDescrition, this.providerPhoneNumber, this.providerId);
  @override
  State<LastPaymentPage> createState() => _LastPaymentPageState();
}

class _LastPaymentPageState extends State<LastPaymentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final picker = ImagePicker();
  File? editedImg;

  void _showImageSourceActionSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              _getImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              _getImage(ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }

  Future _getImage(imageSource) async {
    // ignore: deprecated_member_use
    final image = await picker.getImage(
        source: imageSource, imageQuality: 100, maxHeight: 500, maxWidth: 350);
    File _image;
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print(image.path.toString());
        editedImg = _image;
        // profileController.getEditedImg(editedImg);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> save() async {
    final auth = Provider.of<Auth>(context, listen: false);
    var locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    try {
      print("it should edit ");
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SaveLoading(
            title: "Subsription",
          );
        },
      );

      // await auth
      //     .subscribe(widget.package.id, widget.providerId, editedImg!,
      //         locale.locale.languageCode)
          ((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            var locale = AppLocalizations.of(context)!;

            return CustomDialog(
              title: "Subsription",
              msg: "Admin will review your request",
              icon: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: width * .15,
              ),
              // mainAction: TextButton(
              //     style: TextButton.styleFrom(
              //       padding:
              //           EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              //       backgroundColor: Theme.of(context).primaryColor,
              //     ),
              //     onPressed: () {
              //       // Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
              //     },
              //     child: Text(
              //       locale.uploadPrescription!,
              //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
              //           color: Theme.of(context).scaffoldBackgroundColor),
              //     )),
              secondAction: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    locale.ok!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  )),
            );
          },
        );
      })((error, stackTrace) {
        Navigator.of(context).pop();

        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ErrorDialog(
              title: "Error",
              msg:
                  "Some thing went wrong with your request,please try again later!",
            );
          },
        );
      });
    } catch (error) {
      Navigator.of(context).pop();

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ErrorDialog(
            title: "Error",
            msg:
                "Some thing went wrong with your request,please try again later!",
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(1);
  }

  bool error = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.vertical;
    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () => Navigator.pop(context),
          //     icon: Icon(Icons.chevron_left)),
          title: Text(
            widget.providerName,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: SingleChildScrollView(
              child: Container(
                height: height,
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              // color: Colors.red,
                              height: 150,
                              child: FadedScaleAnimation(
                                Image.network(
                                  widget.providerImage,
                                  scale: 1,
                                  // height: 150,
                                  fit: BoxFit.contain,
                                ),
                                durationInMilliseconds: 400,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Subscription fees (${widget.package.title!})",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Color(0xff7c7c7c)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.package.price! + " EGP",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              widget.providerDescrition,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Color(0xff7c7c7c)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              widget.providerPhoneNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Please send a copy of the payment confirmation message or payment receipt",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: error
                                          ? Colors.red
                                          : Color(0xff7c7c7c)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            CustomButton(
                              label: "Attach a picture",
                              icon: Icon(
                                Icons.camera_alt,
                                // color: Colors.white,
                              ),
                              onTap: () {
                                setState(() {
                                  error = false;
                                });
                                _showImageSourceActionSheet(context);
                              },
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            editedImg == null
                                ? Container()
                                : SizedBox(
                                    // height: 200,
                                    // width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: FadedScaleAnimation(
                                        Image(
                                          image: FileImage(editedImg!),
                                          // fit: BoxFit.cover,
                                          // width: 100,
                                          // height: 200,
                                        ),
                                        durationInMilliseconds: 400,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: (height * .1) < 30 ? 30 : (height * .1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Container(
                        // height: height * .,
                        // padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: CustomButton(
                          label: locale.continuee,
                          onTap: () {
                            if (editedImg == null) {
                              setState(() {
                                error = true;
                              });
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ErrorDialog(
                                    title: "Attach receipt",
                                    msg:
                                        "you must attach a copy of the payment confirmation message or payment receipt",
                                  );
                                },
                              );
                            } else {
                              save();
                            }
                            // Navigator.push<void>(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         ChoosePaymentMethod(widget.package),
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}
