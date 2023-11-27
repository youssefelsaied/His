import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Routes/routes.dart';
import '../../../../Locale/locale.dart';

class AppointmentBooked extends StatefulWidget {
  @override
  _AppointmentBookedState createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      locale.appointmentBooked!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    Spacer(flex: 4),
                    FadedScaleAnimation(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Image.asset(
                          'assets/Doctors/appointmentbooked.png',
                        ),
                      ),
                      durationInMilliseconds: 400,
                    ),
                    Spacer(flex: 3),
                    Text(
                      locale.yourAppointmentBooked!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.8),
                    ),
                    Spacer(flex: 1),
                    Text(
                      locale.checkMyAppointment!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Color(0xff6c6c6c), fontSize: 15),
                    ),
                    Spacer(flex: 4),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PageRoutes.appointmentPage);
                        },
                        label: locale.myAppointments,
                        radius: 0,
                      ),
                    ),
                  ],
                ),
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

//done
