import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/code_tap.dart';
import 'package:m3ak_user/BottomNavigation/More/subscription/my_subscription.dart';
import 'package:m3ak_user/Components/custom_button.dart';
import 'package:m3ak_user/Components/entry_field.dart';
import 'package:m3ak_user/data/doctor.dart';
import 'package:m3ak_user/data/dr_patient.dart';
import 'package:m3ak_user/data/slots.dart';
import 'package:m3ak_user/widgets/custom_dialog.dart';
import 'package:m3ak_user/widgets/subscription_card.dart';
import 'package:provider/provider.dart';

import '../../Locale/locale.dart';
import '../../Providers/auth.dart';
import '../../Theme/colors.dart';
import '../../widgets/error_dialog.dart';

class DoctorPatienteRecordsScreen extends StatefulWidget {
  DoctorPatient patient;
  DoctorPatienteRecordsScreen(this.patient);
  @override
  State<DoctorPatienteRecordsScreen> createState() =>
      _DoctorPatienteRecordsScreenState();
}

class _DoctorPatienteRecordsScreenState
    extends State<DoctorPatienteRecordsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<Auth>(context, listen: false);
    auth.getDoctorPatientRecords(widget.patient.patientId);

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

  TextEditingController dignosesController = TextEditingController();
  TextEditingController preController = TextEditingController();
  AvilableSlots? selected;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context);
    _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                // color: kMainColor,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                child: Wrap(
                  spacing: 5,
                  children: [
                    EntryField(
                      label: "Diagnosis",
                      color: Colors.grey[200],
                      controller: dignosesController,
                    ),
                    EntryField(
                      label: "Prescription",
                      color: Colors.grey[200],
                      controller: preController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      label: "Confirm",
                      onTap: () async {
                        final res = await auth.addMedicalRecord(
                            widget.patient.patientId,
                            DateTime.now().toString().substring(0, 16),
                            dignosesController.text,
                            preController.text);
                        if (res) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: kMainColor, borderRadius: BorderRadius.circular(40)),
            child: Icon(Icons.add)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () => Navigator.pop(context),
        //     icon: Icon(Icons.chevron_left)),
        title: Text(
          widget.patient.patientName,
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
            child: Text(widget.patient.gender),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.patient.dateOfBirth.toString().substring(0, 10)),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.patient.email),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(widget.patient.phone),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Patient Records",
              style: TextStyle(color: kMainColor, fontSize: 19),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: auth.DrPatientRecords.reversed
                  .map((e) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: selected != null && selected == e
                                ? kMainColor
                                : Colors.transparent,
                            border: Border.all(color: kMainColor, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(children: [
                          AutoSizeText(e.date.toString().substring(0, 16)),
                          SizedBox(
                            height: 20,
                          ),
                          AutoSizeText(
                            "Diagnos : " + e.diagnosis.toString(),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AutoSizeText(
                            "prescription : " + e.prescription,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ))
                  .toList(), // slots
            ),
          ),
        ]),
      ),
    );
  }
}
