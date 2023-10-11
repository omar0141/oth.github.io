class CitiesModel {
  String? id;
  String? countryId;
  String? name;
  String? nameNative;
  String? addstamp;
  String? updatestamp;
  String? nameAlt;

  CitiesModel(
      {this.id,
      this.countryId,
      this.name,
      this.nameNative,
      this.addstamp,
      this.updatestamp,
      this.nameAlt});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    nameNative = json['name_native'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
    nameAlt = json['name_alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['name_native'] = this.nameNative;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    data['name_alt'] = this.nameAlt;
    return data;
  }
}
