import 'package:flutter/material.dart';
import 'package:m3ak_user/widgets/branch_card_order.dart';
import 'package:provider/provider.dart';

import '../Locale/locale.dart';
import '../Providers/auth.dart';
import '../Providers/menu_provider.dart';
import '../data/brands_by_category.dart';
import 'branch_card.dart';

class SelectBranchModel extends StatefulWidget {
  final Brand brand;
  const SelectBranchModel({Key? key, required this.brand}) : super(key: key);

  @override
  State<SelectBranchModel> createState() => _SelectBranchModelState();
}

class _SelectBranchModelState extends State<SelectBranchModel> {
  @override
  void initState() {
    super.initState();
    final menu = Provider.of<MenuProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    // menu.getBranchesByBrandsIdFirstTime(
    //     auth.theUser!.token, widget.brand.id!, 'ar');

    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      print(_scrollController.position.maxScrollExtent);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        print("new data called");
        fetchData();
      }
    });
  }

  final ScrollController _scrollController = ScrollController();
  bool loading = false;

  Future<void> fetchData() async {
    print("fitching data from selcet branch");
    setState(() {
      loading = true;
    });
    // if()
    final menu = Provider.of<MenuProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    // await menu.getBranchesByBrandsId(
    //     auth.theUser!.token, widget.brand.id!, 'ar');
    // setState(() {
    //   loading = false;
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final menu = Provider.of<MenuProvider>(context, listen: true);
    var theme = Theme.of(context);
    return StatefulBuilder(builder: (BuildContext context,
        StateSetter setModalState /*You can rename this!*/) {
      return Container(
        height: height * .4,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              height: height * .02,
            ),
            Container(
              color: Colors.white,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * .2,
                    height: height * .005,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ],
              ),
            ),
            Container(
              height: height * .02,
              color: Colors.white,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              height: height * .35,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: 1,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    print(menu.brandBranches.length);

                    return InkWell(
                      onTap: () {
                        // setModalState(() {});
                      },
                      child: menu.loading
                          ? Container(
                              // height: height * .4,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : Container(
                              // height: height * .4,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                removeBottom: true,
                                child: ListView.separated(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  // controller: _scrollController,
                                  // padding: EdgeInsets.only(top: 35.h, left: 16.w, right: 16.w),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: menu.brandBranches.length,
                                  itemBuilder: (context, index) {
                                    print(menu.brandBranches.length);

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print('tappinggg ');
                                            menu.selectBranchToOrder(
                                                menu.brandBranches[index]);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            color: menu.selectedNonCallCenterBranch !=
                                                        null &&
                                                    menu.selectedNonCallCenterBranch!
                                                            .id ==
                                                        menu
                                                            .brandBranches[
                                                                index]
                                                            .id
                                                ? Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.2)
                                                : Colors.transparent,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * .04,
                                                vertical: width * .02),
                                            child: BranchCardOrder(
                                              brand: widget.brand,
                                              branch: menu.brandBranches[index],
                                              inList: true,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 0.5,
                                          color: Colors.grey,
                                        ),
                                        loading &&
                                                menu.brandBranches.length ==
                                                    index + 1
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              )
                                            : SizedBox(
                                                height: 1,
                                              )
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
