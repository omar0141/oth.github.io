class AreasModel {
  String? id;
  String? systemId;
  String? cityId;
  String? code;
  String? name;
  String? nameNative;
  String? active;
  String? deleted;
  String? addstamp;
  String? updatestamp;
  String? nameAlt;

  AreasModel(
      {this.id,
      this.systemId,
      this.cityId,
      this.code,
      this.name,
      this.nameNative,
      this.active,
      this.deleted,
      this.addstamp,
      this.updatestamp,
      this.nameAlt});

  AreasModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    systemId = json['system_id'];
    cityId = json['city_id'];
    code = json['code'];
    name = json['name'];
    nameNative = json['name_native'];
    active = json['active'];
    deleted = json['deleted'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
    nameAlt = json['name_alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['system_id'] = this.systemId;
    data['city_id'] = this.cityId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['name_native'] = this.nameNative;
    data['active'] = this.active;
    data['deleted'] = this.deleted;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    data['name_alt'] = this.nameAlt;
    return data;
  }
}
