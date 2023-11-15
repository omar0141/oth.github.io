class CouponsModel {
  int? id;
  String? code;
  String? name;
  String? nameAlt;
  String? thumbnail;
  String? discount_equation;
  CouponsModel(
      {this.id,
      this.thumbnail,
      this.name,
      this.nameAlt,
      this.code,
      this.discount_equation});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nameAlt = json['nameAlt'];
    thumbnail = json['thumbnail'];
    discount_equation = json['discount_equation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['thumbnail'] = this.thumbnail;
    data['discount_equation'] = this.discount_equation;
    return data;
  }
}
