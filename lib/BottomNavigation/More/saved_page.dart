import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../BottomNavigation/Doctors/list_of_doctors.dart';
import '../../../../BottomNavigation/Medicine/medicines.dart';
import '../../../../BottomNavigation/hospitals_page.dart';
import '../../../../Locale/locale.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left)),
          title: Text(
            locale.saved!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor.withOpacity(0.4),
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 17, color: kMainColor),
            indicatorColor: Colors.transparent,
            tabs: [
              // Tab(text: locale.medicine),
              Tab(text: locale.doctors),
              Tab(text: locale.hospitals),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // FadedSlideAnimation(
            //   Medicines(),
            //   beginOffset: Offset(0, 0.3),
            //   endOffset: Offset(0, 0),
            //   slideCurve: Curves.linearToEaseOut,
            // ),
            FadedSlideAnimation(
              DoctorsList(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              HospitalsList(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ],
        ),
      ),
    );
  }
}
