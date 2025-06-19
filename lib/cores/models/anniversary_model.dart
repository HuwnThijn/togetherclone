class AnniversaryModel {
  late final String id;
  late String name;
  late String pathImage;
  late int createTime;
  AnniversaryModel({
    required this.createTime,
    required this.name,
    required this.pathImage,
    required this.id,
  });

  AnniversaryModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createTime = json['createTime'];
    pathImage = json['pathImage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createTime': createTime,
      'pathImage': pathImage,
    };
  }
}
