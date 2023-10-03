class ShippingModel {
  late String cityId;
  String? shippingAmount;
  String? items1;
  String? items2;
  String? items3;
  String? items4;

  ShippingModel(
      {required this.cityId,
      this.shippingAmount,
      this.items1,
      this.items2,
      this.items3,
      this.items4});

  ShippingModel.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    shippingAmount = json['shipping_amount'];
    items1 = json['items_1'];
    items2 = json['items_2'];
    items3 = json['items_3'];
    items4 = json['items_4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['shipping_amount'] = this.shippingAmount;
    data['items_1'] = this.items1;
    data['items_2'] = this.items2;
    data['items_3'] = this.items3;
    data['items_4'] = this.items4;
    return data;
  }
}
