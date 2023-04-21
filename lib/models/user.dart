class User{
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? password;
  String? createAt;
  String? updatedAt;

  User({this.id, this.name, this.email, this.mobile, this.password, this.createAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json){
      id = json['id'];
      name = json['name'];
      email = json['email'];
      mobile = json['mobile'];
      password = json['password'];
      createAt = json['created_at'];
      updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['createAt'] = this.createAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}