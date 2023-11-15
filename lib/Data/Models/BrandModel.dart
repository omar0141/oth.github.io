class BrandModel {
  String? id;
  String? name;
  String? nameAlt;
  String? thumbnail;
  List<dynamic>? categories;

  BrandModel({
    required this.id,
    required this.name,
    required this.nameAlt,
    this.thumbnail,
    this.categories
  });

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    thumbnail = json['thumbnail'];
    categories = json['categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['thumbnail'] = this.thumbnail;
    data['categories'] = this.categories;
    return data;
  }
}
