// ignore_for_file: non_constant_identifier_names

import 'package:flutter/Material.dart';
import 'package:shakosh/controller/variants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../helper/translation.dart';
import '../new/Data/Remote/MyApi.dart';

class ProductDetailsC with ChangeNotifier {
  List images = [];
  String? brief = '';
  String? description = '';

  Future getData(itm_no, context) async {
    var url = MyApi.productDetails;
    var data = {'SID': MyApi.SID, 'product_id': itm_no};
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    debugPrint(responsebody.toString());
    images = [];
    if (responsebody.length != 0) {
      for (int i = 0; i < responsebody['data']['media'].length; i++) {
        images.add(MyApi.media + responsebody['data']['media'][i]['filename']);
      }
    } else {
      images = ['https://dhbs.pythonanywhere.com/media/notfound.jpg'];
    }
    responsebody['data']['product'][Translation.get('bref')] != null
        ? brief = responsebody['data']['product'][Translation.get('bref')]
        : brief = Translation.get('no-desc');
    responsebody['data']['product'][Translation.get('desc')] != null
        ? description = responsebody['data']['product'][Translation.get('desc')]
        : description = Translation.get('no-desc');
    Provider.of<GetVariants>(context, listen: false).reset();
    return images;
  }
}
