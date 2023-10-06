class ProductDetailsModel {
  String? id;
  String? productGroupId;
  String? categoryId;
  String? brandId;
  String? brief;
  String? briefAlt;
  String? description;
  String? descriptionAlt;
  String? returnPolicyDesc;
  String? returnPolicyDescAlt;
  String? tags;
  late List<dynamic> media;

  ProductDetailsModel(
      {this.id,
      this.productGroupId,
      this.categoryId,
      this.brandId,
      this.brief,
      this.briefAlt,
      this.description,
      this.descriptionAlt,
      this.returnPolicyDesc,
      this.returnPolicyDescAlt,
      this.tags,
      required this.media});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productGroupId = json['product_group_id'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    brief = json['brief'];
    briefAlt = json['brief_alt'];
    description = json['description'];
    descriptionAlt = json['description_alt'];
    returnPolicyDesc = json['return_policy_desc'];
    returnPolicyDescAlt = json['return_policy_desc_alt'];
    tags = json['tags'];
    media = json['media'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['product_group_id'] = this.productGroupId;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['brief'] = this.brief;
    data['brief_alt'] = this.briefAlt;
    data['description'] = this.description;
    data['description_alt'] = this.descriptionAlt;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['return_policy_desc_alt'] = this.returnPolicyDescAlt;
    data['tags'] = this.tags;
    data['media'] = this.media;
    return data;
  }
}
