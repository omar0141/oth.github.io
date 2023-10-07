class ProductModel {
  String? id;
  String? taxId;
  String? dealId;
  String? categoryId;
  String? brandId;
  late String name;
  late String nameAlt;
  String? thumbnail;
  String? unitMeasure;
  String? unitMeasureAlt;
  late double price;
  late double discountPrice;
  late double minOrderQuantity;
  late double stepOrderQuantity;
  late double maxOrderQuantity;
  late double displayMultiplier;
  late int featured;
  late int perOrder;
  late double visibleStock;
  late double stock;
  String? taxEquation;
  late double cart;
  bool? favourite;

  ProductModel(
      {this.id,
      this.taxId,
      this.dealId,
      this.categoryId,
      this.brandId,
      required this.name,
      required this.nameAlt,
      this.thumbnail,
      this.unitMeasure,
      this.unitMeasureAlt,
      required this.price,
      required this.discountPrice,
      required this.minOrderQuantity,
      required this.stepOrderQuantity,
      required this.maxOrderQuantity,
      required this.displayMultiplier,
      required this.featured,
      required this.perOrder,
      required this.visibleStock,
      required this.stock,
      this.taxEquation,
      required this.cart,
      this.favourite});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxId = json['tax_id'];
    dealId = json['deal_id'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    name = json['name'];
    nameAlt = json['name_alt'];
    thumbnail = json['thumbnail'];
    unitMeasure = json['unit_measure'];
    unitMeasureAlt = json['unit_measure_alt'];
    price = double.parse((json['price'] ?? 0).toString());
    discountPrice = double.parse((json['discount_price'] ?? 0).toString());
    minOrderQuantity =
        double.parse((json['min_order_quantity'] ?? 1).toString());
    stepOrderQuantity =
        double.parse((json['step_order_quantity'] ?? 1).toString());
    maxOrderQuantity = double.parse(
        (json['max_order_quantity'] ?? 999999999999999).toString());
    displayMultiplier =
        double.parse((json['display_multiplier'] ?? 1).toString());
    featured = int.parse((json['featured'] ?? 0).toString());
    perOrder = int.parse((json['per_order'] ?? 0).toString());
    visibleStock = double.parse((json['visible_stock'] ?? 0).toString());
    stock = double.parse((json['stock'] ?? 0).toString());
    taxEquation = json['tax_equation'];
    try {
      cart = json['cart'];
    } catch (e) {
      cart = 0;
    }
    try {
      favourite = json['favourite'];
    } catch (e) {
      favourite = false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_id'] = this.taxId;
    data['deal_id'] = this.dealId;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    data['name_alt'] = this.nameAlt;
    data['thumbnail'] = this.thumbnail;
    data['unit_measure'] = this.unitMeasure;
    data['unit_measure_alt'] = this.unitMeasureAlt;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['min_order_quantity'] = this.minOrderQuantity;
    data['step_order_quantity'] = this.stepOrderQuantity;
    data['max_order_quantity'] = this.maxOrderQuantity;
    data['display_multiplier'] = this.displayMultiplier;
    data['featured'] = this.featured;
    data['per_order'] = this.perOrder;
    data['visible_stock'] = this.visibleStock;
    data['stock'] = this.stock;
    data['tax_equation'] = this.taxEquation;
    data['cart'] = this.cart;
    data['favourite'] = this.favourite;
    return data;
  }
}
