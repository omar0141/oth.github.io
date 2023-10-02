// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_print, unnecessary_string_interpolations
import 'package:shakosh/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shakosh/controller/dependants.dart';
import 'package:provider/provider.dart';
import 'package:shakosh/components/default_button.dart';
import 'package:shakosh/controller/Address.dart';
import '../../../helper/translation.dart';
import '../../../size_config.dart';

class AddressForm extends StatefulWidget {
  bool? update;
  String? address_id;
  AddressForm({Key? key, this.update, this.address_id}) : super(key: key);
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
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

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formstateaddress,
      child: Column(
        children: [
          buildtitleFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildCountryDropdown(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildCitiesDropdown(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildareaDropdown(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildaddress1FormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildtel1FormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildaddress2FormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildtel2FormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildnotesFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          DefaultButton(
            text: Translation.get("continue"),
            press: () async {
              var formdata = formstateaddress.currentState!;
              if (formdata.validate()) {
                widget.update == false
                    ? await Provider.of<MyAddress>(context, listen: false)
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
                    : await Provider.of<MyAddress>(context, listen: false)
                        .update_address(
                            context,
                            widget.address_id,
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
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildtitleFormField() {
    return TextFormField(
      validator: validtitle,
      controller: title,
      decoration: InputDecoration(
        labelText: Translation.get("title"),
        hintText: Translation.get("enter-title"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildtel1FormField() {
    return TextFormField(
      validator: validtel1,
      controller: tel1,
      decoration: InputDecoration(
        labelText: Translation.get("tel") + '1',
        hintText: Translation.get("enter-tel") + '1',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.phone,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildtel2FormField() {
    return TextFormField(
      controller: tel2,
      decoration: InputDecoration(
        labelText: Translation.get("tel") + '2',
        hintText: Translation.get("enter-tel") + '2',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.phone,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildaddress1FormField() {
    return TextFormField(
      validator: validaddress,
      controller: address1,
      decoration: InputDecoration(
        labelText: Translation.get("address"),
        hintText: Translation.get("enter-address"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.location_on,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildaddress2FormField() {
    return TextFormField(
      controller: address2,
      decoration: InputDecoration(
        labelText: Translation.get("address2"),
        hintText: Translation.get("enter-address2"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.location_on,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
  }

  TextFormField buildnotesFormField() {
    return TextFormField(
      controller: notes,
      decoration: InputDecoration(
        labelText: Translation.get("notes"),
        hintText: Translation.get("enter-notes"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(
          Icons.note,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
      ),
    );
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
        labelText: '${Translation.get('country')}',
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        labelText: Translation.get('select-city'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        labelText: Translation.get('area'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
