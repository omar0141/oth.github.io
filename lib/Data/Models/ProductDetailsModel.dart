import 'package:shakosh/Data/Models/ProductModel.dart';

class ProductDetailsModel {
  String? id;
  String? taxId;
  String? dealId;
  String? categoryId;
  String? brandId;
  String? name;
  String? sku;
  String? model;
  String? part_no;
  String? nameAlt;
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
  String? taxEquation;
  String? productGroupId;
  String? brief;
  String? briefAlt;
  String? description;
  String? descriptionAlt;
  String? returnPolicyDesc;
  String? returnPolicyDescAlt;
  String? tech_info;
  String? content_info;
  String? tags;
  late List<dynamic> media;

  ProductDetailsModel(
      {this.id,
      this.taxId,
      this.dealId,
      this.categoryId,
      this.brandId,
      this.sku,
      this.model,
      this.part_no,
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
      this.productGroupId,
      this.brief,
      this.briefAlt,
      this.description,
      this.descriptionAlt,
      this.returnPolicyDesc,
      this.returnPolicyDescAlt,
      this.tags,
      this.content_info,
      this.tech_info,
      required this.media});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    var (myNetPrice, newTaxValue) = ProductModel.calcNetPrice(json);
    double newDiscountValue = ProductModel.calcDiscountValue(json);
    double newStock = ProductModel.calcStock(json);

    id = json['id'];
    taxId = json['tax_id'];
    dealId = json['deal_id'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    sku = json['sku'];
    model = json['model'];
    part_no = json['part_no'];
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
    productGroupId = json['product_group_id'];
    brief = json['brief'];
    briefAlt = json['brief_alt'];
    description = json['description'];
    descriptionAlt = json['description_alt'];
    returnPolicyDesc = json['return_policy_desc'];
    returnPolicyDescAlt = json['return_policy_desc_alt'];
    tags = json['tags'];
    tech_info = json['info_tech'];
    content_info = json['info_content'];
    media = json['media'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_id'] = this.taxId;
    data['deal_id'] = this.dealId;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['sku'] = this.sku;
    data['model'] = this.model;
    data['part_no'] = this.part_no;
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
    data['product_group_id'] = this.productGroupId;
    data['brief'] = this.brief;
    data['brief_alt'] = this.briefAlt;
    data['description'] = this.description;
    data['description_alt'] = this.descriptionAlt;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['return_policy_desc_alt'] = this.returnPolicyDescAlt;
    data['tags'] = this.tags;
    data['info_tech'] = this.tech_info;
    data['info_content'] = this.content_info;
    data['media'] = this.media;
    return data;
  }
}
