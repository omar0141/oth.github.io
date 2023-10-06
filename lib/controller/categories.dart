// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shakosh/models/Category.dart';
import 'package:http/http.dart' as http;
import '../helper/translation.dart';
import '../new/Data/Remote/MyApi.dart';

class Getcategories extends ChangeNotifier {
  List<Category> get getsubcategories => subcategories;
  List<Category> subcategories = [];
  List<Category> get getcategories => categories;
  List<Category> categories = [];
  List<dynamic> shipping = [];
  List tags = [];
  List<dynamic> deals = [];
  List get gettags => tags;

  Future getGroups() async {
    var url = MyApi.home;
    var data = {"SID": MyApi.SID};
    var response = await http.post(Uri.parse(url), body: data);
    var responsebody = jsonDecode(response.body);
    log(responsebody['data']['shipping'].toString());
    getsubcategories.add(
      Category(
        parent_id: 0,
        id: null,
        name: Translation.get('all'),
        image: null,
        selected_id: 0,
      ),
    );
    deals = responsebody['data']['deals'];
    shipping = responsebody['data']['shipping'];
    for (int i = 0; i < responsebody['data']['tags'].length; i++) {
      try {
        tags.add(responsebody['data']['tags'][i]['tags'].split(',')[0]);
      } catch (e) {}
      try {
        tags.add(responsebody['data']['tags'][i]['tags'].split(',')[1]);
      } catch (e) {}
    }
    log(responsebody['data']['tags'].toString());
    for (int i = 0; i < responsebody['data']['categories'].length; i++) {
      if (responsebody['data']['categories'][i]['parent_id'] != null) {
        getsubcategories.add(
          Category(
            parent_id:
                int.parse(responsebody['data']['categories'][i]['parent_id']),
            id: int.parse(responsebody['data']['categories'][i]['id']),
            name: responsebody['data']['categories'][i]
                    [Translation.get('cat-name')]
                .toString(),
            image: (responsebody['data']['categories'][i]['thumbnail'] == null
                ? null
                : MyApi.media +
                    responsebody['data']['categories'][i]['thumbnail']
                        .toString()),
            selected_id: 0,
          ),
        );
      }
      if (responsebody['data']['categories'][i]['parent_id'] == null) {
        getcategories.add(
          Category(
            parent_id: null,
            id: int.parse(responsebody['data']['categories'][i]['id']),
            name: responsebody['data']['categories'][i]
                    [Translation.get('cat-name')]
                .toString(),
            image: (responsebody['data']['categories'][i]['thumbnail'] == null
                ? null
                : MyApi.media +
                    responsebody['data']['categories'][i]['thumbnail']
                        .toString()),
            selected_id: 0,
          ),
        );
      }
    }
    return responsebody;
  }

  Future getData() async {
    if (subcategories.isEmpty) {
      await getGroups();
      notifyListeners();
    }
  }

  void empty() {
    categories = [];
    subcategories = [];
    tags = [];
    notifyListeners();
  }

  void select_cat(Category cat) {
    for (int i = 0; i < getsubcategories.length; i++) {
      getsubcategories[i].selected_id = 0;
    }
    int index = getsubcategories.indexWhere((element) => element.id == cat.id);
    try {
      getsubcategories[index].selected_id = cat.id;
    } catch (e) {
      getsubcategories[0].selected_id = 0;
    }
    notifyListeners();
  }
}
