// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:shakosh/constants.dart';
import 'package:shakosh/screens/google_map.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import 'package:shakosh/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/helper/translation.dart';
import 'package:shakosh/models/Address.dart';
import 'package:shakosh/screens/address/address_screen.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../controller/Address.dart';
import '../../enums.dart';

class Myaddresses extends StatefulWidget {
  bool? alert;
  Myaddresses({Key? key, this.alert}) : super(key: key);
  static String routeName = "/myaddress";
  @override
  _MyaddressesState createState() => _MyaddressesState();
}

class _MyaddressesState extends State<Myaddresses> {
  modalBottom(update, addrss) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (context) {
          return LayoutBuilder(builder: (context, con) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: con.maxWidth * 0.1),
                    child: InkWell(
                      onTap: () {
                        update == true
                            ? Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return GoogleMapScreen(
                                  update: true,
                                  address_id: addrss.id,
                                  coordinate: addrss.coordinates,
                                  tel1: addrss.tel1,
                                  title: addrss.name,
                                );
                              }))
                            : Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return GoogleMapScreen(
                                  update: false,
                                );
                              }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                update == true
                                    ? Translation.get('edit-your-location')
                                    : Translation.get('add-your-location'),
                                style: TextStyle(
                                    fontSize: 17, color: kPrimaryColor),
                              ),
                            ),
                            Icon(
                              Icons.my_location,
                              color: kPrimaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: con.maxWidth * 0.1),
                    child: InkWell(
                      onTap: () {
                        update == true
                            ? Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return AddressScreen(
                                  update: true,
                                  address_id: addrss.id,
                                );
                              }))
                            : Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return AddressScreen(
                                  update: false,
                                  address_id: '0',
                                );
                              }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                Translation.get('add-manually'),
                                style: TextStyle(
                                    fontSize: 17, color: kPrimaryColor),
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              color: kPrimaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(ProfileScreen.routeName);
        return false;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Provider.of<MyAddress>(context, listen: false)
                        .myaddresses
                        .isNotEmpty
                    ? Consumer<MyAddress>(builder: (context, address, child) {
                        return ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: address.myaddresses.length,
                            itemBuilder: (context, i) {
                              return cardaddress(
                                  address.myaddresses[i].name,
                                  address.myaddresses[i].address,
                                  address.myaddresses[i].branche_id,
                                  address.myaddresses[i]);
                            });
                      })
                    : Container(),
                Spacer(),
                Provider.of<MyAddress>(context, listen: true)
                            .myaddresses
                            .length >
                        2
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: (() async {
                                  modalBottom(false, null);
                                }),
                                child: Text(
                                  Translation.get('add-new-address'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Circular',
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
            Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomBottomNavBar(
                    selectedMenu: MenuState.profile,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      toolbarHeight: 200,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  Translation.get('addresses'),
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/address.png',
                    height: 100,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  InkWell cardaddress(
      String? title, String? address, String? branch, Address addrss) {
    return InkWell(
      onTap: (() {
        modalBottom(true, addrss);
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(35),
              spreadRadius: 7,
              blurRadius: 10,
              offset: Offset(-1, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Translation.get('title-address')} : $title',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontFamily: 'Circular',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${Translation.get('address')} : $address',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontFamily: 'Circular',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Provider.of<MyAddress>(context, listen: false)
                          .delete_address(addrss, context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.trashAlt,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
