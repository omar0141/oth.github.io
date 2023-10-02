// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, non_constant_identifier_names, prefer_collection_literals, deprecated_member_use, unused_local_variable, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shakosh/models/Category.dart';
import 'package:shakosh/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakosh/components/coustom_bottom_nav_bar.dart';
import 'package:shakosh/components/navigation_drawer_widget.dart';
import 'package:shakosh/enums.dart';
import 'package:shakosh/controller/cart_wishlist.dart';
import 'package:shakosh/models/Item.dart';
import 'package:shakosh/screens/cart/cart_screen.dart';
import '../../components/product_card.dart';
import '../../constants.dart';
import '../../controller/Address.dart';
import '../../controller/MyApi.dart';
import '../../controller/categories.dart';
import '../../controller/dependants.dart';
import '../../controller/items.dart';
import '../../helper/translation.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cart/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  bool? login = false;
  String? CID;
  var user_id;
  HomeScreen({Key? key, this.login, this.CID}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  var user_id;
  String? username;
  String? address;
  String? address_id;

  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString('user_id');
    username = preferences.getString('name') ?? Translation.get('customer');
    // for display address name at top banner after "Delivery To:", fuck you ya omar
    address =
        preferences.getString('address') ?? Translation.get('pls-add-address');
    // for address selection indecator at bottom address select, fuck you ya omar
    address_id = MyApi.AddressId;
    debugPrint(address_id.toString());
    setState(() {});
  }

  showAddresses() {
    var addresses = Provider.of<MyAddress>(context, listen: false).myaddresses;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < addresses.length; i++)
                  InkWell(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      var branches =
                          Provider.of<GetDependants>(context, listen: false)
                              .new_branches;
                      int d = branches.indexWhere((element) =>
                          element['id'].toString() ==
                          addresses[i].branche_id.toString());
                      if (d == -1) {
                        d = branches.indexWhere((element) =>
                            element['area_id'] == addresses[i].area_id);
                      }
                      //
                      preferences.setString(
                          'BranchId', addresses[i].branche_id);
                      preferences.setString('address_id', addresses[i].id);
                      preferences.setString('address', addresses[i].address);
                      MyApi.SID = preferences.getString("branch")!;
                      MyApi.BranchId = preferences.getString("BranchId")!;
                      MyApi.AddressId = preferences.getString("address_id")!;
                      Provider.of<Getcategories>(context, listen: false)
                          .categories
                          .clear();
                      Provider.of<Getcategories>(context, listen: false)
                          .subcategories
                          .clear();

                      if (d != -1) {
                        preferences.setString('branch', branches[d]['SID']);
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO_REVERSED,
                          title: "There is no branches for this address",
                          btnOkColor: Colors.blue,
                          btnOkText: Translation.get("ok"),
                          btnOkOnPress: () {
                            Navigator.of(context).pop();
                          },
                        ).show();
                      }
                      Navigator.of(context).pushNamed(SplashScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      addresses[i].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "Circular",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(addresses[i].address,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: "Circular",
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                              if (address_id == addresses[i].id)
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 181, 248),
                                  radius: 15,
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Divider(
                                height: 5,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (addresses.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(Translation.get('no-addresses')),
                  )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    if (user_id == null) {
      getpref();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> items = [];
    DateTime? currentBackPressTime;
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        return Future.value(false);
      }
      return SystemNavigator.pop().then((value) => value as bool);
    }

    List<Category> categories =
        Provider.of<Getcategories>(context, listen: false).categories;

    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          key: _scaffoldkey,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (MyApi.BranchId == "")
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                margin: EdgeInsets.only(
                                    top: 20,
                                    left: MediaQuery.of(context).size.width *
                                        0.03,
                                    right: MediaQuery.of(context).size.width *
                                        0.03),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(220, 255, 248, 190),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_outlined,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        Translation.get('nobranch-warning'),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 78, 78, 78),
                                            fontFamily: 'Circular'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.02,
                                  top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showSearch(
                                          context: context,
                                          delegate: Search(
                                              list: Provider.of<Getcategories>(
                                                      context,
                                                      listen: false)
                                                  .gettags));
                                    },
                                    child: Container(
                                      width: 250,
                                      height: 50,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(child: Text('Search')),
                                          Container(
                                            height: 60,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 241, 241, 241),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Translation.get(
                                                              'language_iso') ==
                                                          'ar'
                                                      ? Radius.circular(0)
                                                      : Radius.circular(50),
                                                  bottomRight: Translation.get(
                                                              'language_iso') ==
                                                          'ar'
                                                      ? Radius.circular(0)
                                                      : Radius.circular(50),
                                                  topLeft: Translation.get(
                                                              'language_iso') ==
                                                          'en'
                                                      ? Radius.circular(0)
                                                      : Radius.circular(50),
                                                  bottomLeft: Translation.get(
                                                              'language_iso') ==
                                                          'en'
                                                      ? Radius.circular(0)
                                                      : Radius.circular(50)),
                                            ),
                                            child: Icon(
                                              Icons.search,
                                              color: Color.fromARGB(
                                                  255, 95, 98, 104),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 209, 209, 209))),
                                    ),
                                  ),
                                  Consumer<Cart>(
                                      builder: (context, mycart, child) {
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return MyCart();
                                        }));
                                      },
                                      child: SizedBox(
                                        width: getProportionateScreenWidth(60),
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/images/cart.png',
                                              width: 50,
                                              height: 50,
                                            ),
                                            if (mycart.count != 0)
                                              Positioned(
                                                top: 20,
                                                left: Translation.get(
                                                            'language_iso') ==
                                                        'en'
                                                    ? 40
                                                    : null,
                                                right: Translation.get(
                                                            'language_iso') ==
                                                        'en'
                                                    ? null
                                                    : 40,
                                                child: Container(
                                                  height:
                                                      getProportionateScreenWidth(
                                                          20),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          20),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFF4848),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${mycart.count}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 1,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Categories(),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomBottomNavBar(
                        selectedMenu: MenuState.home,
                      ),
                    ))
              ],
            ),
          ),
          drawer: NavigationDrawerWidget(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            toolbarHeight: 100,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _scaffoldkey.currentState!.openDrawer();
                      },
                      padding: EdgeInsets.all(4.0),
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${Translation.get('hello')}, ${username}',
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            Translation.get('you-in-the-right'),
                            maxLines: 2,
                            style:
                                TextStyle(fontFamily: 'Circular', fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      width: 60,
                    ),
                  ],
                ),
                if (user_id != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showAddresses();
                        },
                        child: SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                Translation.get('delivery-to'),
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Circular'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 85,
                                child: Text(
                                  address ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, fontFamily: 'Circular'),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ));
  }
}

class Search extends SearchDelegate<String> {
  String? branche_id;
  List<dynamic>? list;
  Search({this.branche_id, this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    Provider.of<Getcategoryitems>(context, listen: false)
        .getitemscat(null, context, null, query, 0, null);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Consumer<Getcategoryitems>(builder: (context, value, _) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.26)),
            itemCount: value.getsearch.length,
            itemBuilder: (context, i) {
              if (value.getsearch.isNotEmpty) {
                return ProductCard(
                  value.getsearch[i],
                  false,
                  Color.fromARGB(255, 248, 167, 0),
                );
              } else {
                return const CircularProgressIndicator();
              }
            });
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchlist = query.isEmpty
        ? list!
        : list!
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(searchlist[i].toString()),
            onTap: () {
              query = searchlist[i];
              showResults(context);
            },
          );
        });
  }
}
