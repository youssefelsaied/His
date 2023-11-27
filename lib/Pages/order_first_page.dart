import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/Pages/add_child_page_second.dart';
import 'package:m3ak_user/Pages/order_second_page.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/brands_by_category.dart';
import 'package:m3ak_user/widgets/branch_card_order.dart';
import 'package:m3ak_user/widgets/select_branch_model.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../Providers/menu_provider.dart';
import '../widgets/branch_card.dart';
import '../widgets/notification_widget.dart';

class OrderFirstPage extends StatefulWidget {
  Brand brand;
  OrderFirstPage(this.brand);
  @override
  State<OrderFirstPage> createState() => _OrderFirstPageState();
}

class _OrderFirstPageState extends State<OrderFirstPage> {
  final picker = ImagePicker();
  File? firstSelectedImg;
  File? secondSelectedImg;
  File? thirdSelectedImg;

  void _showImageSourceActionSheet(BuildContext context) {
    // Platform.isIOS
    if (true) {
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
    // final List<> images = await picker.getMultiImage(
    //      imageQuality: 100, maxHeight: 500, maxWidth: 450);
    // ignore: deprecated_member_use
    final image = await picker.getImage(
        source: imageSource, imageQuality: 100, maxHeight: 500, maxWidth: 450);
    File _image;
    setState(() {
      if (image != null) {
        _image = File(image.path);
        print(image.path.toString());
        if (firstSelectedImg == null) {
          firstSelectedImg = _image;
        } else if (secondSelectedImg == null) {
          secondSelectedImg = _image;
        } else if (thirdSelectedImg == null) {
          thirdSelectedImg = _image;
        } else {
          print("you can't add more than 3 pics");
        }
        // profileController.getEditedImg(editedImg);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    // if()
    final menu = Provider.of<MenuProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    // await menu.getBranchesByBrandsId(
    //     auth.theUser!.token, widget.brand.id!, 'ar');
    setState(() {
      loading = false;
    });
  }

  void showToast(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      // padding: EdgeInsets.all(5),
    ));
  }

  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final menu = Provider.of<MenuProvider>(context, listen: true);

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.order_now!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: FadedSlideAnimation(
        ListView(children: [
          SizedBox(
            height: height * .02,
          ),
          menu.callCenterBranch != null
              ? BranchCardOrder(
                  brand: widget.brand,
                  branch: menu.callCenterBranch!,
                  inList: true)
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: width * .05),
                  width: width * .15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("اختر الفرع"),
                      SizedBox(
                        height: height * .01,
                      ),
                      AutoSizeText(
                        "اختر الفرع المناسب للتوصيل",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      menu.selectedNonCallCenterBranch != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * .7,
                                  child: BranchCardOrder(
                                    brand: widget.brand,
                                    branch: menu.selectedNonCallCenterBranch!,
                                    inList: false,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: width * .2,
                                  child: TextButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        isScrollControlled: true,
                                        useRootNavigator: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          print('build');
                                          return SelectBranchModel(
                                            brand: widget.brand,
                                          );
                                        },
                                      );
                                    },
                                    child: AutoSizeText(
                                      locale.change!,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : CustomButton(
                              label: locale.select_a_branch,
                              onTap: () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  useRootNavigator: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  context: context,
                                  builder: (BuildContext context) {
                                    print('build');
                                    return SelectBranchModel(
                                      brand: widget.brand,
                                    );
                                  },
                                );
                              },
                            )
                    ],
                  )),
          SizedBox(
            height: height * .02,
          ),
          Container(
            width: width * .9,
            margin: EdgeInsets.symmetric(horizontal: width * .05),
            height: 1,
            color: Colors.grey,
          ),
          SizedBox(
            height: height * .02,
          ),
          InkWell(
            onTap: () => _showImageSourceActionSheet(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * .05),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.symmetric(vertical: height * .03),
                dashPattern: [1, 0, 2, 0, 1],
                strokeCap: StrokeCap.butt,
                color: Theme.of(context).primaryColor,
                strokeWidth: 1.5,
                child: firstSelectedImg != null
                    ? Row(
                        children: [
                          SizedBox(
                            width: width * .05,
                          ),
                          FadedScaleAnimation(
                            Stack(
                              children: [
                                Container(
                                  width: width * .25,
                                  height: width * .25,
                                  color: Colors.white,
                                  alignment: Alignment.bottomLeft,
                                  child: SizedBox(
                                    width: width * .25,
                                    height: width * .25,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        image: FileImage(firstSelectedImg!,
                                            scale: 3),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: width * .008,
                                    right: width * .008,
                                    child: Container(
                                      width: width * .05,
                                      height: width * .05,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              width * .025)),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.clear,
                                          size: width * .04,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (secondSelectedImg == null &&
                                                thirdSelectedImg == null) {
                                              setState(() {
                                                firstSelectedImg = null;
                                              });
                                            } else if (secondSelectedImg !=
                                                    null &&
                                                thirdSelectedImg == null) {
                                              setState(() {
                                                firstSelectedImg =
                                                    secondSelectedImg;
                                                secondSelectedImg = null;
                                              });
                                            } else if (secondSelectedImg !=
                                                    null &&
                                                thirdSelectedImg != null) {
                                              setState(() {
                                                firstSelectedImg =
                                                    secondSelectedImg;
                                                secondSelectedImg =
                                                    thirdSelectedImg;
                                                thirdSelectedImg = null;
                                              });
                                            }
                                          });
                                        },
                                      ),
                                    ))
                              ],
                            ),
                            durationInMilliseconds: 400,
                          ),
                          secondSelectedImg == null
                              ? Container()
                              : SizedBox(
                                  width: width * .025,
                                ),
                          secondSelectedImg == null
                              ? Container()
                              : FadedScaleAnimation(
                                  Stack(
                                    children: [
                                      Container(
                                        width: width * .25,
                                        height: width * .25,
                                        color: Colors.white,
                                        alignment: Alignment.bottomLeft,
                                        child: SizedBox(
                                          width: width * .25,
                                          height: width * .25,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image(
                                              image: FileImage(
                                                  secondSelectedImg!,
                                                  scale: 3),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: width * .008,
                                          right: width * .008,
                                          child: Container(
                                            width: width * .05,
                                            height: width * .05,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width * .025)),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.clear,
                                                size: width * .04,
                                                color: Colors.red,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  if (thirdSelectedImg ==
                                                      null) {
                                                    setState(() {
                                                      secondSelectedImg = null;
                                                    });
                                                  } else if (thirdSelectedImg !=
                                                      null) {
                                                    setState(() {
                                                      secondSelectedImg =
                                                          thirdSelectedImg;
                                                      thirdSelectedImg = null;
                                                    });
                                                  }
                                                });
                                              },
                                            ),
                                          ))
                                    ],
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                          thirdSelectedImg == null
                              ? Container()
                              : SizedBox(
                                  width: width * .025,
                                ),
                          thirdSelectedImg == null
                              ? Container()
                              : FadedScaleAnimation(
                                  Stack(
                                    children: [
                                      Container(
                                        width: width * .25,
                                        height: width * .25,
                                        color: Colors.white,
                                        alignment: Alignment.bottomLeft,
                                        child: SizedBox(
                                          width: width * .25,
                                          height: width * .25,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image(
                                              image: FileImage(
                                                  thirdSelectedImg!,
                                                  scale: 3),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: width * .008,
                                          right: width * .008,
                                          child: Container(
                                            width: width * .05,
                                            height: width * .05,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width * .025)),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.clear,
                                                size: width * .04,
                                                color: Colors.red,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  thirdSelectedImg = null;
                                                });
                                              },
                                            ),
                                          ))
                                    ],
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                          thirdSelectedImg == null
                              ? Container()
                              : SizedBox(
                                  width: width * .05,
                                ),
                          (secondSelectedImg == null ||
                                  thirdSelectedImg == null)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: width * .15,
                                        child: CircleAvatar(
                                          backgroundColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.2),
                                          child: Icon(
                                            Icons.camera_enhance_rounded,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * .25,
                                      child: AutoSizeText(
                                        locale.add_order_image!,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                )
                              : Container()
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                              width: width * .15,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.2),
                                child: Icon(
                                  Icons.photo_camera_sharp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )),
                          SizedBox(
                            width: width * .05,
                          ),
                          SizedBox(
                            width: width * .6,
                            child: AutoSizeText(locale.add_order_image!),
                          )
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * .38,
                  height: 1,
                  color: Colors.grey,
                ),
                Text(
                  locale.or!,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: width * .38,
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          SizedBox(
              width: width * .15,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.2),
                child: Icon(
                  Icons.mode_edit_outline_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              )),
          SizedBox(
            height: height * .02,
          ),
          Center(
            child: Text(
              "اكتب طلبك",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          Center(
            child: Text(
              "اكتب هنا اسم الدواء او المنتج الذى تريد طلبه من الصيدلية",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              child: EntryField(
                hint: "مثال: علبة بنادول و بامبرز مقاس 4",
                maxLines: 5,
                controller: _controller,
              )),
          SizedBox(
            height: height * .02,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: width * .05),
              child: CustomButton(
                onTap: () {
                  if (menu.callCenterBranch != null) {
                    if (_controller.text.isNotEmpty ||
                        firstSelectedImg != null) {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => OrderSecondPage(
                            firstSelectedImg: firstSelectedImg,
                            secondSelectedImg: secondSelectedImg,
                            thirdSelectedImg: thirdSelectedImg,
                            details: _controller.text,
                          ),
                        ),
                      );
                    } else {
                      print("you should add an image or write your order");
                      showToast(locale.please_add_an_image_or_write_your_order);
                    }
                  } else if (menu.selectedNonCallCenterBranch != null) {
                    if (_controller.text.isNotEmpty ||
                        firstSelectedImg != null) {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => OrderSecondPage(
                            firstSelectedImg: firstSelectedImg,
                            secondSelectedImg: secondSelectedImg,
                            thirdSelectedImg: thirdSelectedImg,
                            details: _controller.text,
                          ),
                        ),
                      );
                    } else {
                      print("you should add an image or write your order");
                      showToast(locale.please_add_an_image_or_write_your_order);
                    }
                  } else {
                    print("you should select a branch first");
                    showToast(locale.please_select_a_branch);
                  }
                },
              ))
        ]),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
