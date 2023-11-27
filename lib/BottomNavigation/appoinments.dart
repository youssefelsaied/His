import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/my_subscription.dart';
import 'package:m3ak_user/Components/custom_button.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../Theme/colors.dart';

class AppoinmentPage extends StatefulWidget {
  @override
  State<AppoinmentPage> createState() => _AppoinmentPageState();
}

class _AppoinmentPageState extends State<AppoinmentPage>
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            auth.getAppoinments();
            return;
          },
          child: auth.appoinments.isEmpty
              ? Center(
                  child: Text("No Appoinments yet"),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: auth.appoinments
                        .map((e) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Start : " +
                                          e.appointmentStartTime
                                              .toString()
                                              .substring(0, 16),
                                      style: TextStyle(color: kMainColor),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      // height: 40,
                                      child: CustomButton(
                                        label: "cancel",
                                        color: Colors.red,
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: height * .32,
                                                color: Colors.white,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    // mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: height * .07,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      width *
                                                                          .05),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CircleAvatar(
                                                                  // radius: 30,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  child: Icon(
                                                                    Icons.clear,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height * .1,
                                                        child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors.red[100],
                                                            child: Icon(
                                                              Icons
                                                                  .warning_amber_rounded,
                                                              color: Colors.red,
                                                            )),
                                                      ),
                                                      // SizedBox(
                                                      //   height: height * .01,
                                                      // ),
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: height * .05,
                                                          child: Text(
                                                              "Are you sure you wannt to cancel ?")),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: height * .1,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        .05),
                                                        child: Container(
                                                          child: CustomButton(
                                                            label:
                                                                locale.cancel!,
                                                            onTap: () async {
                                                              final res = await auth
                                                                  .cancelAppointment(
                                                                      e.appointmentId);

                                                              if (res) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "DR : " + e.doctorName.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 19),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "note : " + e.notes,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
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
                ),
        ));
  }
}
