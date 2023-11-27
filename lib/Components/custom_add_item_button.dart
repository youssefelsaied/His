import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:m3ak_user/Providers/menu_provider.dart';
import 'package:provider/provider.dart';
import '../../../../Routes/routes.dart';

class CustomAddItemButton extends StatefulWidget {
  final dynamic item;
  CustomAddItemButton({required this.item});
  @override
  State<CustomAddItemButton> createState() => _CustomAddItemButtonState();
}

class _CustomAddItemButtonState extends State<CustomAddItemButton> {
  @override
  Widget build(BuildContext context) {
    var menuProvider = Provider.of<MenuProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, PageRoutes.myCartPage);
        menuProvider.addItemOrOfferToMycart(widget.item);

        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (BuildContext context,
                StateSetter setModalState /*You can rename this!*/) {
              return Container(
                height: height * .3,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      height: height * .02,
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width,
                            height: height * .05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                      size: height * .04,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * .02,
                      color: Theme.of(context).primaryColor,
                    ),
                    Container(
                        height: height * .2,
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: width * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: width * .02,
                                ),
                                AutoSizeText(
                                  "item added to your cart.",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            Container(
                              height: height * .02,
                              color: Theme.of(context).primaryColor,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  Navigator.pushNamed(
                                      context, PageRoutes.myCartPage);
                                },
                                style: TextButton.styleFrom(
                                  // maximumSize: Size(width * .9, 20),
                                  fixedSize: Size(width * .9, height * .1),
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                child: AutoSizeText("GO TO CART")),
                          ],
                        )),
                  ],
                ),
              );
            });
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          color: Theme.of(context).primaryColor,
        ),
        height: 30,
        width: 30,
        child: Icon(
          Icons.add,
          size: 22,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
