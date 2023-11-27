import 'dart:ui';
import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Routes/routes.dart';
import '../../../../Locale/locale.dart';

class BookAppointment extends StatefulWidget {
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;
    final List<String> day = ['WED', 'THU', 'FRI', 'SAT', 'SUN', 'MON'];
    final List<String> date = ['12', '13', '14', '15', '16', '17'];
    final List<String> time = ['09:00 am', '09:30 am', '10:00 am'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.selectDateAndTime!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          //onPressed: Navigator.pop(),
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 5),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Container(
                        child: FadedScaleAnimation(
                          Image.asset(
                            'assets/Doctors/doc1.png',
                            scale: 1.2,
                          ),
                          durationInMilliseconds: 400,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 0),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.subtitle2,
                            children: [
                              TextSpan(
                                  text: 'Dr.\nJoseph\nWilliamson\n\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: black2,
                                          height: 1.5)),
                              TextSpan(
                                  text:
                                      'Cardiac Surgeon\n' + 'at Apple Hospital',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Color(0xffb3b3b3),
                                          fontSize: 13.3,
                                          height: 1.5))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        locale.selectDate!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Color(0xffb3b3b3),
                              fontSize: 15,
                            ),
                      ),
                      Spacer(flex: 1),
                      Text(
                        'June 2020',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Color(0xffb3d3d3d),
                              fontSize: 15,
                            ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Container(
                    height: 52,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: day.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                              width: width / 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    day[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Color(0xffababab),
                                            fontSize: 8,
                                            height: 1.5),
                                  ),
                                  Text(
                                    date[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Color(0xff2e2e2e),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.selectTime!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Color(0xffb3b3b3),
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    height: width / 8,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: time.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                              width: width / 3.5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  time[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Color(0xff2e2e2e),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        height: 1.4,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.appointmentFor!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Color(0xffb3b3b3),
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'eg. Heart pain, Body ache, etc.',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Color(0xff808080),
                                  fontSize: 15,
                                ),
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.appointmentBooked);
                },
                label: locale.confirmAppointment,
                radius: 0,
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
