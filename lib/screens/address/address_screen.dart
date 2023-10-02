// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shakosh/helper/translation.dart';
import 'components/body.dart';

class AddressScreen extends StatelessWidget {
  bool? update;
  String? address_id;
  AddressScreen({Key? key, this.update, this.address_id}) : super(key: key);
  static String routeName = "/address";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Body(
          id: address_id,
          updat: update,
        ),
      ),
    );
  }
}
