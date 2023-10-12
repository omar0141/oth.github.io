import 'package:math_expressions/math_expressions.dart';

class ProductModel {
  String? id;
  String? taxId;
  String? dealId;
  String? categoryId;
  String? brandId;
  late String? name;
  late String? nameAlt;
  String? thumbnail;
  String? unitMeasure;
  String? unitMeasureAlt;
  late double price;
  late double netPrice;
  late double discountPrice;
  late double minOrderQuantity;
  late double stepOrderQuantity;
  late double maxOrderQuantity;
  late double displayMultiplier;
  late int featured;
  late int perOrder;
  late double visibleStock;
  late double stock;
  late double discountValue;
  late double taxValue;
  late double quantity;
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
      required this.netPrice,
      required this.discountPrice,
      required this.minOrderQuantity,
      required this.stepOrderQuantity,
      required this.maxOrderQuantity,
      required this.displayMultiplier,
      required this.featured,
      required this.perOrder,
      required this.visibleStock,
      required this.stock,
      required this.discountValue,
      required this.taxValue,
      this.taxEquation,
      required this.cart,
      this.favourite});

  ProductModel.fromJson(Map<String, dynamic> json) {
    var (myNetPrice, newTaxValue) = calcNetPrice(json);
    double newDiscountValue = calcDiscountValue(json);
    double newStock = calcStock(json);
    //
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
    netPrice = myNetPrice;
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
    stock = newStock;
    discountValue = newDiscountValue;
    taxValue = newTaxValue;
    taxEquation = json['tax_equation'];
    try {
      cart = json['cart'];
    } catch (e) {
      cart = 0;
    }
    try {
      quantity = double.parse((json['quantity'] ?? 0).toString());
    } catch (e) {
      quantity = 0;
    }
    try {
      favourite = json['favourite'];
    } catch (e) {
      favourite = false;
    }
  }

  static double calcStock(Map<String, dynamic> json) {
    int newPerOrder = int.parse((json['per_order'] ?? 0).toString());
    double newStock = 0;
    if (newPerOrder == 1) {
      newStock = 999999999999999;
    } else {
      newStock = double.parse((json['stock'] ?? 0).toString());
    }
    return newStock;
  }

  static double calcDiscountValue(Map<String, dynamic> json) {
    double newPrice = double.parse((json['price'] ?? 0).toString());
    double newDiscountPrice =
        double.parse((json['discount_price'] ?? 0).toString());
    double newDiscountValue =
        newPrice - (newDiscountPrice == 0 ? newPrice : newDiscountPrice);
    return newDiscountValue;
  }

  static (double, double) calcNetPrice(Map<String, dynamic> json) {
    // calc tax
    double newTax = 0;
    double newMultiplier =
        double.parse((json['display_multiplier'] ?? 1).toString());
    String? newEquation = json['tax_equation'];
    double newDiscountPrice =
        double.parse((json['discount_price'] ?? 0).toString());
    double newPrice = double.parse((json['price'] ?? 0).toString());
    if (newEquation != null) {
      Parser p = Parser();
      String newtax = newEquation.replaceAll('x',
          '${newDiscountPrice == 0 ? newPrice : newDiscountPrice * newMultiplier}');
      newTax = p.parse(newtax).evaluate(EvaluationType.REAL, ContextModel());
    } else {
      newTax = 0;
    }
    // add tex on net Price
    double myNetPrice = newDiscountPrice == 0
        ? (newPrice + newTax)
        : (newDiscountPrice + newTax);
    return (myNetPrice, newTax);
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
    data['netPrice'] = this.netPrice;
    data['discount_price'] = this.discountPrice;
    data['min_order_quantity'] = this.minOrderQuantity;
    data['step_order_quantity'] = this.stepOrderQuantity;
    data['max_order_quantity'] = this.maxOrderQuantity;
    data['display_multiplier'] = this.displayMultiplier;
    data['featured'] = this.featured;
    data['per_order'] = this.perOrder;
    data['visible_stock'] = this.visibleStock;
    data['stock'] = this.stock;
    data['discountValue'] = this.discountValue;
    data['taxValue'] = this.taxValue;
    data['tax_equation'] = this.taxEquation;
    data['cart'] = this.cart;
    data['favourite'] = this.favourite;
    data['quantity'] = this.quantity;
    return data;
  }
}
