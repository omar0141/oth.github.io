// ignore_for_file: non_constant_identifier_names, file_names

class Item {
  int? grp_code;
  String? name;
  double? price;
  double qty;
  String? image;
  String? item_no;
  double? qtys;
  double? stock;
  double step = 1;
  double? multiplier;
  String? unit;
  double? discount_price;
  String? detail;
  bool? fav = false;
  String? featured;
  String? per_order;
  bool? error = false;
  String? equation;
  double? tax;
  bool? end_animation = false;
  String? pre_order;
  double min = 1;
  double max = double.infinity;
  Item(
      {this.grp_code,
      this.name,
      this.price,
      required this.qty,
      this.image,
      this.item_no,
      this.qtys,
      required this.step,
      this.stock,
      this.multiplier,
      this.detail,
      this.unit,
      this.discount_price,
      this.fav,
      this.featured,
      this.per_order,
      this.error,
      this.equation,this.tax,this.end_animation,this.pre_order,
      required this.max,
      required this.min
      });
  Map<String, dynamic> toJson() => {
        'grp_code': grp_code,
        'name': name,
        'price': price,
        'qty': qty,
        'image': image,
        'item_no': item_no,
        'qtys': qtys,
        'stock': stock,
        'step': step,
        'multiplier': multiplier,
        'unit': unit,
        'whl_price': discount_price,
        'detail': detail,
        'fav': fav,
        'featured': featured,
        'per_order': per_order,
        'error': error,
      };
}
