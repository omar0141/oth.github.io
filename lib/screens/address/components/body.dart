// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shakosh/models/Address.dart';
import 'package:shakosh/screens/sign_in/sign_in_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shakosh/constants.dart';
import 'package:shakosh/size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../controller/Address.dart';
import '../../../controller/dependants.dart';
import '../../../controller/phone_auth.dart';
import '../../../controller/social_auth.dart';
import '../../../helper/translation.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final id;
  final updat;
  Body({this.id, this.updat, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool? vfname;
  bool? vtel1;
  bool? vtel2;
  bool? vtitle;
  bool? vaddress1;
  bool? vaddress2;
  bool? vnotes;
  Position? cl;
  GlobalKey<FormState> formstateaddress = GlobalKey();
  TextEditingController tel1 = TextEditingController();
  TextEditingController tel2 = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController notes = TextEditingController();

  String? validtel1(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("valid-tel1");
    }
    if (val.trim().length < 11) {
      return Translation.get("valid-tel2");
    }
    if (val.trim().length > 12) {
      return Translation.get("valid-tel2");
    }
    return null;
  }

  String? validaddress(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("add-address");
    }
    if (val.trim().length < 10) {
      return Translation.get("add-address");
    }
    return null;
  }

  String? validtitle(String? val) {
    if (val!.trim().isEmpty) {
      return Translation.get("valid-title");
    }
    return null;
  }

  List countries = [];
  List new_areas = [];
  List new_branches = [];
  String? selected_country;
  List cities = [];
  String? selected_city;
  List areas = [];
  String? selected_area;
  getCountries() {
    countries = Provider.of<GetDependants>(context, listen: false).countries;
    new_branches =
        Provider.of<GetDependants>(context, listen: false).new_branches;
    cities = Provider.of<GetDependants>(context, listen: false).cities;
    areas = Provider.of<GetDependants>(context, listen: false).areas;
    new_areas = Provider.of<GetDependants>(context, listen: false).areas;
    setState(() {});
  }

  getDetails() {
    List<Address> adresses =
        Provider.of<MyAddress>(context, listen: false).addresses;
    int i = adresses.indexWhere((e) => e.id == widget.id);
    selected_area = adresses[i].area_id;
    selected_country = adresses[i].country_id;
    selected_city = adresses[i].city_id;
    tel1.text = adresses[i].tel1 == 'null' ? '' : adresses[i].tel1!;
    tel2.text = adresses[i].tel2 == 'null' ? '' : adresses[i].tel2!;
    address1.text = adresses[i].address == 'null' ? '' : adresses[i].address!;
    notes.text = adresses[i].notes == 'null' ? '' : adresses[i].notes!;
    title.text = adresses[i].name == 'null' ? '' : adresses[i].name!;
  }

  @override
  void initState() {
    getCountries();
    if (widget.updat == true) {
      getDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formstateaddress,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get('welcome'),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 34, 83),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get('hello-there-address'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("title"),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildtitleFormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get('country'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildCountryDropdown()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get('select-city'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildCitiesDropdown()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get('area'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildareaDropdown()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${Translation.get("address")} 1',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildaddress1FormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("tel") + '1',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildtel1FormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("address2"),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildaddress2FormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("tel") + '2',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildtel2FormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Translation.get("notes"),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 119, 133, 155),
                                  fontFamily: 'Circular'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: buildnotesFormField()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
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
                                  var formdata = formstateaddress.currentState!;
                                  if (formdata.validate()) {
                                    widget.updat == false
                                        ? await Provider.of<MyAddress>(context,
                                                listen: false)
                                            .add_address(
                                                context,
                                                title,
                                                selected_country,
                                                selected_city,
                                                selected_area,
                                                tel1,
                                                address1,
                                                tel2,
                                                address2,
                                                notes,
                                                null,
                                                null)
                                        : await Provider.of<MyAddress>(context,
                                                listen: false)
                                            .update_address(
                                                context,
                                                widget.id,
                                                title,
                                                selected_country,
                                                selected_city,
                                                selected_area,
                                                tel1,
                                                address1,
                                                tel2,
                                                address2,
                                                notes,
                                                null,
                                                null);
                                  }
                                }),
                                child: Text(
                                  Translation.get("continue"),
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
                    ]),
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.32),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildtitleFormField() {
    return TextFormField(
        validator: validtitle,
        controller: title,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vtitle = false;
          }
          if (e.isNotEmpty) {
            vtitle = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vtitle == false
                    ? Colors.red
                    : vtitle == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vtitle == false
                      ? Icons.close
                      : vtitle == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildtel1FormField() {
    return TextFormField(
        validator: validtel1,
        controller: tel1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vtel1 = false;
          }
          if (e.isNotEmpty) {
            vtel1 = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vtel1 == false
                    ? Colors.red
                    : vtel1 == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vtel1 == false
                      ? Icons.close
                      : vtel1 == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildtel2FormField() {
    return TextFormField(
        controller: tel2,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vtel2 = false;
          }
          if (e.isNotEmpty) {
            vtel2 = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vtel2 == false
                    ? Colors.red
                    : vtel2 == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vtel2 == false
                      ? Icons.close
                      : vtel2 == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildaddress1FormField() {
    return TextFormField(
        validator: validaddress,
        controller: address1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vaddress1 = false;
          }
          if (e.isNotEmpty) {
            vaddress1 = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vaddress1 == false
                    ? Colors.red
                    : vaddress1 == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vaddress1 == false
                      ? Icons.close
                      : vaddress1 == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildaddress2FormField() {
    return TextFormField(
        controller: address2,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vaddress2 = false;
          }
          if (e.isNotEmpty) {
            vaddress2 = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vaddress2 == false
                    ? Colors.red
                    : vaddress2 == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vaddress2 == false
                      ? Icons.close
                      : vaddress2 == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  TextFormField buildnotesFormField() {
    return TextFormField(
        controller: notes,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (e) {
          if (e == '') {
            vnotes = false;
          }
          if (e.isNotEmpty) {
            vnotes = true;
          }
          setState(() {});
        },
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 245, 246, 248),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 245, 246, 248),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
                backgroundColor: vnotes == false
                    ? Colors.red
                    : vnotes == true
                        ? Color.fromARGB(255, 0, 181, 248)
                        : Colors.transparent,
                radius: 5,
                child: Icon(
                  vnotes == false
                      ? Icons.close
                      : vnotes == true
                          ? Icons.done
                          : null,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            )));
  }

  DropdownButtonFormField buildCountryDropdown() {
    return DropdownButtonFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            selected_country = value;
          });
        }
        return null;
      },
      hint: Text(Translation.get('select-country')),
      validator: (value) =>
          value == null ? Translation.get('valid-country') : null,
      isExpanded: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 245, 246, 248),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 245, 246, 248),
          ),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 245, 246, 248),
      ),
      items: countries.map((data) {
        return DropdownMenuItem<String>(
          value: data['id'].toString(),
          child: Text(
            data[Translation.get('product-name')].toString(),
          ),
        );
      }).toList(),
    );
  }

  DropdownButtonFormField buildCitiesDropdown() {
    return DropdownButtonFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            selected_city = value;
            new_areas = [];
            new_branches = [];
            for (int i = 0; i < areas.length; i++) {
              if (areas[i]['city_id'].toString() == selected_city) {
                new_areas.add(areas[i]);
              }
            }
            debugPrint(selected_city.toString());
          });
        }
        return null;
      },
      hint: Text(Translation.get('select-city')),
      validator: (value) =>
          value == null ? Translation.get('valid-city') : null,
      isExpanded: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 245, 246, 248),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 245, 246, 248),
          ),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 245, 246, 248),
      ),
      items: cities.map((data) {
        return DropdownMenuItem<String>(
          value: data['id'].toString(),
          child: Text(
            data[Translation.get('product-name')].toString(),
          ),
        );
      }).toList(),
    );
  }

  DropdownButtonFormField buildareaDropdown() {
    return DropdownButtonFormField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            selected_area = value;
          });
        }
        return null;
      },
      hint: Text(Translation.get('select-area')),
      validator: (value) =>
          value == null ? Translation.get('valid-area') : null,
      isExpanded: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 245, 246, 248),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 245, 246, 248),
          ),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 245, 246, 248),
      ),
      items: new_areas.map((data) {
        return DropdownMenuItem<String>(
          value: data['id'].toString(),
          child: Text(
            data[Translation.get('product-name')].toString(),
          ),
        );
      }).toList(),
    );
  }
}
