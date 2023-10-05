class BrandModel {
  late String id;
  late String name;
  late String nameAlt;
  String? thumbnail;

  BrandModel({
    required this.id,
    required this.name,
    required this.nameAlt,
    this.thumbnail,
  });

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
