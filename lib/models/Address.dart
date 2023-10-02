// ignore_for_file: non_constant_identifier_names, file_names

class Address {
  String? id;
  String? name;
  String? address;
  String? branche_id;
  String? coordinates;
  String? tel1;
  String? tel2;
  String? city_id;
  String? area_id;
  String? country_id;
  String? notes;
  bool? selected;

  Address({
    this.tel1,
    this.coordinates,
    this.id,
    this.name,
    this.address,
    this.branche_id,
    this.selected,
    this.area_id,
    this.city_id,
    this.country_id,
    this.notes,
    this.tel2,
  });
}
