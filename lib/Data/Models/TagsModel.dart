class TagsModel {
  late String id;
  String? tags;

  TagsModel({required this.id, this.tags});

  TagsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tags'] = this.tags;
    return data;
  }
}
