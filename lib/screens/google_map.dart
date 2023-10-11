// // ignore_for_file: implementation_imports, library_prefixes, non_constant_identifier_names, prefer_collection_literals, prefer_const_constructors, avoid_print, unused_local_variable

// import 'dart:async';
// import 'package:shakosh/models/Address.dart';
// import 'package:shakosh/screens/address/address_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shakosh/components/default_button.dart';
// import 'package:shakosh/new/Data/Remote/MyApi.dart';
// import 'package:shakosh/helper/translation.dart';
// import 'package:shakosh/screens/splash/splash_screen.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:provider/provider.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geocoding_platform_interface/src/models/location.dart'
//     as Location1;
// import 'dart:io' show Platform;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../constants.dart';
// import '../controller/Address.dart';
// import '../controller/dependants.dart';
// import '../size_config.dart';
// import 'myaddresses/myaddress_screen.dart';

// class GoogleMapScreen extends StatefulWidget {
//   static String routeName = "/google_map";
//   bool? update;
//   String? address_id;
//   String? title;
//   String? tel1;
//   String? coordinate;

//   GoogleMapScreen(
//       {this.coordinate,
//       this.tel1,
//       this.title,
//       this.address_id,
//       this.update,
//       Key? key})
//       : super(key: key);
//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }

// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   CameraPosition? _kGooglePlex;
//   late Position cl;
//   late GoogleMapController gmc;
//   LatLng? mylatlng;
//   BitmapDescriptor? pin_icon;
//   BitmapDescriptor? branch_icon;
//   Set<Circle> circles = Set();
//   double clat = 0;
//   double clong = 0;
//   List distances = [];
//   String? branch_id;
//   List<dynamic> branches = [];
//   bool up = false;
//   TextEditingController address = TextEditingController();
//   TextEditingController tel = TextEditingController();
//   TextEditingController title = TextEditingController();

// //  void changeMapMode(GoogleMapController mapController) {
// //     getJsonFile("assets/map_style.json")
// //         .then((value) => setMapStyle(value, mapController));
// //   }

// //   //helper function
// //   void setMapStyle(String mapStyle, GoogleMapController mapController) {
// //     mapController.setMapStyle(mapStyle);
// //   }

// //   //helper function
// //   Future<String> getJsonFile(String path) async {
// //     ByteData byte = await rootBundle.load(path);
// //     var list = byte.buffer.asUint8List(byte.offsetInBytes,byte.lengthInBytes);
// //     return utf8.decode(list);
// //   }

//   Future getlocation() async {
//     branches = Provider.of<GetDependants>(context, listen: false).new_branches;

//     if (Platform.isAndroid) {
//       pin_icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(),
//         'assets/icons/pin_android.png',
//       );
//       branch_icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(),
//         'assets/icons/store_pin_android.png',
//       ); // 102px X 102px
//     } else if (Platform.isIOS) {
//       pin_icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(),
//         'assets/icons/pin_ios.png',
//       );
//       branch_icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(),
//         'assets/icons/store_pin_ios.png',
//       ); // 102px X 102px
//     }

//     bool services;
//     LocationPermission? per;
//     services = await Geolocator.isLocationServiceEnabled();
//     if (services == false) {
//       per = await Geolocator.checkPermission();
//     }
//     if (per == LocationPermission.denied) {
//       per == await Geolocator.requestPermission();
//     }
//     cl = await Geolocator.getCurrentPosition().then((value) => value);
//     if (widget.update == true) {
//       double blat = double.parse(widget.coordinate == null
//           ? '30.959694'
//           : widget.coordinate.toString().split(',')[0]);
//       double blong = double.parse(widget.coordinate == null
//           ? '31.959694'
//           : widget.coordinate.toString().split(',')[1]);
//       mylatlng = LatLng(blat, blong);
//     } else {
//       mylatlng = LatLng(cl.latitude, cl.longitude);
//     }

//     debugPrint(mylatlng.toString());
//     gmc.animateCamera(CameraUpdate.newLatLngZoom(mylatlng!, 12));
//     double lat = 0;
//     double long = 0;
//     for (var i = 0; i < branches.length; i++) {
//       try {
//         lat = double.parse(branches[i]["coordinates"].toString().split(',')[0]);
//         long =
//             double.parse(branches[i]["coordinates"].toString().split(',')[1]);
//       } catch (e) {
//         lat = 30.959694;
//         long = 31.253715;
//       }
//       mymarker.add(Marker(
//           markerId: MarkerId('${branches[i]["id"]}'),
//           position: LatLng(lat, long),
//           consumeTapEvents: true,
//           icon: branch_icon!,
//           onTap: () {
//             double ds = Geolocator.distanceBetween(clat, clong, lat, long);
//             if (ds <= 10000) {
//               MyApi.SID = branches[i]["SID"].toString();
//               MyApi.BranchId = branches[i]["id"].toString();
//               Navigator.of(context).pushNamed(SplashScreen.routeName);
//             } else {}
//           }));
//     }
//     mymarker.add(
//         Marker(markerId: MarkerId('1'), position: mylatlng!, icon: pin_icon!));
//     circles.add(Circle(
//         circleId: CircleId('1'),
//         center: mylatlng!,
//         radius: 10000,
//         fillColor: Colors.blue.withOpacity(0.5),
//         strokeWidth: 1,
//         strokeColor: Colors.blue));

