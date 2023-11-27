import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChildPageThird extends StatefulWidget {
  @override
  State<AddChildPageThird> createState() => _AddChildPageThirdState();
}

class _AddChildPageThirdState extends State<AddChildPageThird> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: Center(
            child: Column(children: [
              Spacer(
                flex: 5,
              ),
              Icon(
                Icons.celebration,
                size: 100,
              ),
              Spacer(),
              Text(
                locale.child_added!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Text(
                "${auth.childFirstNameController.text}\n" +
                    locale.child_added_text!,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              CustomButton(
                radius: 12,
                label: locale.got_it!,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Spacer(
                flex: 8,
              ),
            ]),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
