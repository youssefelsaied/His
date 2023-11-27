import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Locale/locale.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/entry_field.dart';
import '../Providers/auth.dart';
import '../Routes/routes.dart';
import '../Theme/colors.dart';
import '../data/city.dart';
import '../widgets/custom_dialog.dart';

class ChangeCityDialog extends StatefulWidget {
  const ChangeCityDialog({Key? key}) : super(key: key);

  @override
  State<ChangeCityDialog> createState() => _ChangeCityDialogState();
}

class _ChangeCityDialogState extends State<ChangeCityDialog> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);

    auth.avialableCites.forEach((element) {
      // if (element.id == auth.theUser!.cityId) {
      //   city = element;
      //   return;
      // }
    });
    // TODO: implement initState
    super.initState();
  }

  City? city;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<Auth>(context, listen: false);

    return GestureDetector(
      onTap: (() {
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: FadedSlideAnimation(
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              FadedScaleAnimation(
                Container(
                    child: Icon(
                  Icons.home_filled,
                  size: 50,
                )),
                durationInMilliseconds: 400,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                locale.chooseCity!,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 18.2),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).backgroundColor),
                // width: width,
                child: Row(
                  children: [
                    SizedBox(
                      width: width * .1,
                      child: Icon(
                        Icons.location_city,
                        color: Theme.of(context).primaryColor,
                        size: 18.5,
                      ),
                    ),
                    SizedBox(
                      width: width * .5,
                      child: DropdownButton<dynamic>(
                        isExpanded: true,
                        items: auth.avialableCites.map((dynamic value) {
                          return DropdownMenuItem<dynamic>(
                            value: value,
                            child: Text(value.title!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            city = value;
                            // auth.theUser!.cityId = value!.id;
                          });
                        },
                        underline: Text(''),
                        value: city,
                        hint: Text(
                          locale.chooseCity!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                  : TextButton(
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        // auth.theUser!.cityId = city!.id;
                        setState(() {
                          loading = true;
                        });
                        // final res = await auth.update();
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        locale.continuee!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor),
                      )),

              //  SizedBox(width: width * .45, child: mainAction!),

              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    locale.cancel!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  )),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
