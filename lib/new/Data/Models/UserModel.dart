class UserModel {
  String? firstName;
  String? lastName;
  String? gender;
  String? birthdate;
  String? telephone;
  String? email;
  String? googleId;
  String? facebookId;
  String? appleId;
  String? addstamp;

  UserModel(
      {this.firstName,
      this.lastName,
      this.gender,
      this.birthdate,
      this.telephone,
      this.email,
      this.googleId,
      this.facebookId,
      this.appleId,
      this.addstamp});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    telephone = json['telephone'];
    email = json['email'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    appleId = json['apple_id'];
    addstamp = json['addstamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    data['google_id'] = this.googleId;
    data['facebook_id'] = this.facebookId;
    data['apple_id'] = this.appleId;
    data['addstamp'] = this.addstamp;
    return data;
  }
}
