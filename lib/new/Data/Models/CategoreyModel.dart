class CategoreyModel {
  late String id;
  String? parentId;
  String? name;
  String? nameAlt;
  String? thumbnail;
  List<dynamic>? brands;
  int? stock;
  int? products;
  List<CategoreyModel>? children;

  CategoreyModel(
      {required this.id,
      this.parentId,
      required this.name,
      required this.nameAlt,
      this.thumbnail,
      this.brands,
      this.stock,
      this.products,
      this.children});

  CategoreyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    thumbnail = json['thumbnail'];
    brands = json['brands'];
    stock = json['stock'];
    products = json['products'];
    children = json['children'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['thumbnail'] = this.thumbnail;
    data['brands'] = this.brands;
    data['stock'] = this.stock;
    data['products'] = this.products;
    data['children'] = this.children;
    return data;
  }
}
