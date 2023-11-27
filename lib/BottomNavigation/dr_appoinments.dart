import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/my_subscription.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../Theme/colors.dart';

class DrAppoinmentPage extends StatefulWidget {
  @override
  State<DrAppoinmentPage> createState() => _DrAppoinmentPageState();
}

class _DrAppoinmentPageState extends State<DrAppoinmentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // final auth = Provider.of<Auth>(context, listen: false);

    // _tabController = TabController(
    //     length: auth.myPackage == null ||
    //             auth.myPackage!.status == 0 ||
    //             auth.myPackage!.status == 3 ||
    //             auth.myPackage!.status == 4
    //         ? 2
    //         : 1,
    //     vsync: this);
    // _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context);
    _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.appointments!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: auth.doctorAppointments.isEmpty
          ? Center(
              child: Text("No Appoinments yet"),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: auth.doctorAppointments
                  .map((e) => Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Start : " +
                                e.appointmentStartTime
                                    .toString()
                                    .substring(0, 16),
                            style: TextStyle(color: kMainColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "note : " + e.notes,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "End : " +
                                e.appointmentEndTime
                                    .toString()
                                    .substring(0, 16),
                            style: TextStyle(color: kMainColor),
                          ),
                        ],
                      )))
                  .toList(),
            ),
    );
  }
}
