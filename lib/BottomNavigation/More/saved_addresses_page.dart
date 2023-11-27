import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:m3ak_user/Providers/auth.dart';
import 'package:provider/provider.dart';
import '../../../../Components/custom_button.dart';
import '../../../../Locale/locale.dart';
import '../../../../Routes/routes.dart';
import 'package:flutter/material.dart';

import '../../widgets/address_item.dart';

class SavedAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.chevron_left)),
          title: Text(
            AppLocalizations.of(context)!.savedAddresses!,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          SavedAddresses(height),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}

class SavedAddresses extends StatefulWidget {
  SavedAddresses(this.height);
  var height;
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final height = widget.height;
    return Container(
      color: Theme.of(context).dividerColor,
      child: RefreshIndicator(
        onRefresh: () async {
          // await auth.getAddressRequests();
          // return res ;
        },
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              // color: Colors.red,
              // height: height * .8,
              child: auth.avialableAddresses.isEmpty
                  ? Container(
                      height: height * .8,
                      child: Center(
                        child: Text('No Address Added'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: auth.avialableAddresses.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        print(auth.avialableAddresses[index].id);
                        return AddressItem(index: index);
                      }),
            ),
            CustomButton(
              icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
              label: AppLocalizations.of(context)!.addNewAddress,
              textColor: Theme.of(context).primaryColor,
              color: Theme.of(context).scaffoldBackgroundColor,
              onTap: () =>
                  Navigator.pushNamed(context, PageRoutes.locationPage),
              padding: height * .04,
            ),
          ],
        ),
      ),
    );
  }
}
