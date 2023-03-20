class ThanaModel {
  int? id;
  String? image;
  String? title;
  String? email;
  String? phone;
  String? icon;

  ThanaModel(
      {this.id, this.image, this.title, this.email, this.phone, this.icon});

  ThanaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    email = json['email'];
    phone = json['phone'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['email'] = email;
    data['phone'] = phone;
    data['icon'] = icon;
    return data;
  }
}
