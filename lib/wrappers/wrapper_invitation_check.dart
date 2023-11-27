import 'package:flutter/material.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:m3ak_user/wrappers/wrapper_home.dart';

import 'package:provider/provider.dart';

// import '../providers/auth.dart';

class WrapperInvitationCheck extends StatefulWidget {
  static const routeName = '/wrapper_phone';

  @override
  _WrapperInvitationCheckState createState() => _WrapperInvitationCheckState();
}

class _WrapperInvitationCheckState extends State<WrapperInvitationCheck> {
  @override
  Widget build(BuildContext ctx) {
    final auth = Provider.of<Auth>(context, listen: true);

    // bool checked = auth.theUser!.phoneNumber != '';
    return WrapperHome();
  }
}
