import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/city.dart';
import 'package:provider/provider.dart';

import '../Components/custom_button.dart';
import '../Components/custom_drop_down.dart';
import '../Components/entry_field.dart';
import '../Locale/locale.dart';
import '../Providers/global_provider.dart';

class ChooseCity extends StatefulWidget {
  const ChooseCity({Key? key}) : super(key: key);

  @override
  State<ChooseCity> createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  City? city;
  @override
  void initState() {
    var auth = Provider.of<Auth>(context, listen: false);
    if (auth.avialableCites.isEmpty) {
      // var fetchCities = auth.getCities();
    }
    super.initState();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var global = Provider.of<GlobalProvider>(context);
    var auth = Provider.of<Auth>(context);
    final size = MediaQuery.of(context).size;
    final notch = MediaQuery.of(context).padding.top;
    final height = size.height - notch;
    final width = size.width;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.red,
        title: Text(
          locale.chooseCity!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        auth.avialableCites.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ))
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: height,
                  padding: EdgeInsets.symmetric(horizontal: width * .05),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          locale.chooseCityText!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(flex: 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('\n' + locale.city! + '\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Color(
                                          0xffb3b3b3,
                                        ),
                                        fontSize: 15)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: width * .01),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).backgroundColor),
                              width: width,
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
                                    width: width * .78,
                                    child: DropdownButton<dynamic>(
                                      isExpanded: true,
                                      items: auth.avialableCites
                                          .map((dynamic value) {
                                        return DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text(value.title!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          city = value;
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
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                label: locale.continuee,
                                onTap: () async {
                                  // global.nextPage();
                                  if (city != null) {
                                    // auth.theUser!.cityId = city!.id;
                                    // auth.theUser!.cityName = city!.title;

                                    setState(() {
                                      loading = true;
                                    });
                                    // await auth.update();

                                    setState(() {
                                      loading = false;
                                    });
                                    // if (lastPage) {
                                    //   auth.update();
                                    // }
                                  } else {}
                                },
                              ),
                        SizedBox(height: 30.0),
                        Spacer(flex: 12),
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
