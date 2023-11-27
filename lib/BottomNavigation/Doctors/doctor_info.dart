import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DoctorInfo extends StatefulWidget {
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.bookmark_outline_outlined,
                  size: 20,
                ),
              )
            ],
          )
        ],
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: FadedScaleAnimation(
                                Image.asset(
                                  'assets/Doctors/doc1.png',
                                  scale: 1.2,
                                ),
                                durationInMilliseconds: 400,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      children: [
                                        TextSpan(
                                            text: locale.experience,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Color(0xffb3b3b3),
                                                  fontSize: 13.3,
                                                )),
                                        TextSpan(
                                            text: '18' + locale.years!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: black2,
                                                  fontSize: 15,
                                                )),
                                      ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      children: [
                                        TextSpan(
                                            text: locale.consulFees,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Color(0xffb3b3b3),
                                                  fontSize: 13.3,
                                                )),
                                        TextSpan(
                                            text: '\$28',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: black2,
                                                  fontSize: 15,
                                                ))
                                      ]),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
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
                                                  height: 1.2)),
                                      TextSpan(
                                          text: locale.cardiacSurgeon,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Color(0xffb3b3b3),
                                                fontSize: 13.3,
                                              ))
                                    ]),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(locale.feedback!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Color(0xffb3b3b3),
                                            fontSize: 13.3,
                                          )),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PageRoutes.doctorReviewPage);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: starColor,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '4.5',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontSize: 15,
                                                  color: starColor),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '(124)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: Color(0xffb3b3b3),
                                                  fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color:
                                              Theme.of(context).disabledColor,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    children: [
                                      Text(locale.availability!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Color(0xffb3b3b3),
                                                fontSize: 13.3,
                                              )),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).disabledColor,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        children: [
                                          TextSpan(
                                              text: '12:00 ' +
                                                  locale.to! +
                                                  ' 13:00',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: black2,
                                                    fontSize: 15,
                                                  ))
                                        ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(
                        top: 10, left: 20, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.servicesAt!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Color(0xffb3b3b3),
                                      fontSize: 13.3,
                                    )),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text('Apple Hopsital',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: black2,
                                    fontSize: 15,
                                  )),
                          subtitle: Text('JJ Towers, Johnson street, Hemilton',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xff808080),
                                    fontSize: 13.5,
                                  )),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text('Seven Star Clinic',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: black2,
                                    fontSize: 15,
                                  )),
                          subtitle: Text('Hemilton Bridge City Point, Hemilton',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Color(0xff808080),
                                    fontSize: 13.5,
                                  )),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '+1 ' + locale.more!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(
                        top: 10, left: 20, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.servicesAt!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Color(0xffb3b3b3),
                                      fontSize: 13.3,
                                    )),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Hypertension Treatment',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('COPD Treatment',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Diabetes Management',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('ECG',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Obesity Treatment',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '+5 ' + locale.more!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  height: 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.specifications!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Color(0xffb3b3b3),
                                      fontSize: 13.3,
                                    )),
                        SizedBox(
                          height: 20,
                        ),
                        Text('General Physician',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Family Physician',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Cardiologist',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Consultant Physician',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text('Diabetologist',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: black2,
                                      fontSize: 13.5,
                                    )),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '+1 ' + locale.more!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  height: 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PageRoutes.bookAppointment);
                      },
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: locale.bookAppointmentNow,
                      radius: 0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
