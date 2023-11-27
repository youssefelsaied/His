import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/my_subscription.dart';
import 'package:m3ak_user/Components/custom_button.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/data/doctor.dart';
import 'package:m3ak_user/data/slots.dart';
import 'package:m3ak_user/widgets/custom_dialog.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../../Theme/colors.dart';
import '../../widgets/error_dialog.dart';

class PatientDoctorAppoinmentScreen extends StatefulWidget {
  Doctor doctor;
  PatientDoctorAppoinmentScreen(this.doctor);
  @override
  State<PatientDoctorAppoinmentScreen> createState() =>
      _PatientDoctorAppoinmentScreenState();
}

class _PatientDoctorAppoinmentScreenState
    extends State<PatientDoctorAppoinmentScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<Auth>(context, listen: false);
    auth.getSlots(widget.doctor.doctorId);

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

  TextEditingController notesController = TextEditingController();
  AvilableSlots? selected;
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
          widget.doctor.doctorName,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.doctor.specialization),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.doctor.email),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.doctor.phone),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.doctor.description),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "select Appointments slot if you want to make an Appointments",
              textAlign: TextAlign.center,
              style: TextStyle(color: kMainColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("Avilable Appointments :"),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: auth.avilableSlots
                  .map((e) => InkWell(
                        onTap: () {
                          setState(() {
                            selected = e;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: selected != null && selected == e
                                  ? kMainColor
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(children: [
                            AutoSizeText("From : " +
                                e.appointmentStartTime
                                    .toString()
                                    .substring(0, 16)),
                            AutoSizeText("To : " +
                                e.appointmentEndTime
                                    .toString()
                                    .substring(0, 16))
                          ]),
                        ),
                      ))
                  .toList(), // slots
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EntryField(
              // color: K,
              label: "Notes",
              controller: notesController,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              label: "Confirm",
              onTap: () async {
                if (selected == null || notesController.text.isEmpty) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return ErrorDialog(
                        title: "Error",
                        msg: "you must select a slot and add notes to book",
                      );
                    },
                  );
                  // print("you must select a slot to book annd add notes");
                } else {
                  final res = await auth.makeAppointment(widget.doctor.doctorId,
                      selected!.appointmentSlotId, notesController.text);
                  if (res) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          icon: Icon(Icons.check),
                          title: "Success",
                          msg: "Congratulation your booking is successful",
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          title: "Error",
                          msg:
                              "Some thing went wrong with your request,please try again later!",
                        );
                      },
                    );
                  }
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
