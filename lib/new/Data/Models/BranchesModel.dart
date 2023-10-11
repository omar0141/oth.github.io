class BranchesModel {
  String? id;
  String? countryId;
  String? cityId;
  String? areaId;
  String? name;
  String? nameAlt;
  String? address;
  String? addressAlt;
  String? coordinates;
  String? sID;
  int? deliveryDistanceKm;

  BranchesModel(
      {this.id,
      this.countryId,
      this.cityId,
      this.areaId,
      this.name,
      this.nameAlt,
      this.address,
      this.addressAlt,
      this.coordinates,
      this.sID,
      this.deliveryDistanceKm});

  BranchesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    address = json['address'];
    addressAlt = json['address_alt'];
    coordinates = json['coordinates'];
    sID = json['SID'];
    deliveryDistanceKm = json['delivery_distance_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['address'] = this.address;
    data['address_alt'] = this.addressAlt;
    data['coordinates'] = this.coordinates;
    data['SID'] = this.sID;
    data['delivery_distance_km'] = this.deliveryDistanceKm;
    return data;
  }
}
