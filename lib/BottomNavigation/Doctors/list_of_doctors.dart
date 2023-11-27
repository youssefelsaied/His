import 'dart:core';

import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorsPage extends StatefulWidget {
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left)),
          title: Text(
            locale.cardio!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
          actions: [
            Stack(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.sort,
                        size: 20,
                      ),
                      color: lightGreyColor,
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.sortFilterPage);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.map,
                        size: 20,
                      ),
                      color: lightGreyColor,
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.doctorMapView);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        body: DoctorsList());
  }
}

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class SearchDoctorTile {
  String image;
  String name;
  String speciality;
  String hospital;
  String experience;
  String fee;
  String reviews;

  SearchDoctorTile(this.image, this.name, this.speciality, this.hospital,
      this.experience, this.fee, this.reviews);
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    List<SearchDoctorTile> searchList = [
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
    ];
    return Scaffold(
      body: FadedSlideAnimation(
        Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Divider(
                thickness: 6,
                height: 6,
                color: Theme.of(context).backgroundColor,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8, bottom: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.doctorInfo);
                              },
                              child: Row(
                                children: [
                                  FadedScaleAnimation(
                                    Image.asset(
                                      searchList[index].image,
                                      height: 80,
                                      width: 80,
                                    ),
                                    durationInMilliseconds: 400,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: searchList[index].name +
                                                    '\n',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: black2,
                                                        height: 1.7)),
                                            TextSpan(
                                                text: searchList[index]
                                                    .speciality,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xff999999),
                                                    )),
                                            TextSpan(
                                                text: locale!.at,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xffcccccc),
                                                    )),
                                            TextSpan(
                                                text:
                                                    searchList[index].hospital,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 11.2,
                                                      color: Color(0xff999999),
                                                    )),
                                          ])),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            locale.exp!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12),
                                          ),
                                          Text(
                                            searchList[index].experience +
                                                locale.years!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            locale.fee!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12),
                                          ),
                                          Text(
                                            '\$' + searchList[index].fee,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 35,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 6,
                            thickness: 6,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ],
                      ),
                      PositionedDirectional(
                        bottom: 28,
                        end: 0,
                        child: Row(
                          children: [
                            RatingBar.builder(
                                itemSize: 12,
                                initialRating: 4,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                }),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '(${searchList[index].reviews})',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 10,
                                      color: Theme.of(context).disabledColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );

                  /*ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  leading: Image.asset('assets/Doctors/doc1.png', height: 100,),
                  title: RichText( text: TextSpan(style: Theme.of(context).textTheme.subtitle2, children: <TextSpan>[
                    TextSpan(text: 'Dr. Joseph Williamson\n', style: Theme.of(context).textTheme.subtitle1),
                    TextSpan(text: 'Cardiac Surgeon'),
                    TextSpan(text: ' at '),
                    TextSpan(text: 'Apple Hospital'),
                  ])),
                  subtitle: Row(children: [
                    Text('Exp. '),
                    Text('22 years'),
                    Spacer(),
                    Text('Fees '),
                    Text('\$30'),
                    Spacer(flex: 2,),
                    RatingBar(
                      itemSize: 12,
                        initialRating: 4,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating){
                      print(rating);
                    })
                  ],),
                );*/
                },
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
