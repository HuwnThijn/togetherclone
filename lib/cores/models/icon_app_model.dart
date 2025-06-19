class IconAppModel {
  late final String id;
  late final String path;
  late bool isUnlock;

  IconAppModel({
    required this.id,
    required this.path,
    this.isUnlock = false,
  });

  IconAppModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    isUnlock = json['isUnlock'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['isUnlock'] = isUnlock;
    return data;
  }
}
