class CategoreyModel {
  late String id;
  String? parentId;
  late String name;
  late String nameAlt;
  String? thumbnail;
  int? stock;
  int? products;

  CategoreyModel(
      {required this.id,
      this.parentId,
      required this.name,
      required this.nameAlt,
      this.thumbnail,
      this.stock,
      this.products});

  CategoreyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    thumbnail = json['thumbnail'];
    stock = json['stock'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['thumbnail'] = this.thumbnail;
    data['stock'] = this.stock;
    data['products'] = this.products;
    return data;
  }
}
