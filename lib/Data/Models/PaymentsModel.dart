class PaymentsModel {
  String? id;
  String? name;
  String? description;
  String? iconData;
  String? dataKeys;
  String? dataValues;

  PaymentsModel(
      {this.id,
      this.name,
      this.description,
      this.iconData,
      this.dataKeys,
      this.dataValues});

  PaymentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    iconData = json['icon_data'];
    dataKeys = json['data_keys'];
    dataValues = json['data_values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon_data'] = this.iconData;
    data['data_keys'] = this.dataKeys;
    data['data_values'] = this.dataValues;
    return data;
  }
}
