class ThanaModel {
  int? id;
  String? image;
  String? title;
  String? dept;
  String? email;
  String? address;
  String? phone;
  String? icon;
  String? url;

  ThanaModel(
      {this.id, this.image, this.title, this.dept, this.email, this.address, this.phone, this.icon, this.url});

  ThanaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    dept = json['dept'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    icon = json['icon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['dept'] = dept;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['icon'] = icon;
    data['url'] = url;
    return data;
  }
}
