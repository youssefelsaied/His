import 'dart:io';
import 'dart:typed_data';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../Components/custom_button.dart';
import '../data/subscription.dart';

class FawryPaymentPage extends StatefulWidget {
  final Package package;
  FawryPaymentPage(
    this.package,
  );
  @override
  State<FawryPaymentPage> createState() => _FawryPaymentPageState();
}

class _FawryPaymentPageState extends State<FawryPaymentPage>
    with TickerProviderStateMixin {
  final picker = ImagePicker();
  File? editedImg;
  int _counter = 0;
  Uint8List? _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  bool error = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context);
    var height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.vertical;
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //     onPressed: () => Navigator.pop(context),
            //     icon: Icon(Icons.chevron_left)),
            title: Text(
              "Fawry",
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
                                  Image.asset(
                                    "assets/fawry-1.png",
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
                                "You can Pay for the subscription using Fawry with the refrence number",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Color(0xff7c7c7c)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                textDirection: TextDirection.ltr,
                                children: [
                                  Text(
                                    auth.FawryCode!.referenceNumber.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        // await Clipboard.setData(ClipboardData(
                                        //   text: auth.theUser!.memberNum!,
                                        // ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Fawry Refrence Number copied'),
                                          // padding: EdgeInsets.symmetric(horizontal: 10),
                                        ));
                                      },
                                      icon: Icon(Icons.copy))
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Please take a screenshot of this page or copy the refrence number",
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
                                label: "Take a Screen shot",
                                icon: Icon(
                                  Icons.camera_alt,
                                  // color: Colors.white,
                                ),
                                onTap: () {
                                  screenshotController
                                      .capture()
                                      .then((Uint8List? image) async {
                                    //Capture Done
                                    setState(() {
                                      _imageFile = image!;
                                    });
                                    final result =
                                        await ImageGallerySaver.saveImage(
                                            Uint8List.fromList(image!),
                                            quality: 60,
                                            name: "screenshot of fawry");
                                    print(result);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Screenshot saved'),
                                      // padding: EdgeInsets.symmetric(horizontal: 10),
                                    ));
                                  }).catchError((onError) {
                                    print(onError);
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                height: (height * .1) < 30 ? 30 : (height * .1),
                              ),
                            ],
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
          )),
    );
  }
}
