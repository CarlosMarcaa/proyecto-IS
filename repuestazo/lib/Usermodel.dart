class UserList {
  String? name;
  String? img;
  String? level;

  UserList({this.name, this.img, this.level});

  UserList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    data['level'] = this.level;
    return data;
  }
}




