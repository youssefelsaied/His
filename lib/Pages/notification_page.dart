import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/data/notification.dart' as notifi;
import 'package:m3ak_user/widgets/notification_widget.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import '../../../../Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    // auth.setSeenNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final auth = Provider.of<Auth>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.notification!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          // var getNotifications = auth.getNotifications();

          List responses = await Future.wait([
            // getNotifications,
          ]);
          responses;
          // auth.setSeenNotifications();
          return;
        },
        child: FadedSlideAnimation(
          auth.userNotifications.isEmpty
              ? Center(
                  child: ListView(children: [
                    SizedBox(
                      height: height * .3,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    Center(
                      child: Text(
                        locale.no_notification!,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ]),
                )
              : ListView.builder(
                  itemCount: auth.userNotifications.length,
                  itemBuilder: (ctx, index) {
                    return Text('data');
                  }),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
