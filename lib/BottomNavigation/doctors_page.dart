import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';

import 'Data/data.dart';

class DoctorsHome extends StatefulWidget {
  @override
  _DoctorsHomeState createState() => _DoctorsHomeState();
}

class _DoctorsHomeState extends State<DoctorsHome> {
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
          actions: <Widget>[
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, PageRoutes.myCartPage);
                  },
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: 8,
                  end: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 5.5,
                    child: Center(
                        child: Text(
                      '1',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 9),
                    )),
                  ),
                )
              ],
            ),
          ],
        ),
        body: DoctorsBody());
  }
}

class DoctorsBody extends StatefulWidget {
  @override
  _DoctorsBodyState createState() => _DoctorsBodyState();
}

class _DoctorsBodyState extends State<DoctorsBody> {
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
                locale.findDoctors!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              durationInMilliseconds: 400,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TextFormField(
              // readOnly: true,
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.searchDoctors);
              },
              decoration: InputDecoration(
                  hintText: locale.searchDoctors,
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
                  locale.findBySpecialities!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: lightGreyColor, fontSize: 14.5),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageRoutes.searchDoctors);
                  },
                  child: Text(
                    locale.viewAll!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 14.5),
                  ),
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
                      Navigator.pushNamed(context, PageRoutes.searchDoctors);
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              locale.sponsorAd!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: lightGreyColor, fontSize: 14.5),
            ),
          ),
          Container(
            height: 110,
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctorBanners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: FadedScaleAnimation(
                      Image.asset(
                        doctorBanners[index],
                        width: 250,
                      ),
                      durationInMilliseconds: 300,
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              locale.listOfSpec!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: lightGreyColor, fontSize: 14.5),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: specialities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      specialities[index],
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13.3,
                          color: black2,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color(0xffb3b3b3),
                    ),
                  ],
                ),
              );
              /*ListTile(
                contentPadding: EdgeInsets.symmetric(),
                title: Text('Addiction psychiatrist'),
                trailing: Icon(Icons.arrow_forward_ios, size: 15,),
              );*/
            },
          ),
        ],
      ),
    );
  }
}
