class TaxesModel {
  String? id;
  String? code;
  String? name;
  String? nameAlt;
  String? description;
  String? descriptionAlt;
  String? equation;

  TaxesModel(
      {this.id,
      this.code,
      this.name,
      this.nameAlt,
      this.description,
      this.descriptionAlt,
      this.equation});

  TaxesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nameAlt = json['name_alt'];
    description = json['description'];
    descriptionAlt = json['description_alt'];
    equation = json['equation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['description'] = this.description;
    data['description_alt'] = this.descriptionAlt;
    data['equation'] = this.equation;
    return data;
  }
}
