class MaleModel {
  late final String name;
  late final String avatar;
  late final int brithday;
  MaleModel({required this.avatar, required this.brithday, required this.name});

  MaleModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    brithday = json['brithday'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'brithday': brithday,
    };
  }
}
