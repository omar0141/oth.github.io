class AddressModel {
  String? id;
  String? clientId;
  String? countryId;
  String? cityId;
  String? areaId;
  String? branchId;
  String? name;
  String? telephone1;
  String? telephone2;
  String? address1;
  String? address2;
  String? coordinates;
  String? notes;
  String? addstamp;
  String? updatestamp;

  AddressModel(
      {this.id,
      this.clientId,
      this.countryId,
      this.cityId,
      this.areaId,
      this.branchId,
      this.name,
      this.telephone1,
      this.telephone2,
      this.address1,
      this.address2,
      this.coordinates,
      this.notes,
      this.addstamp,
      this.updatestamp});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    branchId = json['branch_id'];
    name = json['name'];
    telephone1 = json['telephone1'];
    telephone2 = json['telephone2'];
    address1 = json['address1'];
    address2 = json['address2'];
    coordinates = json['coordinates'];
    notes = json['notes'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['telephone1'] = this.telephone1;
    data['telephone2'] = this.telephone2;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['coordinates'] = this.coordinates;
    data['notes'] = this.notes;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    return data;
  }
}
