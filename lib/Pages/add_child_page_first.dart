import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/Pages/add_child_page_second.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChildPageFirst extends StatefulWidget {
  @override
  State<AddChildPageFirst> createState() => _AddChildPageFirstState();
}

class _AddChildPageFirstState extends State<AddChildPageFirst> {
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
                flex: 8,
              ),
              Text(
                locale.what_is_your_child_name!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              EntryField(
                border: true,
                hint: locale.firstName!,
                controller: auth.childFirstNameController,
              ),
              Spacer(),
              CustomButton(
                radius: 12,
                onTap: () {
                  if (auth.childFirstNameController.text.isNotEmpty) {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => AddChildPageSecond(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(locale.firstName!)));
                  }
                },
              ),
              Spacer(),
              Text(
                locale.child_page_text!,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
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
