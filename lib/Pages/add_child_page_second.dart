import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/Pages/add_child_page_third.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChildPageSecond extends StatefulWidget {
  @override
  State<AddChildPageSecond> createState() => _AddChildPageSecondState();
}

class _AddChildPageSecondState extends State<AddChildPageSecond> {
  DateTime? selectedDate;

  Future<Null> _selectTime(BuildContext context) async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        maxTime: DateTime.now(),
        minTime: DateTime(1900, 1, 1), onChanged: (date) {
      setState(() {
        //  time = DatePickerDateOrder.dmy;
        setState(() {
          selectedDate = date;
        });
      });
      //date.timeZoneOffset.inHours.toString();
    }, onConfirm: (date) {
      setState(() {
        selectedDate = date;
      });
    }, currentTime: selectedDate == null ? DateTime.now() : selectedDate);
  }

  bool loading = false;
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
                locale.birthday!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Text(
                locale.birthday_text!,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              EntryField(
                prefixIcon: Icons.calendar_month,
                hint: selectedDate == null
                    ? locale.birthDate
                    : DateFormat('yyyy-MM-dd').format(selectedDate!).toString(),
                readOnly: true,
                onTap: () {
                  _selectTime(context);
                },
              ),
              Spacer(),
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                  : CustomButton(
                      radius: 12,
                      onTap: () async {
                        if (selectedDate != null) {
                          setState(() {
                            loading = true;
                          });
                          // final res = await auth.AddChild(
                          //     selectedDate.toString().substring(0, 11));
                          setState(() {
                            loading = false;
                          });
                          // if (res) {
                          //   Navigator.pop(context);
                          //   Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute<void>(
                          //       builder: (BuildContext context) =>
                          //           AddChildPageThird(),
                          //     ),
                          //   );
                          // }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(locale.birthday!)));
                        }
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
