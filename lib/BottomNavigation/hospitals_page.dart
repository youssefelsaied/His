import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Data/data.dart';

class HospitalsHome extends StatefulWidget {
  @override
  _HospitalsHomeState createState() => _HospitalsHomeState();
}

class _HospitalsHomeState extends State<HospitalsHome> {
  String? value = 'Wallington';

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Icon(
          Icons.location_on,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
        title: DropdownButton(
          value: value,
          iconSize: 0.0,
          // style: inputTextStyle.copyWith(
          //     fontWeight: FontWeight.bold,
          //     color: Theme.of(context).secondaryHeaderColor),
          underline: Container(
            height: 0,
          ),
          onChanged: (String? newValue) {
            setState(() {
              value = newValue;
            });
            // if (value == 'appLocalization.setLocation')
            //   Navigator.pushNamed(context, PageRoutes.locationPage);
          },
          items: <String?>[
            'Wallington',
            locale.office,
            locale.other,
            locale.setLocation
          ].map<DropdownMenuItem<String>>((address) {
            return DropdownMenuItem<String>(
              value: address,
              child: Text(
                address!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bookmark_outline,
              size: 20,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: HospitalsBody(),
    );
  }
}

class HospitalsBody extends StatefulWidget {
  @override
  _HospitalsBodyState createState() => _HospitalsBodyState();
}

class HospitalDetail {
  String image;
  String name;
  String type;
  String location;

  HospitalDetail(this.image, this.name, this.type, this.location);
}

class _HospitalsBodyState extends State<HospitalsBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 20, right: 20, bottom: 14),
            child: Text(
              locale.hello! + ', Sam Smith,',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: lightGreyColor, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FadedScaleAnimation(
              Text(
                locale.findHospital!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              durationInMilliseconds: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TextFormField(
              onTap: () {
                //Navigator.pushNamed(context, PageRoutes.searchDoctors);
              },
              decoration: InputDecoration(
                  hintText: locale.searchHospital,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: textFieldColor, fontSize: 15),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                Text(
                  locale.searchByCategory!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: lightGreyColor, fontSize: 14.5),
                ),
                Spacer(),
                Text(
                  locale.viewAll!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 14.5),
                ),
              ],
            ),
          ),
          Container(
            height: 123.3,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctorCategories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.hospitalInfo);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: FadedScaleAnimation(
                        Image.asset(
                          doctorCategories[index],
                          // height: 100,
                          width: 95,
                          fit: BoxFit.fill,
                        ),
                        durationInMilliseconds: 300,
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 10, left: 16),
            child: Row(
              children: [
                Text(
                  locale.hospitalsNearYou!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: lightGreyColor, fontSize: 14.5),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.map,
                      size: 20,
                      color: Theme.of(context).disabledColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, PageRoutes.hospitalMapView);
                    })
              ],
            ),
          ),
          HospitalsList(),
        ],
      ),
    );
  }
}

class HospitalsList extends StatelessWidget {
  final List<HospitalDetail> _hospitals = [
    HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
        'General Hospital', 'Jespora Bridge, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
        'General Hospital', 'Jespora Bridge, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: _hospitals.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PageRoutes.hospitalInfo);
          },
          child: Column(
            children: [
              Divider(
                color: Theme.of(context).backgroundColor,
                thickness: 6,
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 16),
                title: Row(
                  children: [
                    Expanded(
                      // flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _hospitals[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 15,
                                    height: 1.5,
                                    color: black2,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _hospitals[index].type,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    fontSize: 11.7,
                                    color: Color(0xff979797),
                                    height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: stores.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                //  Navigator.pushNamed(context, PageRoutes.medicines);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: FadedScaleAnimation(
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      stores[index],
                                      // height: 100,
                                      width: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  durationInMilliseconds: 300,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 16.0, top: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Theme.of(context).disabledColor,
                      size: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        _hospitals[index].location,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 10,
                            color: Theme.of(context).disabledColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.call,
                      color: Theme.of(context).primaryColor,
                      size: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      locale!.callNow!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 10, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        );
      },
    );
  }
}
//done
