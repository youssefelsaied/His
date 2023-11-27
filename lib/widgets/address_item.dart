import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/auth.dart';

class AddressItem extends StatefulWidget {
  AddressItem({required this.index});
  var index;
  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  bool deleteLoading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Padding(
      padding: EdgeInsets.only(top: 6.0),
      child: ListTile(
        tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Column(
          children: [
            Icon(
              (auth.avialableAddresses[widget.index].title == "Home" ||
                      auth.avialableAddresses[widget.index].title == "منزل")
                  ? Icons.home
                  : (auth.avialableAddresses[widget.index].title == "Office" ||
                          auth.avialableAddresses[widget.index].title ==
                              "Office")
                      ? Icons.local_post_office
                      : Icons.other_houses_outlined,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ],
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(auth.avialableAddresses[widget.index].title!,
              style: Theme.of(context).textTheme.bodyText1!),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              auth.avialableAddresses[widget.index].address!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 13, color: Color(0xff666666)),
            ),
            Text(
              auth.avialableAddresses[widget.index].latitude.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 13, color: Color(0xff666666)),
            ),
          ],
        ),
        trailing: deleteLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : IconButton(
                onPressed: () async {
                  setState(() {
                    deleteLoading = true;
                  });
                  // await auth.DeleteAddressRequests(
                  //     id: auth.avialableAddresses[widget.index].id);

                  setState(() {
                    deleteLoading = false;
                  });
                },
                icon: Icon(Icons.delete),
              ),
      ),
    );
  }
}
