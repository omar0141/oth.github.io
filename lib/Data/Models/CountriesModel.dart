class CountriesModel {
  String? id;
  String? iso3;
  String? name;
  String? nameNative;
  String? continents;
  String? phonecodes;
  String? currencies;
  String? languages;
  String? addstamp;
  String? updatestamp;
  String? nameAlt;

  CountriesModel(
      {this.id,
      this.iso3,
      this.name,
      this.nameNative,
      this.continents,
      this.phonecodes,
      this.currencies,
      this.languages,
      this.addstamp,
      this.updatestamp,
      this.nameAlt});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso3 = json['iso3'];
    name = json['name'];
    nameNative = json['name_native'];
    continents = json['continents'];
    phonecodes = json['phonecodes'];
    currencies = json['currencies'];
    languages = json['languages'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
    nameAlt = json['name_alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso3'] = this.iso3;
    data['name'] = this.name;
    data['name_native'] = this.nameNative;
    data['continents'] = this.continents;
    data['phonecodes'] = this.phonecodes;
    data['currencies'] = this.currencies;
    data['languages'] = this.languages;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    data['name_alt'] = this.nameAlt;
    return data;
  }
}
