// ignore_for_file: non_constant_identifier_names, file_names

class Payments {
  String? id;
  String? name;
  String? image;
  String? code;

  Payments({this.id, this.image, this.name, this.code});
}

class Coupons {
  int? id;
  String? code;
  String? name;
  String? image;
  String? discount_equation;
  Coupons({this.id, this.image, this.name, this.code, this.discount_equation});
}

class Taxes {
  int? id;
  String? name;
  String? image;
  String? tax_equation;
  Taxes({this.id, this.image, this.name, this.tax_equation});
}