//     setState(() {});
//   }

//   getds(lat, long) {
//     distances = [];
//     branches = Provider.of<GetDependants>(context, listen: false).new_branches;
//     for (var i = 0; i < branches.length; i++) {
//       double blat = 0;
//       double blong = 0;
//       try {
//         blat =
//             double.parse(branches[i]["coordinates"].toString().split(',')[0]);
//         blong =
//             double.parse(branches[i]["coordinates"].toString().split(',')[1]);
//       } catch (e) {
//         blat = 29.959694;
//         blong = 31.253715;
//       }

//       double ds = Geolocator.distanceBetween(lat, long, blat, blong);
//       if (ds <= 10000) {
//         distances.add([branches[i]["SID"], ds, branches[i]["id"]]);
//         distances.sort((a, b) => a[1].compareTo(b[1]));
//         debugPrint(ds.toString());
//       }
//     }
//     if (distances.length > 0) {
//       MyApi.SID = distances.first[0].toString();
//       branch_id = distances.first[2].toString();
//       MyApi.BranchId = distances.first[3].toString();
//       debugPrint(branch_id.toString());
//       debugPrint(distances.toString());
//     }
//   }

//   changemarker(latlng) async {
//     if (pin_icon == null || branch_icon == null) {
//       pin_icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(),
//         'assets/icons/pin.png',
//       );
//       branch_icon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(),
//         'assets/icons/store_pin.png',
//       );
//     }
//     mymarker.remove(
//         Marker(markerId: MarkerId('1'), position: latlng, icon: pin_icon!));
//     mymarker.add(
//         Marker(markerId: MarkerId('1'), position: latlng, icon: pin_icon!));

//     circles.add(Circle(
//         circleId: CircleId('1'),
//         center: latlng,
//         radius: 10000,
//         fillColor: Colors.blue.withOpacity(0.2),
//         strokeWidth: 1,
//         strokeColor: Colors.blue));
//   }

//   Set<Marker> mymarker = {};

//   Future<void> getLangAndLong() async {
//     double blat = double.parse(widget.coordinate == null
//         ? '30.0'
//         : widget.coordinate.toString().split(',')[0]);
//     double blong = double.parse(widget.coordinate == null
//         ? '31.0'
//         : widget.coordinate.toString().split(',')[1]);

//     _kGooglePlex = CameraPosition(
//       target: LatLng(blat, blong),
//       zoom: 10,
//     );
//   }

//   @override
//   initState() {
//     (() async {
//       await Provider.of<GetDependants>(context, listen: false).getDependants();
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       String? user_id = preferences.getString("user_id");
//       String? address = preferences.getString("address");
//       if (user_id != null) {
//         await Provider.of<MyAddress>(context, listen: false)
//             .getAddresses(context);

//         var addresses =
//             Provider.of<MyAddress>(context, listen: false).myaddresses;

//         if (addresses.isNotEmpty && widget.update == null) {
//           Navigator.of(context).pushNamed(SplashScreen.routeName);
//         }
//       }
//       debugPrint(widget.update.toString());
//       getlocation();
//     })();
//     getLangAndLong();
//     super.initState();
//   }

//   var kGoogleApiKey = "AIzaSyAaBQXST5KqTnpihb8xFxvkccsExJiRCSE";
//   places() async {
//     List<Location1.Location> locations;
//     Prediction p = await PlacesAutocomplete.show(
//       offset: 0,
//       radius: 1000,
//       strictbounds: false,
//       decoration: InputDecoration(contentPadding: EdgeInsets.all(10)),
//       region: "eg",
//       language: "ar",
//       context: context,
//       logo: Container(),
//       mode: Mode.fullscreen,
//       apiKey: kGoogleApiKey,
//       components: [Component(Component.country, "eg")],
//       types: [""],
//       // ignore: missing_return
//     ).then((value) async {
//       locations = await locationFromAddress(value!.description!);
//       gmc.animateCamera(CameraUpdate.newLatLngZoom(
//           LatLng(locations[0].latitude, locations[0].longitude), 12));
//       address.text = value.description!;

