// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:shakosh/models/Address.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/loading.dart';
import '../helper/translation.dart';
import '../screens/home/home_screen.dart';
import '../screens/myaddresses/myaddress_screen.dart';
import 'MyApi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dependants.dart';

class MyAddress with ChangeNotifier {
  List<Address> addresses = [];

  Future getAddresses(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var url = MyApi.getAddresses;
    var data = {'SID': MyApi.SID, "CID": user_id};
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    addresses = [];
    for (int i = 0; i < responsebody['data'].length; i++) {
      Provider.of<MyAddress>(context, listen: false).myaddresses.add(Address(
          id: responsebody['data'][i]['id'].toString(),
          address: responsebody['data'][i]['address1'].toString(),
          name: responsebody['data'][i]['name'].toString(),
          coordinates: responsebody['data'][i]['coordinates'].toString(),
          tel1: responsebody['data'][i]['telephone1'].toString(),
          area_id: responsebody['data'][i]['area_id'].toString(),
          city_id: responsebody['data'][i]['city_id'].toString(),
          country_id: responsebody['data'][i]['country_id'].toString(),
          branche_id: responsebody['data'][i]['branch_id'].toString(),
          notes: responsebody['data'][i]['notes'].toString(),
          tel2: responsebody['data'][i]['telephone2'].toString(),
          selected: false));
    }
    return responsebody;
  }

  add_address(
      BuildContext context,
      title,
      selected_country,
      selected_city,
      selected_area,
      tel1,
      address1,
      tel2,
      address2,
      notes,
      coordinates,
      branch_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    Loading().showloading(context);
    var data = {
      'SID': MyApi.SID,
      "CID": user_id,
      "name": title.text,
    };
    if (selected_country != null) {
      data['country_id'] = selected_country;
    }
    if (selected_city != null) {
      data['city_id'] = selected_city;
    }
    if (selected_area != null) {
      data['area_id'] = selected_area;
    }
    if (tel1 != null) {
      data['telephone1'] = tel1.text;
    }
    if (tel2 != null) {
      data['telephone2'] = tel2.text;
    }
    if (address1 != null) {
      data['address1'] = address1.text;
    }
    if (address2 != null) {
      data['address2'] = address2.text;
    }
    if (notes != null) {
      data['notes'] = notes.text;
    }
    if (coordinates != null) {
      data['coordinates'] = coordinates;
    }
    if (branch_id != null) {
      data['branch_id'] = branch_id;
    }
    var url = MyApi.AddAddress;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint(responsebody.toString());
    if (responsebody['error'] == null && responsebody['status'] == 200) {
      Provider.of<MyAddress>(context, listen: false).myaddresses.add(Address(
          id: responsebody['data']['address_id'].toString(),
          name: title.text,
          address: address1.text,
          area_id: selected_area,
          city_id: selected_city,
          coordinates: coordinates,
          country_id: selected_country,
          branche_id: branch_id,
          notes: notes == null ? '' : notes.text,
          tel1: tel1 == null ? '' : tel1.text,
          tel2: tel2 == null ? '' : tel2.text,
          selected: false));
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        title: Translation.get("success"),
        desc: Translation.get("address-success"),
        btnOkColor: Colors.green,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.pushNamed(context, Myaddresses.routeName);
        },
      ).show();
    } else if (responsebody['error'] == 'max_address_count_reached' &&
        responsebody['status'] == 200) {
      debugPrint('failed');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("address-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      ).show();
    }
  }

  update_address(
      BuildContext context,
      address_id,
      title,
      selected_country,
      selected_city,
      selected_area,
      tel1,
      address1,
      tel2,
      address2,
      notes,
      coordinates,
      branch_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    Loading().showloading(context);

    var data = {
      'SID': MyApi.SID,
      "CID": user_id,
      "name": title.text,
      "address_id": address_id
    };
    if (selected_country != null) {
      data['country_id'] = selected_country;
    }
    if (selected_city != null) {
      data['city_id'] = selected_city;
    }
    if (selected_area != null) {
      data['area_id'] = selected_area;
    }
    if (tel1 != null) {
      data['telephone1'] = tel1.text;
    }
    if (tel2 != null) {
      data['telephone2'] = tel2.text;
    }
    if (address1 != null) {
      data['address1'] = address1.text;
    }
    if (address2 != null) {
      data['address2'] = address2.text;
    }
    if (notes != null) {
      data['notes'] = notes.text;
    }
    if (coordinates != null) {
      data['coordinates'] = coordinates;
    }
    if (branch_id != null) {
      data['branch_id'] = branch_id;
    }
    var url = MyApi.UpdateAddress;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(data.toString());
    debugPrint(responsebody.toString());
    if (responsebody['status'] == 200) {
      Provider.of<MyAddress>(context, listen: false).update(Address(
          id: address_id,
          name: title.text,
          address: address1.text,
          area_id: selected_area,
          city_id: selected_city,
          coordinates: coordinates,
          country_id: selected_country,
          branche_id: branch_id,
          notes: notes == null ? '' : notes.text,
          tel1: tel1 == null ? '' : tel1.text,
          tel2: tel2 == null ? '' : tel2.text,
          selected: false));
      if (address_id == MyApi.AddressId) {
        MyApi.AddressId = address_id;
        MyApi.BranchId = branch_id;
        preferences.setString('BranchId', branch_id);
        preferences.setString('address_id', address_id);
        preferences.setString('address', address1.text);
      }
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        title: Translation.get("success"),
        desc: Translation.get("address-success"),
        btnOkColor: Colors.green,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.pushNamed(context, Myaddresses.routeName);
        },
      ).show();
    } else {
      debugPrint('failed');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: Translation.get("error"),
        desc: Translation.get("address-error"),
        btnOkColor: Colors.red,
        btnOkText: Translation.get("ok"),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      ).show();
    }
  }

  delete_address(Address adrs, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString('user_id');
    var data = {
      'SID': MyApi.SID,
      "CID": user_id.toString(),
      "address_id": adrs.id,
    };
    var url = MyApi.deleteAddress;
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    if (responsebody['status'] == 200) {
      Provider.of<MyAddress>(context, listen: false).remove(adrs);
      if (MyApi.AddressId == adrs.id) {
        MyApi.AddressId = "";
        MyApi.BranchId = "";
        preferences.remove('BranchId');
        preferences.remove('address_id');
        preferences.remove('address');
      }
    } else {
      debugPrint('valid');
    }
  }

  void add(Address addres) {
    addresses.add(addres);
    notifyListeners();
  }

  void update(Address addres) {
    int index = 0;
    index = addresses.indexWhere((element) => element.id == addres.id);
    addresses.removeAt(index);
    addresses.add(addres);
    notifyListeners();
  }

  void remove(Address addres) {
    int index = 0;
    index = addresses.indexWhere((element) => element.id == addres.id);
    addresses.removeAt(index);
    notifyListeners();
  }

  void empty() {
    addresses = [];
    notifyListeners();
  }

  List get myaddresses {
    return addresses;
  }
}
