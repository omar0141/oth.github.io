class OrderModel {
  String? id;
  String? clientId;
  String? paymentMethodId;
  String? status;
  String? couponId;
  String? pickup;
  String? subAmount;
  String? couponAmount;
  String? shippingAmount;
  String? taxAmount;
  String? totalAmount;
  String? addressCountryId;
  String? addressCityId;
  String? addressAreaId;
  String? addressBranchId;
  String? addressName;
  String? addressTelephone1;
  String? addressTelephone2;
  String? addressAddress1;
  String? addressAddress2;
  String? addressCoordinates;
  String? addressNotes;
  String? addstamp;
  String? updatestamp;

  OrderModel(
      {this.id,
      this.clientId,
      this.paymentMethodId,
      this.status,
      this.couponId,
      this.pickup,
      this.subAmount,
      this.couponAmount,
      this.shippingAmount,
      this.taxAmount,
      this.totalAmount,
      this.addressCountryId,
      this.addressCityId,
      this.addressAreaId,
      this.addressBranchId,
      this.addressName,
      this.addressTelephone1,
      this.addressTelephone2,
      this.addressAddress1,
      this.addressAddress2,
      this.addressCoordinates,
      this.addressNotes,
      this.addstamp,
      this.updatestamp});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    paymentMethodId = json['payment_method_id'];
    status = json['status'];
    couponId = json['coupon_id'];
    pickup = json['pickup'];
    subAmount = json['sub_amount'];
    couponAmount = json['coupon_amount'];
    shippingAmount = json['shipping_amount'];
    taxAmount = json['tax_amount'];
    totalAmount = json['total_amount'];
    addressCountryId = json['address_country_id'];
    addressCityId = json['address_city_id'];
    addressAreaId = json['address_area_id'];
    addressBranchId = json['address_branch_id'];
    addressName = json['address_name'];
    addressTelephone1 = json['address_telephone1'];
    addressTelephone2 = json['address_telephone2'];
    addressAddress1 = json['address_address1'];
    addressAddress2 = json['address_address2'];
    addressCoordinates = json['address_coordinates'];
    addressNotes = json['address_notes'];
    addstamp = json['addstamp'];
    updatestamp = json['updatestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['payment_method_id'] = this.paymentMethodId;
    data['status'] = this.status;
    data['coupon_id'] = this.couponId;
    data['pickup'] = this.pickup;
    data['sub_amount'] = this.subAmount;
    data['coupon_amount'] = this.couponAmount;
    data['shipping_amount'] = this.shippingAmount;
    data['tax_amount'] = this.taxAmount;
    data['total_amount'] = this.totalAmount;
    data['address_country_id'] = this.addressCountryId;
    data['address_city_id'] = this.addressCityId;
    data['address_area_id'] = this.addressAreaId;
    data['address_branch_id'] = this.addressBranchId;
    data['address_name'] = this.addressName;
    data['address_telephone1'] = this.addressTelephone1;
    data['address_telephone2'] = this.addressTelephone2;
    data['address_address1'] = this.addressAddress1;
    data['address_address2'] = this.addressAddress2;
    data['address_coordinates'] = this.addressCoordinates;
    data['address_notes'] = this.addressNotes;
    data['addstamp'] = this.addstamp;
    data['updatestamp'] = this.updatestamp;
    return data;
  }
}