//       debugPrint(value.description.toString());
//       return value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SafeArea(
//       child: Scaffold(
//         body: _kGooglePlex == null
//             ? Center(child: CircularProgressIndicator())
//             : Container(
//                 height: double.infinity,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/background.png"),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30),
//                         child: Text(
//                           Translation.get('delivery-location'),
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Circular',
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           places();
//                         },
//                         child: Container(
//                           margin: EdgeInsets.all(10),
//                           width: double.infinity,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 15),
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 9, 27, 86),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.search,
//                                 color: Color.fromARGB(199, 255, 255, 255),
//                                 size: 30,
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 child: Text(
//                                   address.text,
//                                   overflow: TextOverflow.clip,
//                                   maxLines: 1,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.white,
//                                       fontFamily: 'Circular',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 20),
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                                 Color.fromARGB(255, 142, 215, 248)),
//                             padding: MaterialStateProperty.all(
//                                 EdgeInsets.symmetric(horizontal: 30)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(18.0),
//                               ),
//                             ),
//                           ),
//                           onPressed: (() async {
//                             SharedPreferences preferences =
//                                 await SharedPreferences.getInstance();
//                             String? user_id = preferences.getString("user_id");
//                             if (user_id == null && widget.update == null) {
//                               await preferences.setString(
//                                   "address", address.text);
//                               await preferences.setString(
//                                   "coordinates", '$clat,$clong');

//                               Navigator.of(context)
//                                   .pushNamed(SplashScreen.routeName);
//                             }
//                             tel.text = preferences.getString("tel") ?? '';

//                             getds(clat, clong);
//                             if (widget.update == false) {
//                               await Provider.of<MyAddress>(context,
//                                       listen: false)
//                                   .add_address(
//                                       context,
//                                       address,
//                                       null,
//                                       null,
//                                       null,
//                                       tel,
//                                       address,
//                                       null,
//                                       null,
//                                       null,
//                                       '$clat,$clong',
//                                       branch_id);
//                               Navigator.of(context)
//                                   .pushNamed(Myaddresses.routeName);
//                             }
//                             if (widget.update == true) {
//                               title.text = widget.title!;
//                               tel.text = widget.tel1!;
//                               await Provider.of<MyAddress>(context,
//                                       listen: false)
//                                   .update_address(
//                                       context,
//                                       widget.address_id,
//                                       widget.title == 'null' ? null : title,
//                                       null,
//                                       null,
//                                       null,
//                                       widget.tel1 == 'null' ? null : tel,
//                                       address,
//                                       null,
//                                       null,
//                                       null,
//                                       '$clat,$clong',
//                                       branch_id);
//                               Navigator.of(context)
//                                   .pushNamed(Myaddresses.routeName);
//                             }
//                             if (widget.update == null && user_id != null) {
//                               await preferences.setString("branch", MyApi.SID);
//                               await Provider.of<MyAddress>(context,
//                                       listen: false)
//                                   .add_address(
//                                       context,
//                                       address,
//                                       null,
//                                       null,
//                                       null,
//                                       tel,
//                                       address,
//                                       null,
//                                       null,
//                                       null,
//                                       '$clat,$clong',
//                                       branch_id);
//                               Navigator.of(context)
//                                   .pushNamed(SplashScreen.routeName);
//                             }
//                           }),
//                           child: Text(
//                             Translation.get('continue'),
//                             style: TextStyle(
//                                 color: kPrimaryColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Circular',
//                                 fontSize: 17),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             topRight: Radius.circular(30),
//                             bottomRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(30),
//                           ),
//                           child: SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.5,
//                             child: GoogleMap(
//                               mapType: MapType.normal,
//                               buildingsEnabled: false,
//                               markers: mymarker,
//                               circles: circles,
//                               zoomControlsEnabled: true,
//                               initialCameraPosition: _kGooglePlex!,
//                               myLocationEnabled: !kReleaseMode ? false : true,
//                               myLocationButtonEnabled: true,
//                               onMapCreated: (GoogleMapController controller) {
//                                 gmc = controller;
//                                 // changeMapMode(gmc);
//                               },
//                               onCameraIdle: () async {
//                                 List<Placemark> placemarks =
//                                     await placemarkFromCoordinates(clat, clong);
//                                 address.text = placemarks[0].street!;
//                                 setState(() {});
//                               },
//                               onCameraMove: (e) {
//                                 changemarker(e.target);
//                                 clat = e.target.latitude;
//                                 clong = e.target.longitude;
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
