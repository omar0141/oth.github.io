expandFlatList(data, childValue, parentKey, childKey) {
  List arr = [];
  // loop data
  // get key of arr/obj
  for (var i = 0; i < data.length; i++) {
    // easy access
    var obj = data[i];
    // check if in parent
    if (obj[childKey] == childValue) {
      // if in parent get children of current
      obj["children"] =
          expandFlatList(data, obj[parentKey], parentKey, childKey);
      // push onto big tree after finding Children
      arr.add(obj);
    }
  }
  // return arr
  return arr;
}

List<String> getBreadCrumbs(treeData, childValue, breadcrumbs) {
  List arr = [];
  for (var i = 0; i < treeData.length; i++) {
    getBreadCrumbsFromTree(treeData[i], childValue, breadcrumbs, arr);
  }
  if (arr.isNotEmpty) {
    return arr[0]["breadcrumbs"].toString().split(',');
  } else {
    return [];
  }
}

getBreadCrumbsFromTree(Map data, childValue, breadcrumbs, List arr) {
  if (breadcrumbs != null) {
    if (breadcrumbs == "") {
      data['breadcrumbs'] = data['id'];
    } else {
      data['breadcrumbs'] = breadcrumbs + "," + data['id'];
    }
  }
  if (data['id'] == childValue) {
    arr.add(data);
  }
  if (data['children'] != null) {
    for (var x in data['children']) {
      getBreadCrumbsFromTree(x, childValue, data['breadcrumbs'], arr);
    }
  }
}
