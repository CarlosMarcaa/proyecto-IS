class UserList {
  int? makeID;
  String? makeName;
  int? modelID;
  String? modelName;

  UserList({this.makeID, this.makeName, this.modelID, this.modelName});

  UserList.fromJson(Map<String, dynamic> json) {
    makeID = json['Make_ID'];
    makeName = json['Make_Name'];
    modelID = json['Model_ID'];
    modelName = json['Model_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Make_ID'] = makeID;
    data['Make_Name'] = makeName;
    data['Model_ID'] = modelID;
    data['Model_Name'] = modelName;
    return data;
  }
}
